//
//  DEMOLeftMenuViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOLeftMenuViewController.h"
#import "UIViewController+RESideMenu.h"
#import "AppDelegate.h"
#import "MenuTableViewCell.h"

//#import "idoubs2AppDelegate.h"

@interface DEMOLeftMenuViewController ()
{
    BOOL updateProfilePic;
    int selectedSegmentIndex;
    
    NSMutableArray * arrCategoriesList;
    NSArray *arrMenu;
    NSArray *arrImages;

}
@property (weak, nonatomic) IBOutlet  UITableView *tableView;
@property (weak, nonatomic) IBOutlet  UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet  UILabel *emailLabel;

@end

@implementation DEMOLeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    selectedSegmentIndex = 100;
    arrCategoriesList = [NSMutableArray new];
    
    arrMenu = [NSArray arrayWithObjects:@"Home", @"Menu", @"Order History", @"Special Deals", @"Contact Us", @"Logout", @"Sign In", nil];
    arrImages = [NSArray arrayWithObjects:@"Home", @"Menu", @"Order History", @"Special Deals", @"Contact Us", @"Logout", @"Sign In", nil];

    
    if(IS_IPHONE4) {
        [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y-20, self.tableView.frame.size.width, self.tableView.frame.size.height)];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable:)
                                                 name:K_Table_Reload
                                               object:nil];
    
    ACAPIManager * manager = [ACAPIManager new];
    
    [manager allCategoriesList:^(NSString *message, NSMutableArray * resArray, BOOL isSuccessfull) {
        if(isSuccessfull) {
            arrCategoriesList = resArray;
        }
        else {
            [FPUtilityFunctions showAlertView:@"Error" message:message alertType:AlertFailure];
        }
    }];
}

-(void) btnProfileTapped:(UIButton*)sender
{
    
    selectedSegmentIndex = 100;
    [self.tableView reloadData];

    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACHomeVC"]] animated:YES];

    [self.sideMenuViewController hideMenuViewController];

}

-(void)reloadTable:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:K_Table_Reload])
    {
        [self.tableView reloadData];
    }
}


-(void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedSegmentIndex = (int)indexPath.row;
    [self.tableView reloadData];
    
    if(indexPath.row == 0) {
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACLoginVC"]]
                                                     animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    else if (indexPath.row == arrCategoriesList.count) {
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACDeliveryInfoVC"]]
                                                     animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    else {
        
        NSDictionary * dictCategory = [arrCategoriesList objectAtIndex:indexPath.row-1];
        
        [[NSUserDefaults standardUserDefaults] setCategoryID:[NSString stringWithFormat:@"%@",[dictCategory valueForKey:@"id"]]];
        [[NSUserDefaults standardUserDefaults] setCategoryTitle:[NSString stringWithFormat:@"%@",[dictCategory valueForKey:@"name"]]];
        
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACDailyLivingVC"]]
                                                     animated:YES];
        [self.sideMenuViewController hideMenuViewController];

    }
    
    /*
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACLoginVC"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
            break;
        case 1:
            
            [[NSUserDefaults standardUserDefaults] setCategoryID:@"11"];
            [[NSUserDefaults standardUserDefaults] setCategoryTitle:@"Health Care & Medical"];
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACDailyLivingVC"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
        case 2:
            
            [[NSUserDefaults standardUserDefaults] setCategoryID:@"12"];
            [[NSUserDefaults standardUserDefaults] setCategoryTitle:@"Consumables"];

            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACDailyLivingVC"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 3:
            
            [[NSUserDefaults standardUserDefaults] setCategoryID:@"13"];
            [[NSUserDefaults standardUserDefaults] setCategoryTitle:@"Cleaning Equipment"];
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACDailyLivingVC"]] animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            break;
            
            
        case 4:
            
            [[NSUserDefaults standardUserDefaults] setCategoryID:@"14"];
            [[NSUserDefaults standardUserDefaults] setCategoryTitle:@"Shop by brand"];
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACDailyLivingVC"]] animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            
            break;
            
        case 5:
            
            [[NSUserDefaults standardUserDefaults] setCategoryID:@"23"];
            [[NSUserDefaults standardUserDefaults] setCategoryTitle:@"Jantorial Supplies"];
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACDailyLivingVC"]] animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            
            break;
            
        case 6:
        {
            [[NSUserDefaults standardUserDefaults] setCategoryID:@"24"];
            [[NSUserDefaults standardUserDefaults] setCategoryTitle:@"Furniture $ Equipment"];
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACDailyLivingVC"]] animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            
        }
            break;
        case 7:
        {
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACDeliveryInfoVC"]] animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 8:
        {
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACReturnPolicyVC"]] animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 9:
        {
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACTocVC"]] animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
            
            
        default:
            break;
    }
    */
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([[NSUserDefaults standardUserDefaults] isUserLogin] && indexPath.row == 0)
        return 0;
    
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    return arrMenu.count-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MenuTableViewCell";
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    if([[NSUserDefaults standardUserDefaults] isUserLogin] && indexPath.row == 0)
        return cell;
    
//    if(indexPath.row == selectedSegmentIndex) {
//    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,KSCREEN_WIDTH, 45)];
//    myImageView.image = [UIImage imageNamed:@"menu-hover-bg"];
//    myImageView.contentMode = UIViewContentModeScaleToFill;
//    [cell.contentView addSubview:myImageView];
//    }
    
    cell.menuLabel.text = [arrMenu objectAtIndex:indexPath.row];
    cell.menuImage.image = [UIImage imageNamed:[arrImages objectAtIndex:indexPath.row]];
    
    
    return cell;
}

@end
