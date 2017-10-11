//
//  SubCategoriesVC.m
//  Pizza App
//
//  Created by Adeel Ishaq on 9/30/17.
//  Copyright © 2017 Adeel Ishaq. All rights reserved.
//

#import "SubCategoriesVC.h"

@interface SubCategoriesVC () <UITableViewDelegate, UITableViewDataSource,UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSMutableArray * arrSubCategories;
@property (weak, nonatomic) IBOutlet UITableView * tblVW;
@property (weak, nonatomic) IBOutlet  UIPickerView* picker;


@property (strong, nonatomic) NSMutableDictionary * selectedItem;
@property (strong, nonatomic) NSMutableString * addOnItem;
@property (strong, nonatomic) NSMutableArray * addOnList;

@end

@implementation SubCategoriesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tblVW.delegate= self;
    _tblVW.dataSource = self;
    
    _arrSubCategories = [_selectedCategory objectForKey:@"sub_categories"];
    [_tblVW reloadData];
    
    self.picker.dataSource = self;
    self.picker.delegate = self;
    self.picker.showsSelectionIndicator=YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrSubCategories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSMutableDictionary * currentSubCategory = [_arrSubCategories objectAtIndex:sectionIndex];
    NSMutableArray * arrItems = [currentSubCategory objectForKey:@"items"];
    return arrItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SubCategoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSMutableDictionary * currentSubCategory = [_arrSubCategories objectAtIndex:indexPath.section];
    NSMutableArray * arrItems = [currentSubCategory objectForKey:@"items"];
    NSMutableDictionary * currentItem = [arrItems objectAtIndex:indexPath.row];
    
    UILabel* lblTitle = [cell.contentView viewWithTag:1];
    UILabel* lblDetail = [cell.contentView viewWithTag:2];
    UILabel* lblPrice = [cell.contentView viewWithTag:3];
    UIButton* btnAdd = [cell.contentView viewWithTag:4];
    
    lblTitle.text = [currentItem valueForKey:@"name"];
    lblDetail.text = [currentItem valueForKey:@"description"];
    lblPrice.text = [currentItem valueForKey:@"price"];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"SectionHeader";
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    
    NSMutableDictionary * currentSubCategory = [_arrSubCategories objectAtIndex:section];

    UILabel* lblTitle = [headerView.contentView viewWithTag:1];
    lblTitle.text = [currentSubCategory valueForKey:@"name"];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary * currentSubCategory = [_arrSubCategories objectAtIndex:indexPath.section];
    NSMutableArray * arrItems = [currentSubCategory objectForKey:@"items"];
    NSMutableDictionary * currentItem = [arrItems objectAtIndex:indexPath.row];

//    NSMutableDictionary * itemJson = [NSMutableDictionary new];
    
//    itemJson[@"subCategoryID"] = currentSubCategory[@"id"];
//    itemJson[@"subCategoryName"] = currentSubCategory[@"id"];
//    itemJson[@"subCategoryDescription"] = currentSubCategory[@"description"];
//    itemJson[@"subCategoryDays"] = currentSubCategory[@"days"];
//    itemJson[@"subCategoryAllowCoupon"] = currentSubCategory[@"allow_coupon"];
//    itemJson[@"subCategoryDelivery"] = currentSubCategory[@"delivery"];
//    itemJson[@"subCategoryDelivery"] = currentSubCategory[@"delivery"];
    
    if ([[currentItem valueForKey:@"addon_item_id"] isEqualToString:@"0"]) {
     
        [currentItem setValue:@"" forKey:@"addOnItems"];
        [ACCartSingeltonManager.sharedManager.arrMenu addObject:currentItem];
    }
    else {
        
        _selectedItem = currentItem;
        _addOnItem = [@"" mutableCopy];
        [self fetchAddOnItem:[currentItem valueForKey:@"addon_item_id"]];
    }
    
//    ACCartSingeltonManager.sharedManager.dictCartProducts
}

- (void)fetchAddOnItem:(NSString*)addOnItemID {
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"addon_cat_id", addOnItemID,
                            nil];

    
    ACAPIManager * manager = [ACAPIManager new];
    
    [manager postRequestDataWithMethodName:@"menu/addoncat_items" withParameters:params token:@"2e47683ff95f73d02963400f0eaacec2" completionBlock:^(NSString *message, NSMutableDictionary *resDict, BOOL isSuccessfull) {
        
        
        if(isSuccessfull) {
            
            _addOnList = [resDict objectForKey:@"items"];
            [_picker becomeFirstResponder];
        }
        else {
            [FPUtilityFunctions showAlertView:@"Error" message:message alertType:AlertFailure];
        }
        
    }];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _addOnList.count;
}
// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary * currentAddOn = (NSDictionary *)[_addOnList objectAtIndex:row];
    
    return [currentAddOn valueForKey:@"name"];
}


@end

