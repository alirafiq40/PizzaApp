//
//  ACCartSingeltonManager.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 1/24/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import "ACCartSingeltonManager.h"

@implementation ACCartSingeltonManager

static ACCartSingeltonManager *_sharedManagerInstace;

+ (ACCartSingeltonManager *) sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedManagerInstace = [[ACCartSingeltonManager alloc] init];
        
    });
    return  _sharedManagerInstace;
}

-(void)setup{
}

@end
