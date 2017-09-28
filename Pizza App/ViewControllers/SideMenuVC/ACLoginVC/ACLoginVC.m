//
//  ACLoginVC.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 12/24/16.
//  Copyright © 2016 finja. All rights reserved.
//

#import "ACLoginVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>

static NSString * const kClientId = @"430658827099-7c718me4iinvagf1l10ml5qmjn2bdn1m.apps.googleusercontent.com";


@interface ACLoginVC () <UITextFieldDelegate, FBSDKLoginButtonDelegate>
{
    STPPaymentContext * paymentContext;
}
@property (nonatomic, weak) IBOutlet UITextField * txtUserName;
@property (nonatomic, weak) IBOutlet UITextField * txtPswd;

@end

@implementation ACLoginVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initiateGoogle];

    // Do any additional setup after loading the view.
    
    //    id<STPBackendAPIAdapter> apiAdapter = [[MyAPIAdapter alloc] init];
    //    self.paymentContext = [[STPPaymentContext alloc] initWithAPIAdapter:apiAdapter];
    //    self.paymentContext.delegate = self;
    //    self.paymentContext.hostViewController = self;
    //    self.paymentContext.paymentAmount = 5000 // This in cents, i.e. $50 USD
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.delegate = self;
//    loginButton.readPermissions =
//    @[@"public_profile", @"email"];
//    // Optional: Place the button in the center of your view.
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.title = @"Sign In";
    
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = KAppTheme_COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],  NSFontAttributeName: ProximaNova_LIGHT(15)}];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(menuAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"menu-icon"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 20.0, 30.0, 20.0);
    [button setContentMode:UIViewContentModeScaleAspectFit];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]
                                   initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = buttonItem;
    
}

-(void)initiateGoogle{
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
//    signIn.shouldFetchGoogleUserEmail = YES;
//    signIn.homeServerClientID = @"430658827099-gpnuj35gasf7h20v0rc6k8oebbi35281.apps.googleusercontent.com";
    signIn.clientID = @"430658827099-gpnuj35gasf7h20v0rc6k8oebbi35281.apps.googleusercontent.com";
    signIn.scopes = @[ kGTLAuthScopePlusLogin,kGTLAuthScopePlusUserinfoProfile ];
    signIn.delegate = self;
}


- (void) menuAction: (id) sender {
    [self.sideMenuViewController presentLeftMenuViewController];
}

-(IBAction)btnSignupAction:(id)sender {
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACSignUpVC"]] animated:NO];
}


-(IBAction)btnLoginAction:(id)sender {
    
    if(_txtUserName.text.length != 0 && _txtPswd.text.length != 0) {
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                _txtUserName.text,@"username",
                                _txtPswd.text, @"password",
                                nil];
        
        ACAPIManager * manager = [ACAPIManager new];
        [manager postRequestDataWithMethodName:@"/customer/login" withParameters:params token:@"" completionBlock:^(NSString *message, NSMutableDictionary *resDict, BOOL isSuccessfull) {
            
        
            if(isSuccessfull) {
                
                [[NSUserDefaults standardUserDefaults] setUserLogin:YES];
                [[NSUserDefaults standardUserDefaults] setToken:[[resDict objectForKey:@"data"] valueForKey:@"token"]];
                [[NSUserDefaults standardUserDefaults] setEmail:[[resDict objectForKey:@"data"] valueForKey:@"email"]];
                [[NSUserDefaults standardUserDefaults] setName:[[resDict objectForKey:@"data"] valueForKey:@"name"]];
                
                
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACHomeVC"]] animated:YES];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:K_Table_Reload object:self];
                
                [FPUtilityFunctions showAlertView:@"" message:@"Successfully Activated" alertType:AlertSuccess];
            }
            else {
                [FPUtilityFunctions showAlertView:@"Error" message:message alertType:AlertFailure];
            }
            
        }];
        
    }
    else {
        [FPUtilityFunctions showAlertView:@"Error" message:@"Please complete all fields" alertType:AlertFailure];
    }
}

