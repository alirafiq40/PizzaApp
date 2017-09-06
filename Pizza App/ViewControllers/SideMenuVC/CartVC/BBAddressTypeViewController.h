//
//  BBAddressTypeViewController.h
//  BriskBiz
//
//  Created by Rafay on 9/23/15.
//  Copyright (c) 2015 Rafay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBAddressTypeViewController;
@protocol BBAddressTypeViewControllerDelagate<NSObject>

-(void)setTextAddressType: (NSString*)addresstype;

@end

@interface BBAddressTypeViewController : UIViewController

@property (nonatomic, weak) id <BBAddressTypeViewControllerDelagate> delegate;
@property (nonatomic,retain) NSString *addressTypeSelected;
@end
