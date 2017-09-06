//
//  BBAddEditAddressViewController.m
//  BriskBiz
//
//  Created by Rafay on 9/23/15.
//  Copyright (c) 2015 Rafay. All rights reserved.
//

#import "BBAddEditAddressViewController.h"
#import "Constants.h"

@interface BBAddEditAddressViewController ()
{
    NSIndexPath *indexPathSelect;
}
@end

@implementation BBAddEditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cityInptCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"] invertedSet];
    
    addressArray = [NSMutableArray new];    
    addressArray =  [[[NSUserDefaults standardUserDefaults] addressArray] mutableCopy];//[[Address all:nil] mutableCopy];
    
    
    
    if (addressArray.count == 0) {
        
        [self addEmptyAddress];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tblAddress setEditing: YES animated: YES];

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"donebt@2x"]
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(optionsButtonClicked:)];
    self.navigationItem.rightBarButtonItem = rightButton;

//    [self setupNavigationBarTitle:@"ADD ADDRESSS" showRightButton:YES rightButtonType:UINavigationBarRightButtonTypeDone topBarImage:nil showBackGround:NO];
    [self.tblAddress setEditing: YES animated: YES];
    
}

-(void)btnCustomLeftButton_Pressed
{
//    [Address rollback];
    [self.navigationController popViewControllerAnimated:YES];

    
}
-(void)btnCustomRightButton_Pressed
{
    [activeTextField resignFirstResponder];
    [self saveAddresstoDB];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)backButtonClicked:(id)sender
{
    [self btnCustomLeftButton_Pressed];

}

-(void)optionsButtonClicked:(id)sender
{
     [self btnCustomRightButton_Pressed];
}
#pragma mark - TableView Delegates


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return addressArray.count+1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(IS_IPHONE)
    {
        if (indexPath.row == addressArray.count) {
            
            return 40;
        }
        return 161;
    }
    else
    {
        if (indexPath.row == addressArray.count) {
            
            return 85;
        }
        
        return 205;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier;
    
    if (indexPath.row == addressArray.count) {
        cellIdentifier = @"AddressAddCell";
    }
    else
    {
        cellIdentifier = @"AddressEditCell";
    }
    
    UITableViewCell *cell;
    
    cell= (UITableViewCell*)[self.tblAddress dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    if ([cellIdentifier isEqualToString:@"AddressEditCell"])
    {
        Address *objAddress = [addressArray objectAtIndex:indexPath.row];
        
        UITextField *txtStreet1 = (UITextField*)[cell viewWithTag:1];
        [txtStreet1 setText:objAddress.street1];
        
        if(IS_IPHONE)
        {
            UITextField *txtStreet2 = (UITextField*)[cell viewWithTag:2];
            [txtStreet2 setText:objAddress.street2];
        }
        
        UITextField *txtCity = (UITextField*)[cell viewWithTag:3];
        [txtCity setText:objAddress.city];
        
        int postalCode = [objAddress.postalCode intValue];
        
        UITextField *txtPostalCode = (UITextField*)[cell viewWithTag:4];
        
        if (postalCode != 0) {
            [txtPostalCode setText:[objAddress.postalCode stringValue]];
        }
        else
        {
            [txtPostalCode setText:@""];
        }
        
        
        UITextField *txtCountry = (UITextField*)[cell viewWithTag:5];
        [txtCountry setText:objAddress.country];
        
        
        
        UITextField *txtPhoneNo = (UITextField*)[cell viewWithTag:16];
        [txtPhoneNo setText:objAddress.phoneNo];
        
        UIButton *btnAddressType  = (UIButton*)[cell viewWithTag:17];
        
        btnAddressType.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        btnAddressType.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btnAddressType setTitle:objAddress.adressType forState:UIControlStateNormal];
        
        if (isAddNewCell) {
            activeTextField = txtStreet1;
            [self performSelector:@selector(becomeFirstResponder1:) withObject:txtStreet1 afterDelay:0.0];
            
            isAddNewCell = NO;
        }
    }
    
    return cell;
}

-(void)becomeFirstResponder1 :(id)sender
{
    
    [(UITextField*)sender becomeFirstResponder];
    
}
- (IBAction)btnCountry_pressed:(id)sender {
    
    BBCountryListViewController *countryController =[self.storyboard instantiateViewControllerWithIdentifier:@"BBCountryListViewController"];
    [self.navigationController pushViewController:countryController animated:NO];
    
}

- (IBAction)btnDeleteAddressPressed:(UIButton *)sender {
    
    indexPathSelect = [self.tblAddress indexPathForCell:[sender parentCell]];
    
    [self.tblAddress setEditing:YES animated:YES];
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [activeTextField resignFirstResponder];
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
//        Address *objAddress = [addressArray objectAtIndex:indexPath.row];
//        [addressArray removeObject:objAddress];
//        [Address deleteObject:objAddress];
        
        [addressArray removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setAddressArray:addressArray];
        
        [self.tblAddress deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
    }
    else if(editingStyle == UITableViewCellEditingStyleInsert)
    {
        [self addEmptyAddress];
    }
    
    
}