- (IBAction)btnFbAction:(id)sender {
    
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    login.loginBehavior = FBSDKLoginBehaviorSystemAccount;
    
    //    [login logOut];
//    [SVProgressHUD show];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [login logInWithReadPermissions:@[@"email",@"public_profile"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
//            [SVProgressHUD dismiss];
            NSLog(@"Process error");
            
        } else if (result.isCancelled) {
//            [SVProgressHUD dismiss];
            NSLog(@"Cancelled");
        } else {
            if ([result.grantedPermissions containsObject:@"email"]) {
                //  Before
                NSString * accessToken = [FBSDKAccessToken currentAccessToken].tokenString;
                
                ;
                
                NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                [parameters setValue:@"id, name, email, first_name, last_name" forKey:@"fields"];
                
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
                {
                    NSLog(@"Fetched user is:%@", result);
                }];
            }
            
            
        }}];

    /*
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            _txtUserName.text,@"email",
                            _txtPswd.text, @"user_id",
                            _txtPswd.text, @"given_name",
                            _txtPswd.text, @"family_name",
                            nil];
    
    ACAPIManager * manager = [ACAPIManager new];
    [manager postRequestDataWithMethodName:@"/customer/authlogin" withParameters:params token:@"" completionBlock:^(NSString *message, NSMutableDictionary *resDict, BOOL isSuccessfull) {
        
        
        if(isSuccessfull) {
            
            [[NSUserDefaults standardUserDefaults] setUserLogin:YES];
            [[NSUserDefaults standardUserDefaults] setToken:[[resDict objectForKey:@"data"] valueForKey:@"token"]];
            [[NSUserDefaults standardUserDefaults] setEmail:[[resDict objectForKey:@"data"] valueForKey:@"email"]];
            [[NSUserDefaults standardUserDefaults] setName:[[resDict objectForKey:@"data"] valueForKey:@"name"]];
            
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACHomeVC"]] animated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:K_Table_Reload object:self];
            
            [FPUtilityFunctions showAlertView:@"" message:@"Successfully Activated" alertType:AlertSuccess];
        }
        else {
            [FPUtilityFunctions showAlertView:@"Error" message:message alertType:AlertFailure];
        }
        
    }];
    */
}

- (IBAction)btnGoogleAction:(id)sender {
    
//    [[GPPSignIn sharedInstance]signOut];
    [[GPPSignIn sharedInstance]authenticate];
}

//#pragma mark - StripePaymentMethod
//- (void)paymentContextDidChange:(STPPaymentContext *)paymentContext {
//    self.activityIndicator.animating = paymentContext.loading;
//    self.paymentButton.enabled = paymentContext.selectedPaymentMethod != nil;
//    self.paymentLabel.text = paymentContext.selectedPaymentMethod.label;
//    self.paymentIcon.image = paymentContext.selectedPaymentMethod.image;
//}
//
//- (void)paymentContext:(STPPaymentContext *)paymentContext
//didCreatePaymentResult:(STPPaymentResult *)paymentResult
//            completion:(STPErrorBlock)completion {
//    [self.apiClient createCharge:paymentResult.source.stripeID completion:^(NSError *error) {
//        if (error) {
//            completion(error);
//        } else {
//            completion(nil);
//        }
//    }];
//}
//
//-(void)paymentContext:(STPPaymentContext *)paymentContext
//didFinishWithStatus:(STPPaymentStatus)status
//error:(NSError *)error {
//    switch (status) {
//        case STPPaymentStatusSuccess:
//            [self showReceipt];
//        case STPPaymentStatusError:
//            [self showError:error];
//        case STPPaymentStatusUserCancellation:
//            return; // Do nothing
//    }
//}
//
//- (void)paymentContext:(STPPaymentContext *)paymentContext didFailToLoadWithError:(NSError *)error {
//    [self.navigationController popViewControllerAnimated:YES];
//    // Show the error to your user, etc.
//}
//
//
//- (void)paymentContext:(STPPaymentContext *)paymentContext didUpdateShippingAddress:(STPAddress *)address completion:(STPShippingMethodsCompletionBlock)completion {
//    PKShippingMethod *upsGround = [PKShippingMethod new];
//    upsGround.amount = [NSDecimalNumber decimalNumberWithString:@"0"];
//    upsGround.label = @"UPS Ground";
//    upsGround.detail = @"Arrives in 3-5 days";
//    upsGround.identifier = @"ups_ground";
//    PKShippingMethod *fedEx = [PKShippingMethod new];
//    fedEx.amount = [NSDecimalNumber decimalNumberWithString:@"5.99"];
//    fedEx.label = @"FedEx";
//    fedEx.detail = @"Arrives tomorrow";
//    fedEx.identifier = @"fedex";
//    if ([address.country isEqualToString:@"US"]) {
//        completion(STPShippingStatusValid, nil, @[upsGround, fedEx], upsGround);
//    }
//    else {
//        completion(STPShippingStatusInvalid, nil, nil, nil);
//    }
//}

- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error {
    
    NSLog(@"%@",result.debugDescription);
}

#pragma mark - Google Login events
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error: (NSError *) error{
    GTLPlusPerson *person = [GPPSignIn sharedInstance].googlePlusUser;
    if (person == nil) {
        [SVProgressHUD dismiss];
        return;
    }
    if (error){
        [SVProgressHUD dismiss];
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Google Error!" message:@"There is an Error While Signing in with Google." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
    else{
        NSString *serverCode = [GPPSignIn sharedInstance].homeServerAuthorizationCode;
        if(serverCode){

            ;
        }else{
            [SVProgressHUD dismiss];
        }
    }
}


@end
