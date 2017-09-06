//
//  ACCartBuyVC.h
//  AimsCareStore
//
//  Created by Adeel Ishaq on 1/31/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACCartBuyVC : UIViewController
{
    NSMutableArray *addressArray;
}
@property (nonatomic, strong) IBOutlet UIButton *addressButton;
@property (strong, nonatomic) IBOutlet UILabel *lblMyAddress;

@end
