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
//    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
//    [manager setResponseSerializer:responseSerializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    
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

-(void)getRequestWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters token:(NSString*)token completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock {
 
    [SVProgressHUD show];
    
    self.completionBlock = completionBlock;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];

//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
//    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    
    
//    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"UTF-8"];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"UTF-8", @"text/html", @"application/json", nil];
    
    [manager.requestSerializer setValue:KRestApiKey forHTTPHeaderField:@"Resapi-Key"];

    if (token.length > 0) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    
    [manager GET:methodName parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