-(void)addEmptyAddress
{
    isAddNewCell = YES;
//    Adeel Later
    Address *objAddress = [[Address alloc] init];
    [objAddress setAddressId: [NSNumber numberWithInteger:addressArray.count+1]];
    
    objAddress.adressType = @"Home";
    objAddress.city = @"";
    objAddress.country = @"";
    objAddress.isActive = [NSNumber numberWithBool:NO];
    objAddress.phoneNo = @"";
    objAddress.postalCode = [NSNumber numberWithInteger:0];
    objAddress.street1 = @"";
    objAddress.street2 = @"";
    [addressArray insertObject:objAddress atIndex:[addressArray count]];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:addressArray.count-1 inSection:0];
    [self.tblAddress insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < addressArray.count) {
        return UITableViewCellEditingStyleDelete;
    }
    else
    {
        return UITableViewCellEditingStyleInsert;
    }
    
}

-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:YES animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    indexPathSelect = [self.tblAddress indexPathForCell:[sender parentCell]];
    
    
    if ([[segue identifier]isEqualToString:@"AddressType"]) {
        BBAddressTypeViewController *controller = [segue destinationViewController];
        controller.delegate = self;
        controller.addressTypeSelected = [(UIButton*)sender currentTitle];
    }
    else if ([[segue identifier]isEqualToString:@"CountryList"])
    {
        indexPathSelect = [self.tblAddress indexPathForCell:[sender parentCell]];
        BBCountryListViewController *controller = [segue destinationViewController];
        controller.delegate=self;
        
        
    }
    
}

-(void)setText:(NSString*)country
{
    UITableViewCell *cell = [self.tblAddress cellForRowAtIndexPath:indexPathSelect];
    
    activeTextField = (UITextField*)[cell viewWithTag:5];
    UIImageView *imgCountryLine = (UIImageView*)[cell viewWithTag:10];
    
    if (country.length > 8) {
        
        
        imgCountryLine.frame = CGRectMake(imgCountryLine.frame.origin.x, imgCountryLine.frame.origin.y, 195,imgCountryLine.frame.size.height);
        
        imgCountryLine.image = [UIImage imageNamed:@"street_text_line.png"];
        
    }
    else
    {
        imgCountryLine.frame = CGRectMake(imgCountryLine.frame.origin.x, imgCountryLine.frame.origin.y, 80,imgCountryLine.frame.size.height);
        
        imgCountryLine.image = [UIImage imageNamed:@"city_text_line.png"];
    }
    
    [activeTextField setText:country];
    
    Address *addressObj = [addressArray objectAtIndex:indexPathSelect.row];
    addressObj.country = country;
    NSLog(@"country = %@",addressObj.country);
}

-(void)setTextAddressType : (NSString*)addressType
{
    UITableViewCell *cell = [self.tblAddress cellForRowAtIndexPath:indexPathSelect];
    UIButton *btnAddressType = (UIButton*)[cell viewWithTag:17];
    
    [btnAddressType setTitle:addressType forState:UIControlStateNormal];
    
    Address *addressObj = [addressArray objectAtIndex:indexPathSelect.row];
    addressObj.adressType = addressType;
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    indexPathSelect = [self.tblAddress indexPathForCell:[textField parentCell]];
    activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = [self.tblAddress indexPathForCell:[textField parentCell]];
    
    Address *addressObj = [addressArray objectAtIndex:indexPath.row];
    
    if (textField.tag == 1) {
        addressObj.street1 = textField.text;
    }
    else if(textField.tag == 2)
    {
        addressObj.street2 = textField.text;
    }
    else if(textField.tag == 3)
    {
        addressObj.city = textField.text;
    }
    else if(textField.tag == 4)
    {
        addressObj.postalCode = [NSNumber numberWithInt:(int)[textField.text integerValue]];
    }
    else if(textField.tag == 16)
    {
        addressObj.phoneNo = textField.text;
    }
    NSLog(@"%@",textField.text);
    NSLog(@"array %@", addressArray);//[[Address all:nil] mutableCopy];

}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [activeTextField resignFirstResponder];
}

-(void)saveAddresstoDB
{
    NSMutableArray * arr = [NSMutableArray new];

//    Adeel Later
    for (Address *objRAAddress in addressArray)
    {
        //if empty all fields dele object
        if ([objRAAddress.postalCode integerValue] == 0 &&
            objRAAddress.city.length == 0 &&
            objRAAddress.street1.length == 0 &&
            objRAAddress.street2.length == 0 &&
            objRAAddress.country.length == 0 &&
            objRAAddress.phoneNo.length == 0 &&
            objRAAddress.myOrder.count == 0
            ) {
        }
        else {
            [arr addObject:objRAAddress];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setAddressArray:arr];
    NSLog(@"array %@", [[NSUserDefaults standardUserDefaults] addressArray]);//[[Address all:nil] mutableCopy];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return NO;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField.tag == 3) {
        
        return ([string rangeOfCharacterFromSet:cityInptCharacters].location == NSNotFound);
        
    }
    else if (textField.tag == 16) {
        
        NSUInteger oldLength = [textField.text length];
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
        
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
        
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= 15 || returnKey;
    }
    else if (textField.tag == 4) {
        
        NSUInteger oldLength = [textField.text length];
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
        
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
        
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= 10 || returnKey;
    }
    
    return YES;
    
}

@end
