//
//  ACCartBuyVC.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 1/31/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import "ACCartBuyVC.h"
#import "ActionSheetPickerCustom.h"
#import "ActionSheetLocalePicker.h"
#import "AbstractActionSheetPicker.h"
#import "ActionSheetCustomPicker.h"
#import "ActionSheetCustomPickerDelegate.h"
#import "ActionSheetStringPicker.h"
#import "ActionSheetDatePicker.h"
#import "ActionSheetDistancePicker.h"
#import "ACCartTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RESideMenu.h"

@interface ACCartBuyVC ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate,ActionSheetPickerCustomDelegate,UIAlertViewDelegate>
{
    ActionSheetPickerCustom *actionSheet;
    float totalBill;
    int totalItems;
    NSInteger selectedAddressIndex;
}
@property (nonatomic, weak) IBOutlet UITableView * tblVW;
@property (nonatomic, weak) IBOutlet UILabel * lblTotalBill;
@end

@implementation ACCartBuyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    addressArray = [NSMutableArray new];
    addressArray =  [[[NSUserDefaults standardUserDefaults] addressArray] mutableCopy];//[[Address all:nil] mutableCopy];

    // Do any additional setup after loading the view.
    totalBill = 0;
    totalItems = 0;
    selectedAddressIndex = 0;
    _tblVW.delegate= self;
    _tblVW.dataSource = self;
    self.title = @"Cart";
    
    [self addAddressButton];
    
    [self updateTotalBill];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = KAppTheme_COLOR;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],  NSFontAttributeName: ProximaNova_LIGHT(15)}];
}

-(IBAction)btnOrderAction:(id)sender {
    
    if(![[NSUserDefaults standardUserDefaults] isUserLogin]) {
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACLoginVC"]] animated:YES];
        return;
    }
    
    if(addressArray.count == 0) {
        [FPUtilityFunctions showAlertView:@"Error" message:@"Please provide atleast one address." alertType:AlertFailure];
        return;
    }
    
    ACAPIManager * manager = [ACAPIManager new];
//    Address * addressObj = [addressArray objectAtIndex:selectedAddressIndex];
//    [manager postOrder:[ACCartSingeltonManager sharedManager].dictCartProducts totalPrice:[NSString stringWithFormat:@"%f",totalBill] address:[addressObj getFullAddress] phone:addressObj.phoneNo completionBlock:^(NSString *message, NSMutableDictionary *resDict, BOOL isSuccessfull) {
//        
//        if(isSuccessfull) {
//            
//        [ACCartSingeltonManager sharedManager].dictCartProducts = [[NSMutableDictionary alloc] init];
//            
//        ACOrderHistoryVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ACOrderHistoryVC"];
//        [self.navigationController pushViewController:vc animated:YES];
//            
//            [FPUtilityFunctions showAlertView:@"" message:@"Order Posted" alertType:AlertSuccess];
//        }
//        else {
//            ACOrderHistoryVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ACOrderHistoryVC"];
//            [self.navigationController pushViewController:vc animated:YES];
//            
//            [FPUtilityFunctions showAlertView:@"Error" message:message alertType:AlertFailure];
//        }
//        
//    }];
    
    
}

-(IBAction)btnStripeAction:(id)sender {
}

