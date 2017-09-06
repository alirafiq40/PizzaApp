//
//  ACDeliveryInfoVC.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 12/23/16.
//  Copyright © 2016 finja. All rights reserved.
//

#import "ACDeliveryInfoVC.h"

@interface ACDeliveryInfoVC ()
{
    NSArray * arrBrands;
}
@end

@implementation ACDeliveryInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tblVW.delegate = self;
    _tblVW.dataSource = self;
    arrBrands = [NSArray arrayWithObjects:@"AIMS",@"Attends",@"TENA",@"OMRON",@"CLINELL",@"GOJO",@"PURELL",@"Diversey Care",@"Selden", nil];
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.title = @"Delivery Info";
    
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = KAppTheme_COLOR;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],  NSFontAttributeName: ProximaNova_LIGHT(15)}];
    
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

- (void) menuAction: (id) sender {
    [self.sideMenuViewController presentLeftMenuViewController];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arrBrands.count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    
   
    cell.textLabel.text = [arrBrands objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [FPUtilityFunctions showAlertView:@"" message:@"Coming soon..." alertType:AlertInfo];
    
}

@end
