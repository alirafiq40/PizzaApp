//
//  NSUserDefaults+Extensions.m
//  Kafaah
//
//  Created by Muhammad Ahsan on 15/04/2016.
//  Copyright © 2016 Muhammad Ahsan. All rights reserved.
//

#import "NSUserDefaults+Extensions.h"

NSString * const KFCategoryID = @"KFCategoryID";
NSString * const KFCategoryTitle = @"KFCategoryTitle";
NSString * const KFAddressArray = @"KFAddressArray";

NSString * const KFName = @"KFName";
NSString * const KFEmail = @"KFEmail";
NSString * const KFPswd = @"KFPswd";
NSString * const KFToken = @"KFToken";


NSString * const KFPhoneNumber = @"KFPhoneNumber";
NSString * const KFAddress = @"KFAddress";
NSString * const KFLoginStatus = @"KFLoginStatus";
NSString * const KFUserID = @"KFUserID";


@implementation NSUserDefaults (Extensions)

- (NSString*)categoryID  {
    return [self valueForKey:KFCategoryID];
}

- (void)setCategoryID:(NSString*)categoryID {
    [self setValue:categoryID forKey:KFCategoryID];
    [self synchronize];
}

- (NSString*)categoryTitle  {
    return [self valueForKey:KFCategoryTitle];
}

- (void)setCategoryTitle:(NSString*)categoryTitle {
    [self setValue:categoryTitle forKey:KFCategoryTitle];
    [self synchronize];
}

//addressArray
- (NSMutableArray*)addressArray  {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:KFAddressArray];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];

  //  return [arr mutableCopy];
    
//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KFAddressArray];
//    NSMutableArray  * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    return array;
    
    //return [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:KFAddressArray]];

}

- (void)setAddressArray:(NSMutableArray*)addressArray {
 //   NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];

//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:addressArray];
//    [self setObject:data forKey:KFAddressArray];
//    [self synchronize];

//   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *arr = ... ; // set value
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:addressArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:KFAddressArray];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    [self setValue:addressArray forKey:KFAddressArray];
//    [self synchronize];
}

/*************************************
 ****      Login & Sign Up      ******
 *************************************/

- (BOOL)isUserLogin {
    return [self valueForKey:KFLoginStatus];
}
- (void)setUserLogin:(BOOL)status {
    [self setBool:status forKey:KFLoginStatus];
    [self synchronize];
}

- (NSString*)name {
    return [self valueForKey:KFName];
}
- (void)setName:(NSString*)name  {
    [self setValue:name forKey:KFName];
    [self synchronize];
}

- (NSString*)email {
    return [self valueForKey:KFEmail];
}
- (void)setEmail:(NSString*)email  {
    [self setValue:email forKey:KFEmail];
    [self synchronize];
}

- (NSString*)token {
    return [self valueForKey:KFToken];
}

- (void)setToken:(NSString*)token {
    [self setValue:token forKey:KFToken];
    [self synchronize];
}



//- (NSString*)pswd {
//    return [self valueForKey:KFPswd];
//}
//- (void)setPswd:(NSString*)pswd  {
//    [self setValue:pswd forKey:KFPswd];
//    [self synchronize];
//}
//
//
//- (NSString*)phoneNumber {
//    return [self valueForKey:KFPhoneNumber];
//}
//- (void)setPhoneNumber:(NSString*)phoneNumber  {
//    [self setValue:phoneNumber forKey:KFPhoneNumber];
//    [self synchronize];
//}
//
//
//- (NSString*)address {
//    return [self valueForKey:KFAddress];
//}
//
//- (void)setAddress:(NSString*)address  {
//    [self setValue:address forKey:KFAddress];
//    [self synchronize];
//}
//
//- (NSString*)userID {
//    return [self valueForKey:KFUserID];
//}
//
//- (void)setUserID:(NSString*)userID  {
//    [self setValue:userID forKey:KFUserID];
//    [self synchronize];
//}


@end



