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
    
    arrMenu = [NSArray arrayWithObjects:@"Menu", @"Order History", @"Special Deals", @"Reviews",@"Contact Us", @"Logout", @"Sign In", nil];
    arrImages = [NSArray arrayWithObjects:@"menu", @"order", @"special-deal-icon", @"", @"contact", @"logout-icon", @"sign-in-icon", nil];

    
    if(IS_IPHONE4) {
        [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y-20, self.tableView.frame.size.width, self.tableView.frame.size.height)];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable:)
                                                 name:K_Table_Reload
                                               object:nil];
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
    
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACHomeVC"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
            break;
        case 1:
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACOrderHistoryVC"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
        case 2:
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACHomeVC"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 3:
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"FeedbackViewController"]] animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            break;
            
            
        case 4:
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACContactUsVC"]] animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            
            break;
            
        case 5:
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACLoginVC"]] animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            
            break;
            
        case 6:
        {
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACLoginVC"]] animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            
        }
            
        default:
            break;
    }
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
