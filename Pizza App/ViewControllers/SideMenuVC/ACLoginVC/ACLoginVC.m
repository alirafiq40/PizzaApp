//
//  ACLoginVC.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 12/24/16.
//  Copyright © 2016 finja. All rights reserved.
//

#import "ACLoginVC.h"

@interface ACLoginVC () <UITextFieldDelegate>
{
    STPPaymentContext * paymentContext;
}
@property (nonatomic, weak) IBOutlet UITextField * txtUserName;
@property (nonatomic, weak) IBOutlet UITextField * txtPswd;

@end

@implementation ACLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    id<STPBackendAPIAdapter> apiAdapter = [[MyAPIAdapter alloc] init];
    //    self.paymentContext = [[STPPaymentContext alloc] initWithAPIAdapter:apiAdapter];
    //    self.paymentContext.delegate = self;
    //    self.paymentContext.hostViewController = self;
    //    self.paymentContext.paymentAmount = 5000 // This in cents, i.e. $50 USD
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

}

- (IBAction)btnGoogleAction:(id)sender {
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


@end
