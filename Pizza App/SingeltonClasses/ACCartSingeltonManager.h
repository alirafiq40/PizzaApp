//
//  ACCartSingeltonManager.h
//  AimsCareStore
//
//  Created by Adeel Ishaq on 1/24/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACCartSingeltonManager : NSObject
{
    
}
+ (ACCartSingeltonManager *) sharedManager;

-(void)setup;

@property (nonatomic ,strong ) NSMutableDictionary * dictCartProducts;
@property (nonatomic ,strong ) NSMutableArray * arrMenu;

@end
