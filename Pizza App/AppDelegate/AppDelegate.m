//
//  AppDelegate.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 12/20/16.
//  Copyright © 2016 finja. All rights reserved.
//

#import "AppDelegate.h"
@import Stripe;

//NSString * const StripePublishableKey = @"pk_live_wSBNIJLG1EGX04XCkSzGmHhF";//Live
NSString * const StripePublishableKey = @"pk_test_AUlBEXxUttg6rLFaoNkOckaL";//Test


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Stripe setDefaultPublishableKey:StripePublishableKey];
    
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
//                                      forBarPosition:UIBarPositionAny
//                                          barMetrics:UIBarMetricsDefault];
//    
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    NSMutableArray * addressArray = [NSMutableArray new];
    
    addressArray =  [[NSUserDefaults standardUserDefaults] addressArray];
    
    if(addressArray.count == 0) {
    
    [[NSUserDefaults standardUserDefaults] setAddressArray:[NSMutableArray new]];
    }


//    [[STPPaymentConfiguration sharedConfiguration] setPublishableKey:@"pk_test_6pRNASCoBOKtIshFeQd4XMUh"];

    // Override point for customization after application launch.
    
    [ACCartSingeltonManager sharedManager].dictCartProducts = [[NSMutableDictionary alloc] init];
    
   [self setupTabBarAppearences];
    
    return YES;
}

-(void)setupTabBarAppearences
{
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    // Change the tab bar background
//    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:KAppTheme_COLOR];
     // [[UITabBar appearance] selectedImageTintColor:[UIImage imageNamed:@"search_active"]];
//    
//
//    [[UITabBarItem appearance] setTitleTextAttributes:@{
//                                                        NSFontAttributeName:[UIFont fontWithName:@"Exo2-Regular" size:12.0f]
//                                                        } forState:UIControlStateNormal];
//
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
                                             forState:UIControlStateSelected];
    
    
    UITabBarItem *tabBarItem = [tabBarController.tabBar.items objectAtIndex:0];
//    UITabBarItem *tabBarItem1 = [tabBarController.tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem2 = [tabBarController.tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBarController.tabBar.items objectAtIndex:2];
    
//    UIImage *unselectedImageForTabItem0 = [UIImage imageNamed:@"home"];
//    UIImage *selectedImageForTabItem0  = [UIImage imageNamed:@"home_active"];
//    
//    UIImage *unselectedImageForTabItem1 = [UIImage imageNamed:@"search"];
//    UIImage *selectedImageForTabItem1 = [UIImage imageNamed:@"search_active"];
//    
//    UIImage *unselectedImageForTabItem2  = [UIImage imageNamed:@"call"];
//    UIImage *selectedImageForTabItem2  = [UIImage imageNamed:@"call_active"];
//    
    
    tabBarItem.selectedImage = [[UIImage imageNamed:@"home-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem.image = [[UIImage imageNamed:@"home-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem.title = @"Home";

    
//    tabBarItem1.selectedImage = [[UIImage imageNamed:@"order-history"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    tabBarItem1.image = [[UIImage imageNamed:@"order-history"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    tabBarItem1.title = @"Order";
    
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"contact-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.image = [[UIImage imageNamed:@"contact-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.title = @"Contact";

    tabBarItem3.selectedImage = [[UIImage imageNamed:@"checkout-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.image = [[UIImage imageNamed:@"checkout-icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.title = @"Checkout";

  //  [tabBarItem setImage: [unselectedImageForTabItem0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
  //  [tabBarItem setSelectedImage: selectedImageForTabItem0];
    
  //  [tabBarItem1 setImage: [unselectedImageForTabItem1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
  //  [tabBarItem1 setSelectedImage: selectedImageForTabItem1];
    
  //  [tabBarItem2 setImage: [unselectedImageForTabItem2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
  //  [tabBarItem2 setSelectedImage: selectedImageForTabItem2];
    
    
    [[UITabBar appearance] setItemWidth:self.window.frame.size.width/4];
   [UITabBar appearance].itemPositioning = UITabBarItemPositioningFill;
    
    
    // set the selected icon color
  //  [[UITabBar appearance] setSelectedImageTintColor:[UIColor orangeColor]];
    // remove the shadow
  //  [[UITabBar appearance] setShadowImage:nil];
    
 

   
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
