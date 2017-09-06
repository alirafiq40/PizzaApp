//
//  Constants.h
//  Finca
//
//  Created by BDP on 6/28/16.
//  Copyright © 2016 Finja. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//User Roles
#define K_NO_ROLE 0
#define K_Account_ROLE 1
#define K_Wallet_ROLE 2
#define K_BOTH_ROLE 3

#define K_Table_Reload @"K_Table_Reload"
#define ATM_DETAILS_FILE @"ATM_Details.csv"
#define BRANCH_DETAILS_FILE @"Branches_Details.csv"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE4          (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)

#define KSCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define KSCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//Strings

#define EMPTY_STRING @""

//Check system Version IOS

#define SYSTEM_VERSION_EQUAL_TO(v)            ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



#define IPHONE5_FRAME CGRectMake(0, 0, 320, 568)
#define IPHONE4_FRAME CGRectMake(0, 0, 320, 480)

#define IMAGE_SELECTED_ADDRESS_DROPDOWN [UIImage imageNamed:@"address_dropdown_cell_c@2x.png"]
#define IMAGE_UNSELECTED_ADDRESS_DROPDOWN [UIImage imageNamed:@"address_dropdown_cell@2x.png"]

//Color
#define KAppTheme_COLOR [UIColor colorWithRed:13.0/255. green:33.0/255. blue:77.0/255. alpha:1.0]
#define KGREY_COLOR [UIColor colorWithRed:130.0/255. green:130.0/255. blue:130.0/255. alpha:1.0]
#define KRED_COLOR [UIColor colorWithRed:162.0/255. green:0.0/255. blue:40.0/255. alpha:1.0]
#define KCream_COLOR [UIColor colorWithRed:228.0/255. green:224.0/255. blue:224.0/255. alpha:1.0]
#define KGREEN_COLOR [UIColor colorWithRed:37.0/255. green:136.0/255. blue:56.0/255. alpha:1.0]

//Fonts
#define ProximaNova_BOLD(theFontSize) [UIFont fontWithName:@"HelveticaNeue" size:(theFontSize)]
#define ProximaNova_LIGHT(theFontSize) [UIFont fontWithName:@"HelveticaNeue" size:(theFontSize)]

//Random Number
#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))


#define KBaseURL @"http://www.aimscareadmin.com/api/"

#endif /* Constants_h */
