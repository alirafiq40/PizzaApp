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

#pragma mark -  allCategoriesList
-(void)allCategoriesList:(void(^)(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull))completionBlockArray;

#pragma mark -  specificCategory
-(void)specificCategory:(NSString*)categoryID completionBlock:(void(^)(NSString *message, NSMutableArray * resArr, BOOL isSuccessfull))completionBlockArray;

#pragma mark -  allSubCategoriesList
-(void)allSubCategoriesList:(void(^)(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull))completionBlockArray;

#pragma mark -  specificSubCategory
-(void)completionBlockArray:(NSString*)categoryID completionBlock:(void(^)(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull))completionBlock;

#pragma mark -  specificSubCategoryObject
-(void)specificSubCategoryObject:(NSString*)categoryID subCategoryIDObject:(NSString*)subCategoryIDObject completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDic, BOOL isSuccessfull))completionBlock;

#pragma mark -  allProductsList
-(void)allProductsList:(void(^)(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull))completionBlockArray;

#pragma mark -  allProductsListCategory
-(void)allProductsListCategory:(NSString*)categoryID completionBlock:(void(^)(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull))completionBlockArray;

#pragma mark -  allProductsListSubCategory
-(void)allProductsListSubCategory:(NSString*)categoryID subCategoryIDObject:(NSString*)subCategoryIDObject completionBlock:(void(^)(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull))completionBlockArray;

#pragma mark -  specificProductObject
-(void)allProductsListCategory:(NSString*)categoryID subCategoryIDObject:(NSString*)subCategoryIDObject priductID:(NSString*)priductID completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock;


/*************************************
 *******      Order Work      ********
 *************************************/

#pragma mark -  get order from order id

-(void)getOrderFromOrderID:(NSString*)order_id completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock;


#pragma mark -  get order from order id

-(void)getUsersOrderFromUserID:(NSString*)user_id completionBlock:(void(^)(NSString *message, NSArray * resDict, BOOL isSuccessfull))completionBlock;

#pragma mark -  post Order

-(void)postOrder:(NSMutableDictionary*)order totalPrice:(NSString*)totalPrice address:(NSString*)address phone:(NSString*)phone completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock;

/*************************************
 ****      Login & Sign Up      ******
 *************************************/

#pragma mark -  post Order

-(void)signUp:(NSString*)username email_value:(NSString*)email_value  password:(NSString*)password  profile_pic:(NSString*)profile_pic address:(NSString*)address phoneNumber:(NSString*)phoneNumber  completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock;

-(void)login:(NSString*)username password:(NSString*)password completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock;

/*************************************
 ****           APIS            ******
 *************************************/

-(void)postRequestDataWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters token:(NSString*)token completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock ;

-(void)getRequestWithMethodName:(NSString*)methodName withParameters:(NSDictionary*)parameters completionBlock:(void(^)(NSString *message, NSMutableDictionary * resDict, BOOL isSuccessfull))completionBlock;

@end






