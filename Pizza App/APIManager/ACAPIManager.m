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
-(void)allCategoriesList:(void(^)(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull))completionBlockArray {
    [SVProgressHUD show];
    
    self.completionBlockArray = completionBlockArray;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:@"categories" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        self.completionBlockArray (@"",responseObject,YES);
        [SVProgressHUD dismiss];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlockArray (error.localizedDescription,nil,NO);
    }];
}

#pragma mark -  specificCategory
-(void)specificCategory:(NSString*)categoryID completionBlock:(void(^)(NSString *message, NSMutableArray * resArr, BOOL isSuccessfull))completionBlockArray {
    [SVProgressHUD show];
    
    self.completionBlockArray = completionBlockArray;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:[NSString stringWithFormat:@"subcategories/%@",categoryID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        self.completionBlockArray (@"",responseObject,YES);
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlockArray (error.localizedDescription,nil,NO);
    }];
}

#pragma mark -  allSubCategoriesList
-(void)allSubCategoriesList:(void(^)(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull))completionBlockArray  {
    [SVProgressHUD show];
    
    self.completionBlockArray = completionBlockArray;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:@"http://store.loop.pk/api/categories" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *resArr = [NSMutableArray new];

        
        self.completionBlockArray ([responseObject objectForKey:@"msg"],resArr,YES);
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlockArray (error.localizedDescription,nil,NO);
    }];
}

#pragma mark -  specificSubCategory
-(void)completionBlockArray:(NSString*)categoryID completionBlock:(void(^)(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull))completionBlockArray  {
    [SVProgressHUD show];
    
    self.completionBlockArray = completionBlockArray;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:@"http://store.loop.pk/api/categories" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *resArr = [NSMutableArray new];

        self.completionBlockArray ([responseObject objectForKey:@"msg"],resArr,YES);
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlockArray (error.localizedDescription,nil,NO);
    }];
}

#pragma mark -  specificSubCategoryObject
-(void)specificSubCategoryObject:(NSString*)categoryID subCategoryIDObject:(NSString*)subCategoryIDObject completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDic, BOOL isSuccessfull))completionBlock  {
    [SVProgressHUD show];
    
    self.completionBlock = completionBlock;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:@"http://store.loop.pk/api/categories" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        self.completionBlock ([responseObject objectForKey:@"msg"],responseObject,YES);
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlock (error.localizedDescription,nil,NO);
    }];
}

#pragma mark -  allProductsList
-(void)allProductsList:(void(^)(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull))completionBlockArray  {
    [SVProgressHUD show];
    
    self.completionBlockArray = completionBlockArray;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:@"products" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.completionBlockArray (@"",responseObject,YES);
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlockArray (error.localizedDescription,nil,NO);
    }];
}

#pragma mark -  allProductsListCategory
-(void)allProductsListCategory:(NSString*)categoryID completionBlock:(void(^)(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull))completionBlockArray  {
    [SVProgressHUD show];
    
    self.completionBlockArray = completionBlockArray;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:@"http://store.loop.pk/api/categories" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *resArr = [NSMutableArray new];

        self.completionBlockArray ([responseObject objectForKey:@"msg"],resArr,YES);
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlockArray (error.localizedDescription,nil,NO);
    }];
}

#pragma mark -  allProductsListSubCategory
-(void)allProductsListSubCategory:(NSString*)categoryID subCategoryIDObject:(NSString*)subCategoryIDObject completionBlock:(void(^)(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull))completionBlockArray  {
    [SVProgressHUD show];
    
    self.completionBlockArray = completionBlockArray;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:[NSString stringWithFormat:@"products/%@/%@",categoryID,subCategoryIDObject] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.completionBlockArray (@"",responseObject,YES);
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlockArray (error.localizedDescription,nil,NO);
    }];
}

#pragma mark -  specificProductObject
-(void)allProductsListCategory:(NSString*)categoryID subCategoryIDObject:(NSString*)subCategoryIDObject priductID:(NSString*)priductID completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock  {
    [SVProgressHUD show];
    
    self.completionBlock = completionBlock;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:@"http://store.loop.pk/api/categories" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        self.completionBlock ([responseObject objectForKey:@"msg"],responseObject,YES);
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlock (error.localizedDescription,nil,NO);
    }];
}



/*************************************
 *******      Order Work      ********
 *************************************/

#pragma mark -  get order from order id

-(void)getOrderFromOrderID:(NSString*)order_id completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock {
    [SVProgressHUD show];
    
    self.completionBlock = completionBlock;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:[NSString stringWithFormat:@"orders/id/%@",order_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        self.completionBlock ([responseObject objectForKey:@"msg"],responseObject,YES);
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlock (error.localizedDescription,nil,NO);
    }];
}


