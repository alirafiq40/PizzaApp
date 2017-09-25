//
//  ACLoginVC.h
//  AimsCareStore
//
//  Created by Adeel Ishaq on 12/24/16.
//  Copyright © 2016 finja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import <GooglePlus/GooglePlus.h>
#import <CoreMotion/CoreMotion.h>

@class GPPSignInButton;
@import Stripe;

@interface ACLoginVC : UIViewController <STPPaymentContextDelegate, GPPSignInDelegate>

@end
