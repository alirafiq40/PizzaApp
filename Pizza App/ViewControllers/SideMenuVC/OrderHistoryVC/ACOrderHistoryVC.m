//
//  ACOrderHistoryVC.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 1/21/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import "ACOrderHistoryVC.h"
#import "ACOrderHistoryTableViewCell.h"
#import "RESideMenu.h"

@interface ACOrderHistoryVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray * arrRes;
}
@property (nonatomic, weak) IBOutlet UITableView * tblVW;

@end

@implementation ACOrderHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tblVW.delegate= self;
    _tblVW.dataSource = self;
    arrRes = [NSArray new];
    self.title = @"Order History";

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
    
//    ACAPIManager * manager = [ACAPIManager new];
//    [manager getUsersOrderFromUserID:[[NSUserDefaults standardUserDefaults] userID] completionBlock:^(NSString *message, NSArray *resDict, BOOL isSuccessfull) {
//        
//        if(isSuccessfull) {
//            arrRes = resDict;
//            [_tblVW reloadData];
////            [FPUtilityFunctions showAlertView:@"" message:@"Successfully Activated" alertType:AlertSuccess];
//        }
//        else {
//            [FPUtilityFunctions showAlertView:@"Error" message:message alertType:AlertFailure];
//        }
//        
//    }];
//
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

// Switch to viewcontroller
//-(IBAction)popViewControllerAnimated:(id)sender {
//    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACHomeVC"]] animated:YES];
//}
//

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
//    NSDictionary * dict = [arrRes objectAtIndex:indexPath.row];
//    NSArray * arrProducts = [dict objectForKey:@"products"];
//    NSString * itemsList = @"";
//    
//    for (NSDictionary *dict in arrProducts) {
//        if([itemsList isEqualToString:@""]) {
//            itemsList = [NSString stringWithFormat:@"%@ X %@",[dict valueForKey:@"product_name"],[dict valueForKey:@"quantity"]];
//        }
//        else {
//            itemsList = [itemsList stringByAppendingString:[NSString stringWithFormat:@"\n%@ X %@",[dict valueForKey:@"product_name"],[dict valueForKey:@"quantity"]]];
//        }
//    }
//    
//    NSMutableAttributedString *itemListLabelAttributedText = [[NSMutableAttributedString alloc] initWithString:itemsList attributes:@{ NSFontAttributeName: ProximaNova_LIGHT(17)}];
//    CGRect itemListRect = [itemListLabelAttributedText boundingRectWithSize:(CGSize){tableView.frame.size.width, CGFLOAT_MAX} options: NSStringDrawingUsesLineFragmentOrigin context:nil];
//    return CGRectGetHeight(itemListRect)+40 ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;//arrRes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ACCartTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;

/*
    NSDictionary * dict = [arrRes objectAtIndex:indexPath.row];
    
    
    NSArray * arrProducts = [dict objectForKey:@"products"];
    
    NSString * itemsList = @"";

    for (NSDictionary *dict in arrProducts) {
        if([itemsList isEqualToString:@""]) {
        itemsList = [NSString stringWithFormat:@"%@ X %@",[dict valueForKey:@"product_name"],[dict valueForKey:@"quantity"]];
        }
        else {
        itemsList = [itemsList stringByAppendingString:[NSString stringWithFormat:@"\n%@ X %@",[dict valueForKey:@"product_name"],[dict valueForKey:@"quantity"]]];
        }
    }
    
    NSMutableAttributedString *itemListLabelAttributedText = [[NSMutableAttributedString alloc] initWithString:itemsList attributes:@{ NSFontAttributeName: ProximaNova_LIGHT(17)}];
    CGRect itemListRect = [itemListLabelAttributedText boundingRectWithSize:(CGSize){tableView.frame.size.width, CGFLOAT_MAX} options: NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    CGRect frame = cell.lblItemsList.frame;
    // frame.origin.y = 10.0;
    frame.size.height = itemListRect.size.height;
    cell.lblItemsList.frame = frame;
    
    
    [cell.lblTotalPrice setFrame:CGRectMake(cell.lblTotalPrice.frame.origin.x, frame.size.height + 10.0f,  cell.lblTotalPrice.frame.size.width, 20.0f)];
    
    
    cell.lblItemsList.text = itemsList;
    
    cell.lblTotalPrice.text = [NSString stringWithFormat:@"Total Price: £%.2f",[[dict valueForKey:@"price"] floatValue]];
    */
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"SectionHeader";
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 44;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
   
    static NSString *CellIdentifier = @"SectionFooter";
    UITableViewCell *footerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (footerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    return footerView;

    
}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        
//        [self.tblVW deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
//    }
//    else if(editingStyle == UITableViewCellEditingStyleInsert)
//    {
//    }
//    
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
