//
//  ACAPIManager.h
//  AimsCareStore
//
//  Created by Adeel Ishaq on 1/11/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACAPIManager : NSObject

@property (copy) void (^completionBlock)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull);
@property (copy) void (^completionBlockArray)(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull);

/*************************************
 ****           APIS            ******
 *************************************/

-(void)postRequestDataWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters token:(NSString*)token completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock ;

-(void)getRequestWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock;

@end





