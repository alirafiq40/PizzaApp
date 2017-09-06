//
//  Address.m
//  
//
//  Created by Rafay on 9/23/15.
//
//

#import "Address.h"


@implementation Address

@synthesize addressId;
@synthesize adressType;
@synthesize city;
@synthesize country;
@synthesize isActive;
@synthesize phoneNo;
@synthesize postalCode;
@synthesize street1;
@synthesize street2;
@synthesize myOrder;



#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.addressId = [decoder decodeObjectForKey:@"addressId"];
    self.adressType = [decoder decodeObjectForKey:@"adressType"];
    self.city = [decoder decodeObjectForKey:@"city"];
    self.country = [decoder decodeObjectForKey:@"country"];
    self.isActive = [decoder decodeObjectForKey:@"isActive"];
    self.phoneNo = [decoder decodeObjectForKey:@"phoneNo"];
    self.postalCode = [decoder decodeObjectForKey:@"postalCode"];
    self.street1 = [decoder decodeObjectForKey:@"street1"];
    self.street2 = [decoder decodeObjectForKey:@"street2"];
    self.myOrder = [decoder decodeObjectForKey:@"myOrder"];


    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.addressId forKey:@"addressId"];
    [encoder encodeObject:self.adressType forKey:@"adressType"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.country forKey:@"country"];
    [encoder encodeObject:[self isActive] forKey:@"isActive"];
    [encoder encodeObject:self.phoneNo forKey:@"phoneNo"];
    [encoder encodeObject:self.postalCode forKey:@"postalCode"];
    [encoder encodeObject:street1 forKey:@"street1"];
    [encoder encodeObject:self.street2 forKey:@"street2"];
    [encoder encodeObject:self.myOrder forKey:@"myOrder"];

}

-(NSString *)getFullAddress
{
    NSString *temp = @"";
    if(self.street1)
    {
        temp=[temp stringByAppendingString:self.street1];
        temp=[temp stringByAppendingString:@", "];
    }
    if(self.street2)
    {
        temp=[temp stringByAppendingString:self.street2];
        temp=[temp stringByAppendingString:@"\n"];
    }
    if(self.city)
    {
        temp=[temp stringByAppendingString:self.city];
        
    }
    if(self.postalCode)
    {
        temp=[temp stringByAppendingString:[NSString stringWithFormat:@" %@", self.postalCode]];
        temp=[temp stringByAppendingString:@", "];
    }
    if(self.country)
    {
        temp=[temp stringByAppendingString:self.country];
        temp=[temp stringByAppendingString:@"."];
    }
    
    return temp;
}

-(NSString *)getDeliveryAddress
{
    NSString *temp = @"";
    if(self.street1)
    {
        temp=[temp stringByAppendingString:self.street1];
        temp=[temp stringByAppendingString:@", "];
    }
    if(self.street2)
    {
        temp=[temp stringByAppendingString:self.street2];
    }
    
    return temp;
}

/*

+(Address*)AddressWithStreet1 :(NSString*)street1 Street2 :(NSString*)street2 City :(NSString*)city PostalCode :(int)postalCode Country :(NSString*)country isActiveAddress :(BOOL)isActive AddressType :(NSString*)addressType PhoneNo :(NSString*)phoneNo
{
    Address *objAddress = (Address*)[Address create];
    objAddress.addressId = [NSNumber numberWithInt:[self maxID]+1];
    
    objAddress.street1 = street1;
    objAddress.street2 = street2;
    objAddress.city = city;
    objAddress.postalCode = [NSNumber numberWithInt:postalCode];
    objAddress.country = country;
    
    if (isActive) {
        for (Address *objAddress in [self all:nil]) {
            objAddress.isActive = [NSNumber numberWithBool:NO];
        }
    }
    objAddress.isActive = [NSNumber numberWithBool:isActive];
    objAddress.adressType = addressType;
    objAddress.phoneNo = phoneNo;
    

    return objAddress;
}
-(NSString *)getFullAddress
{
    NSString *temp = @"";
    if(self.street1)
    {
        temp=[temp stringByAppendingString:self.street1];
        temp=[temp stringByAppendingString:@", "];
    }
    if(self.street2)
    {
        temp=[temp stringByAppendingString:self.street2];
        temp=[temp stringByAppendingString:@"\n"];
    }
    if(self.city)
    {
        temp=[temp stringByAppendingString:self.city];
        
    }
    if(self.postalCode)
    {
        temp=[temp stringByAppendingString:[NSString stringWithFormat:@" %@", self.postalCode]];
        temp=[temp stringByAppendingString:@", "];
    }
    if(self.country)
    {
        temp=[temp stringByAppendingString:self.country];
        temp=[temp stringByAppendingString:@"."];
    }
    
    return temp;
}

-(NSString *)getDeliveryAddress
{
    NSString *temp = @"";
    if(self.street1)
    {
        temp=[temp stringByAppendingString:self.street1];
        temp=[temp stringByAppendingString:@", "];
    }
    if(self.street2)
    {
        temp=[temp stringByAppendingString:self.street2];
    }
    
    return temp;
}
*/

@end
