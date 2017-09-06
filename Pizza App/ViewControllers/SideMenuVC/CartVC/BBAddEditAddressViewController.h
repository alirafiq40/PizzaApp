//
//  BBAddEditAddressViewController.h
//  BriskBiz
//
//  Created by Rafay on 9/23/15.
//  Copyright (c) 2015 Rafay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
#import "UIView+ParentCell.h"
#import "BBCountryListViewController.h"
#import "BBAddressTypeViewController.h"



@interface BBAddEditAddressViewController : UIViewController
<
UITextFieldDelegate,BBCountryListViewControllerDelegate,BBAddressTypeViewControllerDelagate
>
{
    NSMutableArray *addressArray;
    NSString *count;
    BOOL isAddNewCell;
    UITextField *activeTextField;
    
    
    NSCharacterSet *cityInptCharacters;
}

@property (strong, nonatomic) IBOutlet UITableView *tblAddress;


//-(void)setTextCountry :(NSString*)country;
//-(void)setTextbtnAddressType : (NSString*)addressType;
//

@end
