//
//  ACForgotVC.m
//  Pizza App
//
//  Created by Adeel Ishaq on 9/17/17.
//  Copyright © 2017 Adeel Ishaq. All rights reserved.
//

#import "ACForgotVC.h"

@interface ACForgotVC ()

@property (nonatomic, weak) IBOutlet UITextField * txtEmail;

@end

@implementation ACForgotVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Forgot Password";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnForgotAction:(id)sender {
    
    if(_txtEmail.text.length != 0) {
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                _txtEmail.text, @"email",
                                nil];
        
        ACAPIManager * manager = [ACAPIManager new];
        [manager postRequestDataWithMethodName:@"/customer/forgotpassword" withParameters:params token:@"" completionBlock:^(NSString *message, NSMutableDictionary *resDict, BOOL isSuccessfull) {
            
            
            if(isSuccessfull) {
                
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACLoginVC"]] animated:YES];
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
