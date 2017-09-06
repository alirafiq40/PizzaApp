//
//  FPUtilityFunctions.m
//  Finca
//
//  Created by BDP on 6/28/16.
//  Copyright © 2016 Finja. All rights reserved.
//

#import "FPUtilityFunctions.h"

enum {
    wallet = 0,
    account = 1,
}accoutType;


@implementation FPUtilityFunctions

+(void)showLogInScreen_LoginStatus:(BOOL)loginStatus {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //   FPLoginVC *rootViewController = (FPLoginVC*)[storyboard instantiateViewControllerWithIdentifier:@"rootController"];
    UIViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"rootController"];
    [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];
}

+(void)showAlertView:(NSString *)title message:(NSString *)message alertType:(AlertType)alertType
{
    if([message isKindOfClass:[NSNull class]]) {
        message = @"";
    }

    AMSmoothAlertView *alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:title andText:message andCancelButton:NO forAlertType:alertType];
    [alert.defaultButton setTitle:@"OK" forState:UIControlStateNormal];
    [alert setTitleFont:ProximaNova_LIGHT(18)];
    alert.cornerRadius = 3.0f;
    [alert show];
}

+(void)showWriteUpMessage:(NSString*)title message:(NSString *)message {
    if([message isKindOfClass:[NSNull class]]) {
        message = @"";
    }

//    AMSmoothAlertView *alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:title andText:message andCancelButton:NO forAlertType:alertType];
//    [alert.defaultButton setHidden:TRUE];
//    [alert setTitleFont:ProximaNova_LIGHT(18)];
//    alert.cornerRadius = 3.0f;
//    [alert show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.0f
                         animations:^{
                          //   [alert setAlpha:0.0f];
                         } completion:^(BOOL finished) {
                        //     [alert dismissAlertView];
                         }];
    });
}


+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



+ (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}



@end



