//
//  ACContactUsVC.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 12/23/16.
//  Copyright © 2016 finja. All rights reserved.
//

#import "ACContactUsVC.h"

@interface ACContactUsVC ()

@end

@implementation ACContactUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(menuAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"menu-icon"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 20.0, 30.0, 20.0);
    [button setContentMode:UIViewContentModeScaleAspectFit];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]
                                   initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = buttonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = KAppTheme_COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],  NSFontAttributeName: ProximaNova_LIGHT(15)}];
}

- (void) menuAction: (id) sender {
    [self.sideMenuViewController presentLeftMenuViewController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
