//
//  Address.h
//  
//
//  Created by Rafay on 9/23/15.
//
//

#import <Foundation/Foundation.h>

//@class MyOrder;

@interface Address : NSObject

@property (nonatomic, strong) NSNumber * addressId;
@property (nonatomic, strong) NSString * adressType;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * country;
@property (nonatomic, strong) NSNumber * isActive;
@property (nonatomic, strong) NSString * phoneNo;
@property (nonatomic, strong) NSNumber * postalCode;
@property (nonatomic, strong) NSString * street1;
@property (nonatomic, strong) NSString * street2;
@property (nonatomic, strong) NSSet *myOrder;

-(NSString *)getFullAddress;
-(NSString *)getDeliveryAddress;

@end

//@interface Address (CoreDataGeneratedAccessors)
//
//
//
//+(int)maxID;
//
//+(Address*)AddressWithStreet1 :(NSString*)street1 Street2 :(NSString*)street2 City :(NSString*)city PostalCode :(int)postalCode Country :(NSString*)country isActiveAddress :(BOOL)isActive AddressType :(NSString*)addressType PhoneNo:(NSString*)phoneNo;

//@end