#pragma mark -  get order from order id

-(void)getUsersOrderFromUserID:(NSString*)user_id completionBlock:(void(^)(NSString *message, NSArray * resDict, BOOL isSuccessfull))completionBlock {
    [SVProgressHUD show];
    
    self.completionBlockArray = completionBlock;
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:[NSString stringWithFormat:@"orders/user_id/%@",user_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        self.completionBlockArray (@"",responseObject,YES);
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlockArray (error.localizedDescription,nil,NO);
    }];
}

#pragma mark -  post Order

-(void)postOrder:(NSMutableDictionary*)order totalPrice:(NSString*)totalPrice address:(NSString*)address phone:(NSString*)phone completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock {
    [SVProgressHUD show];
    
    self.completionBlock = completionBlock;
    
    
//    NSMutableDictionary * postDict = [NSMutableDictionary new];
    
    NSMutableArray * myArray = [NSMutableArray new];
    
    for (NSString * key in order.allKeys) {
        
        NSMutableDictionary * tempDic = [NSMutableDictionary new];
        [tempDic setValue:key forKey:@"product_id"];
        
        NSMutableString * strColor = [NSMutableString new];
        
        NSArray * arrColors = [[order objectForKey:key] objectForKey:@"arrSelectedColors"];
        
        for (int index = 0; index < arrColors.count ; ++index) {
            if(index == 0) {
                [strColor appendString:arrColors[index]];
            }
            else {
                [strColor appendString:[NSString stringWithFormat:@",%@",arrColors[index]]];

            }
        }
        
        [tempDic setValue:strColor forKey:@"color"];
        [tempDic setValue:[[[order objectForKey:key] objectForKey:@"mainDict"] valueForKey:@"variation"] forKey:@"variation"];
        [tempDic setValue:[[[order objectForKey:key] objectForKey:@"mainDict"] valueForKey:@"promotion"] forKey:@"promotion"];
        [tempDic setValue:[[[order objectForKey:key] objectForKey:@"mainDict"] valueForKey:@"price"] forKey:@"price"];

        NSArray * arrayProducts = [[order objectForKey:key] objectForKey:@"arrayProducts"];
        [tempDic setValue:[NSString stringWithFormat:@"%lu",(unsigned long)arrayProducts.count] forKey:@"quantity"];
        
        [myArray addObject:tempDic];
    }
    
    NSDictionary * innerDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                      totalPrice, @"price",
                                      myArray, @"myarray",
                                      nil];
    
    
    NSError *error;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:innerDictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [[NSUserDefaults standardUserDefaults] userID],@"user_id",
                            [[NSUserDefaults standardUserDefaults] email], @"user_email",
                            address,@"address",
                            phone,@"phone",
                            body,@"data",
                            nil];
    
//    address,@"address",››

//    phone,@"phone",

    
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager POST:@"orders" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        self.completionBlock ([responseObject objectForKey:@"msg"],responseObject,YES);
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlock (error.localizedDescription,nil,NO);
    }];
}


/*************************************
 ****      Login & Sign Up      ******
 *************************************/

#pragma mark -  post Order

-(void)signUp:(NSString*)username email_value:(NSString*)email_value  password:(NSString*)password  profile_pic:(NSString*)profile_pic address:(NSString*)address phoneNumber:(NSString*)phoneNumber  completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock {
   
    [SVProgressHUD show];
    
    self.completionBlock = completionBlock;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            username,@"username",
                            email_value, @"email_value",
                            password, @"password",
                            profile_pic, @"profile_pic",
                            address,@"address",
                            phoneNumber,@"phoneNumber",
                            nil];
    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KBaseURL]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager POST:@"users" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        self.completionBlock ([responseObject objectForKey:@"message"],responseObject,YES);
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlock (error.localizedDescription,nil,NO);
    }];
    
}


-(void)login:(NSString*)username password:(NSString*)password completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock {
    
    [SVProgressHUD show];
    
    self.completionBlock = completionBlock;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            username,@"username",
                            password, @"password",
                            nil];

    
    AFHTTPRequestOperationManager *manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.aimscareadmin.com/api/user/"]];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager POST:@"login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"] ]  isEqualToString:@"1" ]) {
            self.completionBlock (responseObject,responseObject,YES);
        }
        else {
            self.completionBlock (responseObject,responseObject,NO);
        }
        
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        
        self.completionBlock (error.localizedDescription,nil,NO);
    }];
    
}


@end




