//
//  BBCountryListViewController.m
//  BriskBiz
//
//  Created by Rafay on 9/23/15.
//  Copyright (c) 2015 Rafay. All rights reserved.
//

#import "BBCountryListViewController.h"

@interface BBCountryListViewController ()
{
    NSArray *sortedCountryArray;
}
@end

@implementation BBCountryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.baseDelegate = self;
//    
//    [self setupNavigationBarTitle:@"SELECT COUNTRY" showRightButton:YES rightButtonType:UINavigationBarRightButtonTypeDone topBarImage:nil showBackGround:NO];
    
    
    sortedCountryArray = [NSArray arrayWithObjects:@"England",@"Ireland",@"Scotland",@"Wales", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnCustomRightButton_Pressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (IBAction)btnback_pressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return sortedCountryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    [cell.textLabel setText:[sortedCountryArray objectAtIndex:indexPath.row]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.delegate setText:[sortedCountryArray objectAtIndex:indexPath.row]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
