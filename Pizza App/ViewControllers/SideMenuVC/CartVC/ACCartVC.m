//
//  ACCartVC.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 1/21/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import "ACCartVC.h"
#import "ACCartTableViewCell.h"
//#import <SDWebImage/UIImageView+WebCache.h>

@interface ACCartVC () <UITableViewDelegate, UITableViewDataSource>
{
    float totalBill;
}
@property (nonatomic, weak) IBOutlet UITableView * tblVW;
@property (nonatomic, weak) IBOutlet UILabel * lblTotalBill;
@end

@implementation ACCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    totalBill = 0;
    _tblVW.delegate= self;
    _tblVW.dataSource = self;
    self.title = @"Cart";
    [self updateTotalBill];
}


-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = KAppTheme_COLOR;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],  NSFontAttributeName: ProximaNova_LIGHT(15)}];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithImage:[UIImage imageNamed:@"btnClearCart@2x"]
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(optionsButtonClicked:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

-(void)optionsButtonClicked:(id)sender
{
    [self btnCustomRightButton_Pressed];
}

-(void)btnCustomRightButton_Pressed
{
    [[ACCartSingeltonManager sharedManager].dictCartProducts removeAllObjects];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)btnAddmoreAction:(id)sender {
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
}

-(IBAction)btnCheckOutAction:(id)sender {
    ACCartBuyVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ACCartBuyVC"];
    [self.navigationController pushViewController:vc animated:YES];
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
    
//    [cell.imgProduct sd_setImageWithURL:[NSURL URLWithString:[[dict objectForKey:@"mainDict"]  valueForKey:@"image1"]] placeholderImage:[UIImage imageNamed:@"sitting.png"]];

    NSMutableDictionary * tempDict = [[ACCartSingeltonManager sharedManager].dictCartProducts objectForKey:strKey];
    NSMutableArray * arr = [tempDict objectForKey:@"arrayProducts"];
    
    
//    float totalPRice = [[[dict objectForKey:@"mainDict"]  valueForKey:@"price"] floatValue];
//    totalPRice *= arr.count;
//    
//    totalBill += totalPRice;
    
//    _lblTotalBill.text = [NSString stringWithFormat:@"Total Bill: £%.2f",totalBill];
    
    float totalPRice = 0.0f;
    NSMutableArray * arrPrices = [tempDict objectForKey:@"arrSelectedPrices"];

    for (NSString * singlePRice in arrPrices) {
        totalPRice += [singlePRice floatValue];
    }
    
    cell.lblTotalProductPrice.text = [NSString stringWithFormat:@"£%.2f",totalPRice];
    
    cell.lblProductCount.text = [NSString stringWithFormat:@"%lu",(unsigned long)arr.count];
    cell.btnProductPlus.tag = indexPath.row;
    cell.btnProductMinus.tag = indexPath.row;
    [cell.btnProductPlus addTarget:self action:@selector(plusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnProductMinus addTarget:self action:@selector(minusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    
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

-(void) updateTotalBill {
    
    totalBill = 0;
    
    for (NSString * key in [[ACCartSingeltonManager sharedManager].dictCartProducts allKeys]) {
        NSMutableDictionary * tempDict = [[ACCartSingeltonManager sharedManager].dictCartProducts objectForKey:key];
        NSMutableArray * arr = [tempDict objectForKey:@"arrSelectedPrices"];
        
        for (NSString * singlePRice in arr) {
            float totalPRice = [singlePRice floatValue];
            totalBill += totalPRice;
        }
    }
    _lblTotalBill.text = [NSString stringWithFormat:@"Total Bill: £%.2f",totalBill];
}

-(void)plusButtonClicked:(UIButton*)sender {

    NSArray * keysArray = [[ACCartSingeltonManager sharedManager].dictCartProducts allKeys];
    NSString * strKey = [keysArray objectAtIndex:sender.tag];
    NSDictionary * dict = [[ACCartSingeltonManager sharedManager].dictCartProducts objectForKey:strKey];

    NSMutableArray * arr = [dict objectForKey:@"arrayProducts"];
    [arr addObject:[dict objectForKey:@"mainDict"]];
    
    /*** Selected Colors  ****/
    NSMutableArray * arrSelectedColors =[dict objectForKey:@"arrSelectedColors"];;
    NSArray * arrDicColors = [[dict objectForKey:@"mainDict"] objectForKey:@"color"];
    
    if(arrDicColors.count > 0){
        [arrSelectedColors addObject:[arrDicColors objectAtIndex:0]];
    }
    
    /*** Selected Colors  ****/
    
    
    
    /*** Selected Prices  ****/
    NSMutableArray * arrSelectedPRices = [dict objectForKey:@"arrSelectedPrices"];
    NSString * price = [[dict objectForKey:@"mainDict"] objectForKey:@"price"];
    NSArray * arrDicPrices = [price componentsSeparatedByString:@","];
    
    if(arrDicPrices.count > 0){
        [arrSelectedPRices addObject:[arrDicPrices objectAtIndex:0]];
    }
    /*** Selected Prices  ****/
    
    /*** Selected Variations  ****/
    NSMutableArray * arrSelectedVariations = [dict objectForKey:@"arrSelectedVariations"];
    NSString * variation = [dict valueForKey:@"variation"];
    NSArray * arrDicVariations = [variation componentsSeparatedByString:@","];
    
    if(arrDicVariations.count > 0){
        [arrSelectedVariations addObject:[arrDicVariations objectAtIndex:0]];
    }
    /*** Selected Variations  ****/

    totalBill = 0;
    [self.tblVW reloadData];
    NSLog(@"%@",[ACCartSingeltonManager sharedManager].dictCartProducts);
    [self updateTotalBill];
}

-(void)minusButtonClicked:(UIButton*)sender {
    
    NSArray * keysArray = [[ACCartSingeltonManager sharedManager].dictCartProducts allKeys];
    NSString * strKey = [keysArray objectAtIndex:sender.tag];
    NSDictionary * dict = [[ACCartSingeltonManager sharedManager].dictCartProducts objectForKey:strKey];
    NSMutableArray * arr = [dict objectForKey:@"arrayProducts"];
    
    if(arr.count <= 1 ) {
        [[ACCartSingeltonManager sharedManager].dictCartProducts removeObjectForKey:strKey];
        
        [self.tblVW reloadData];
        NSLog(@"%@",[ACCartSingeltonManager sharedManager].dictCartProducts);
        [self updateTotalBill];

        return;
    }
    else {
        [arr removeObjectAtIndex:arr.count-1];
    }
    
    /*** Selected Colors  ****/
    NSMutableArray * arrSelectedColors =[dict objectForKey:@"arrSelectedColors"];;
    
    if(arrSelectedColors.count > 0){
        [arrSelectedColors removeObjectAtIndex:arrSelectedColors.count-1];
    }
    
    /*** Selected Colors  ****/
    
    /*** Selected Prices  ****/
    NSMutableArray * arrSelectedPRices = [dict objectForKey:@"arrSelectedPrices"];
    
    if(arrSelectedPRices.count > 0){
        [arrSelectedPRices removeObjectAtIndex:arrSelectedPRices.count-1];
    }
    /*** Selected Prices  ****/
    
    /*** Selected Variations  ****/
    NSMutableArray * arrSelectedVariations = [dict objectForKey:@"arrSelectedVariations"];
    
    if(arrSelectedVariations.count > 0){
        [arrSelectedVariations removeObjectAtIndex:arrSelectedVariations.count-1];
    }
    /*** Selected Variations  ****/
    
    totalBill = 0;
    [self.tblVW reloadData];
    NSLog(@"%@",[ACCartSingeltonManager sharedManager].dictCartProducts);
    [self updateTotalBill];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
