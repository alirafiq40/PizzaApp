//
//  NSUserDefaults+Extensions.h
//  Kafaah
//
//  Created by Muhammad Ahsan on 15/04/2016.
//  Copyright © 2016 Muhammad Ahsan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extensions)

- (NSString*)categoryID;
- (void)setCategoryID:(NSString*)categoryID;

- (NSString*)categoryTitle;
- (void)setCategoryTitle:(NSString*)categoryTitle;

//addressArray
- (NSMutableArray*)addressArray;
- (void)setAddressArray:(NSMutableArray*)addressArray;


/*************************************
 ****      Login & Sign Up      ******
 *************************************/

- (BOOL)isUserLogin;
- (void)setUserLogin:(BOOL)status;

- (NSString*)userName;
- (void)setUserName:(NSString*)userName;

- (NSString*)email;
- (void)setEmail:(NSString*)email;

- (NSString*)pswd;
- (void)setPswd:(NSString*)pswd;

- (NSString*)phoneNumber;
- (void)setPhoneNumber:(NSString*)phoneNumber;

- (NSString*)address;
- (void)setAddress:(NSString*)address;

- (NSString*)userID;
- (void)setUserID:(NSString*)userID;
@end

