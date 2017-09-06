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
    self.title = @"Order History";
    arrRes = [NSArray new];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]  initWithTitle:@"Home"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(popViewControllerAnimated:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    ACAPIManager * manager = [ACAPIManager new];
    [manager getUsersOrderFromUserID:[[NSUserDefaults standardUserDefaults] userID] completionBlock:^(NSString *message, NSArray *resDict, BOOL isSuccessfull) {
        
        if(isSuccessfull) {
            arrRes = resDict;
            [_tblVW reloadData];
//            [FPUtilityFunctions showAlertView:@"" message:@"Successfully Activated" alertType:AlertSuccess];
        }
        else {
            [FPUtilityFunctions showAlertView:@"Error" message:message alertType:AlertFailure];
        }
        
    }];

}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = KAppTheme_COLOR;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],  NSFontAttributeName: ProximaNova_LIGHT(15)}];
}

-(IBAction)popViewControllerAnimated:(id)sender {
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACHomeVC"]] animated:YES];
}


#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    return CGRectGetHeight(itemListRect)+40 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return arrRes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ACOrderHistoryTableViewCell";
    
    ACOrderHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[ACOrderHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
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
    
    return cell;
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
