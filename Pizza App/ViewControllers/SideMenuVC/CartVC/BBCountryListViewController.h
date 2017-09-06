//
//  BBCountryListViewController.h
//  BriskBiz
//
//  Created by Rafay on 9/23/15.
//  Copyright (c) 2015 Rafay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBCountryListViewController;

@protocol BBCountryListViewControllerDelegate<NSObject>
- (void)setText:(NSString*)country;
@end

@interface BBCountryListViewController : UIViewController

@property (nonatomic, weak) id <BBCountryListViewControllerDelegate> delegate;

@end
