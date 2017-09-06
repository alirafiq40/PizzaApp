//
//  FPUtilityFunctions.h
//  Finca
//
//  Created by BDP on 6/28/16.
//  Copyright © 2016 Finja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMSmoothAlertConstants.h"


@interface FPUtilityFunctions : NSObject

+(void)showLogInScreen_LoginStatus:(BOOL)loginStatus;
+(void)showAlertView:(NSString *)title message:(NSString *)message alertType:(AlertType)alertType;
+(void)showWriteUpMessage:(NSString*)title message:(NSString *)message  alertType:(AlertType)alertType;
+ (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock;
@end
