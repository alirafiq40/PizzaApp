//
//  ACAPIManager.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 1/11/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import "ACAPIManager.h"

@implementation ACAPIManager

#pragma mark -  allCategoriesList

-(void)postRequestDataWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters token:(NSString*)token completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock {
    
    [SVProgressHUD show];
    
    self.completionBlock = completionBlock;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager.requestSerializer setValue:KRestApiKey forHTTPHeaderField:@"Resapi-Key"];
    
    if (token.length > 0) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }

    [manager POST:methodName parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SVProgressHUD dismiss];

        if([responseObject objectForKey:@"error"]) {
            self.completionBlock ([responseObject objectForKey:@"error"],nil,NO);
        }
        else {
            self.completionBlock (responseObject,responseObject,YES);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlock (error.localizedDescription,nil,NO);
    }];
}

-(void)getRequestWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock {
 
    [SVProgressHUD show];
    
    self.completionBlock = completionBlock;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager.requestSerializer setValue:KRestApiKey forHTTPHeaderField:@"Resapi-Key"];

    [manager GET:methodName parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SVProgressHUD dismiss];
        
        if([responseObject objectForKey:@"error"]) {
            self.completionBlock ([responseObject objectForKey:@"error"],nil,NO);
        }
        else {
            self.completionBlock (responseObject,responseObject,YES);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlock (error.localizedDescription,nil,NO);
    }];
}


@end