-(IBAction)btnPaypalAction:(id)sender {
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [[ACCartSingeltonManager sharedManager].dictCartProducts allKeys].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ACCartTableViewCell";
    
    ACCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[ACCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSArray * keysArray = [[ACCartSingeltonManager sharedManager].dictCartProducts allKeys];
    NSString * strKey = [keysArray objectAtIndex:indexPath.row];
    NSDictionary * dict = [[ACCartSingeltonManager sharedManager].dictCartProducts objectForKey:strKey];
    
    cell.lblProduct.text = [[dict objectForKey:@"mainDict"] valueForKey:@"name"];
//    cell.lblProductPrice.text = [[dict objectForKey:@"mainDict"]  valueForKey:@"price"];
  
    [self updateSizeColorDetail:cell.lblProductPrice tempDict:dict];

    
    [cell.imgProduct sd_setImageWithURL:[NSURL URLWithString:[[dict objectForKey:@"mainDict"]  valueForKey:@"image1"]] placeholderImage:[UIImage imageNamed:@"sitting.png"]];
    
    NSMutableDictionary * tempDict = [[ACCartSingeltonManager sharedManager].dictCartProducts objectForKey:strKey];
    NSMutableArray * arr = [tempDict objectForKey:@"arrayProducts"];
    
//    float totalPRice = [[[dict objectForKey:@"mainDict"]  valueForKey:@"price"] floatValue];
//    totalPRice *= arr.count;
//    totalBill += totalPRice;
//    cell.lblTotalProductPrice.text = [NSString stringWithFormat:@"£%.2f",totalPRice];
    cell.lblProductCount.text = [NSString stringWithFormat:@"%lu",(unsigned long)arr.count];
  
//    totalItems += arr.count;

    float totalPRice = 0.0f;
    NSMutableArray * arrPrices = [tempDict objectForKey:@"arrSelectedPrices"];
    
    for (NSString * singlePRice in arrPrices) {
        totalPRice += [singlePRice floatValue];
    }
    
    cell.lblTotalProductPrice.text = [NSString stringWithFormat:@"£%.2f",totalPRice];

    
    //    _lblTotalBill.text = [NSString stringWithFormat:@"Total Items: %d          Total Bill: £%.2f",totalItems,totalBill];

    return cell;
}

-(void)updateSizeColorDetail:(UILabel*)_lblSizeColors tempDict:(NSDictionary*)tempDict {
    
    _lblSizeColors.text = @"";
    
    // NSMutableDictionary * dict = [_dictProduct mutableCopy];
    //   tempDict = [[ACCartSingeltonManager sharedManager].dictCartProducts objectForKey:[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]]];
    
    NSMutableArray * arrSelectedColors =[tempDict objectForKey:@"arrSelectedColors"];;
    NSMutableArray * arrSelectedVariations = [tempDict objectForKey:@"arrSelectedVariations"];
    
    NSMutableArray * arrSizeColorDetail = [NSMutableArray new];
    
    for (int index = 0 ; index < arrSelectedColors.count ; ++ index) {
        if([[arrSelectedVariations objectAtIndex:index] isEqualToString:@""])
            [arrSizeColorDetail addObject:[NSString stringWithFormat:@"%@",[arrSelectedColors objectAtIndex:index]]];
        else
            [arrSizeColorDetail addObject:[NSString stringWithFormat:@"%@,%@",[[arrSelectedVariations objectAtIndex:index] substringToIndex:1],[arrSelectedColors objectAtIndex:index]]];
    }
    
    NSArray *uniqueArray = [[NSSet setWithArray:arrSizeColorDetail] allObjects];
    
    for (NSString * uniqueCompareStr in uniqueArray) {
        
        int occurrences = 0;
        for(NSString *string in arrSizeColorDetail){
            occurrences += ([string isEqualToString:uniqueCompareStr]?1:0); //certain object is @"Apple"
        }
        
        if([_lblSizeColors.text isEqualToString:@""]) {
            [_lblSizeColors setText:[NSString stringWithFormat:@"%d %@",occurrences,uniqueCompareStr]];
        }
        else {
            [_lblSizeColors setText:[_lblSizeColors.text stringByAppendingString: [NSString stringWithFormat:@", %d %@",occurrences,uniqueCompareStr]]];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateTotalBill {
    
    totalBill = 0.0f;
    totalItems = 0;
    
    for (NSString * key in [[ACCartSingeltonManager sharedManager].dictCartProducts allKeys]) {
        NSMutableDictionary * tempDict = [[ACCartSingeltonManager sharedManager].dictCartProducts objectForKey:key];
        
        NSMutableArray * arr = [tempDict objectForKey:@"arrayProducts"];
        totalItems += arr.count;
        
        NSMutableArray * arrPRices = [tempDict objectForKey:@"arrSelectedPrices"];
        
        for (NSString * singlePRice in arrPRices) {
            float totalPRice = [singlePRice floatValue];
            totalBill += totalPRice;
        }
    }
    _lblTotalBill.text = [NSString stringWithFormat:@"Total Items: %d          Total Bill: £%.2f",totalItems,totalBill];
}

#pragma mark - Add Address

-(void)addAddressButton
{
    addressArray =  [[[NSUserDefaults standardUserDefaults] addressArray] mutableCopy];//[[Address all:nil] mutableCopy];

    if (!self.addressButton)
    {
        if(IS_IPHONE)
            
            self.addressButton = [[UIButton alloc] initWithFrame:CGRectMake(112, 11, 185, 22)];
        else
            self.addressButton = [[UIButton alloc] initWithFrame:CGRectMake(312, 11, 300, 44)];
        
    }
    
    [self.addressButton addTarget:self action:@selector(btnAddress_Pressed:) forControlEvents:UIControlEventTouchUpInside];
    //[self.addressButton setSelected:NO];
    self.addressButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.addressButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.addressButton setBackgroundImage:IMAGE_UNSELECTED_ADDRESS_DROPDOWN forState:UIControlStateNormal];
    [self.addressButton setBackgroundImage:IMAGE_SELECTED_ADDRESS_DROPDOWN forState:UIControlStateSelected];
  
    
//    if ([self.currentOrder isKindOfClass:[MyOrder class]] )
//    {
//        [self.addressButton setTitle:self.currentOrder.address.adressType forState:UIControlStateNormal];
//        [self.addressButton setTitle:self.currentOrder.address.adressType forState:UIControlStateSelected];
//        [self.lblMyAddress setText:[self.currentOrder.address getFullAddress]];
//        [self.lblPhoneNo setText:self.currentOrder.address.phoneNo];
//    }
//    else
//    {
        if (addressArray.count>0)
        {
            selectedAddressIndex = 0;
//            Address * addressObj = [addressArray objectAtIndex:0];
//            [self.addressButton setTitle:[[addressArray objectAtIndex:0]adressType] forState:UIControlStateNormal];
//            [self.addressButton setTitle:[[addressArray objectAtIndex:0]adressType] forState:UIControlStateSelected];
//            [self.lblMyAddress setText:[NSString stringWithFormat:@"%@, Cell: %@",[addressObj getFullAddress],addressObj.phoneNo]];
//Rafay     [self.lblPhoneNo setText:addressObj.phoneNo];
        }
        else
        {
            [self.addressButton setTitle:EMPTY_STRING forState:UIControlStateNormal];
            [self.addressButton setTitle:EMPTY_STRING forState:UIControlStateSelected];
            [self.lblMyAddress setText:EMPTY_STRING];
//Rafay     [self.lblPhoneNo setText:EMPTY_STRING];
        }
//    }
    
    
    [self.addressButton setTitleColor:[UIColor colorWithRed:0.0f/0.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1] forState:UIControlStateSelected];
    [self.addressButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if(IS_IPHONE)
        [self.addressButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0]];
    else
        [self.addressButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0]];

//    [self.viewBelowTable addSubview:self.addressButton];
    
}

-(void)btnAddress_Pressed:(UIButton*)sender
{

    NSMutableArray *temp = [NSMutableArray new];
  
    addressArray =  [[[NSUserDefaults standardUserDefaults] addressArray] mutableCopy];//[[Address all:nil] mutableCopy];
    
//    for (Address *tempAddressObj in addressArray)
//    {
//        [temp addObject:tempAddressObj.adressType];
//    }
    
    [temp addObject:@"Add Other"];
    
    if(!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        actionSheet = [[ActionSheetPickerCustom alloc]initWithStringPicker:EMPTY_STRING parentView:self.view dataArray:temp];
        
        actionSheet.delegate = self;
        [actionSheet showPicker];
    }
    else {
        
        ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            
            if([selectedValue isEqualToString:@"Add Other"])
            {
//                BBAddEditAddressViewController *myAddEditAddressViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BBAddEditAddressViewController"];
//                [self.navigationController pushViewController:myAddEditAddressViewController animated:YES];
            }
            else
            {
             
                selectedAddressIndex = selectedIndex;
//                Address * addressObj = [addressArray objectAtIndex:selectedIndex];
//                [self.addressButton setTitle:[addressObj adressType] forState:UIControlStateNormal];
//                [self.addressButton setTitle:[addressObj adressType] forState:UIControlStateSelected];
//                [self.lblMyAddress setText:[NSString stringWithFormat:@"%@, Cell: %@",[addressObj getFullAddress],addressObj.phoneNo]];
                //rafay        [self.lblPhoneNo setText:addressObj.phoneNo];
            }
            
        };
        ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
            NSLog(@"Block Picker Canceled");
        };
        // NSArray *colors = @[@"Red", @"Green", @"Blue", @"Orange"];
        [ActionSheetStringPicker showPickerWithTitle:@"Address" rows:temp initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    }
    
}

#pragma mark-  ActionSheet Delegate
-(void)cancleActionSheet:(ActionSheetPickerCustom *)actionSheet
{
    
}

-(void)selectedString:(ActionSheetPickerCustom *)actionSheet0 selectedString:(NSString *)selectedString indexPath:(NSInteger)indexPath
{
    if([selectedString isEqualToString:@"Add Other"])
    {
//        BBAddEditAddressViewController *myAddEditAddressViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BBAddEditAddressViewController"];
//        [self.navigationController pushViewController:myAddEditAddressViewController animated:YES];
    }
    else
    {
        selectedAddressIndex = indexPath;
//        Address * addressObj = [addressArray objectAtIndex:indexPath];
//        [self.addressButton setTitle:[addressObj adressType] forState:UIControlStateNormal];
//        [self.addressButton setTitle:[addressObj adressType] forState:UIControlStateSelected];
//        [self.lblMyAddress setText:[NSString stringWithFormat:@"%@, Cell: %@",[addressObj getFullAddress],addressObj.phoneNo]];
//rafay [self.lblPhoneNo setText:addressObj.phoneNo];
    }
    
}


@end
