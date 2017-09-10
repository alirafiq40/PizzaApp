//
//  ACSignUpVC.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 1/15/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import "ACSignUpVC.h"
#import "ACAPIManager.h"

@interface ACSignUpVC () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField * txtUserName;
@property (nonatomic, weak) IBOutlet UITextField * txtPswd;
@property (nonatomic, weak) IBOutlet UITextField * txtEmail;
@property (nonatomic, weak) IBOutlet UITextField * txtPHoneNumber;
@property (nonatomic, weak) IBOutlet UITextField * txtAddress;

@end

@implementation ACSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    self.title = @"Sign Up";

    for(id aSubView in [self.view subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)aSubView;
            textField.layer.borderColor=[KAppTheme_COLOR CGColor];
            textField.layer.borderWidth=1.0;
            textField.layer.cornerRadius = 3;
            textField.clipsToBounds      = YES;
            textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
            
            textField.layer.shadowColor = [KAppTheme_COLOR CGColor];
            textField.layer.shadowRadius = 1.0f;
            textField.layer.shadowOpacity = .9;
            textField.layer.shadowOffset = CGSizeZero;
            textField.layer.masksToBounds = NO;
            textField.delegate = self;
        }
    }

    
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


-(IBAction)btnLoginAction:(id)sender {
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACLoginVC"]] animated:NO];
}

-(IBAction)btnSignUpAction:(id)sender {
    if(_txtUserName.text.length != 0 && _txtPswd.text.length != 0 && _txtEmail.text.length != 0 && _txtPHoneNumber.text.length != 0 && _txtAddress.text.length != 0) {
        
        ACAPIManager * manager = [ACAPIManager new];
        [manager signUp:_txtUserName.text email_value:_txtEmail.text password:_txtPswd.text profile_pic:@"" address:_txtAddress.text phoneNumber:_txtPHoneNumber.text completionBlock:^(NSString *message, NSMutableDictionary *resDict, BOOL isSuccessfull) {
            
            if(isSuccessfull) {
                
                
                [[NSUserDefaults standardUserDefaults] setUserLogin:YES];
                [[NSUserDefaults standardUserDefaults] setUserID:[[resDict objectForKey:@"user"] valueForKey:@"id"]];
                [[NSUserDefaults standardUserDefaults] setEmail:[[resDict objectForKey:@"user"] valueForKey:@"user_email"]];
                [[NSUserDefaults standardUserDefaults] setUserName:[[resDict objectForKey:@"user"] valueForKey:@"user_name"]];
                [[NSUserDefaults standardUserDefaults] setPswd:[[resDict objectForKey:@"user"] valueForKey:@"user_password"]];

                
                [[NSUserDefaults standardUserDefaults] setAddress:_txtAddress.text];
                [[NSUserDefaults standardUserDefaults] setPhoneNumber:_txtPHoneNumber.text];
                
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

@end
