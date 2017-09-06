//
//  BBAddressTypeViewController.m
//  BriskBiz
//
//  Created by Rafay on 9/23/15.
//  Copyright (c) 2015 Rafay. All rights reserved.
//

#import "BBAddressTypeViewController.h"

@interface BBAddressTypeViewController ()
{
    NSArray *arrAddressTypes;
    UITextField *activeTextField;
}
@end

@implementation BBAddressTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrAddressTypes = @[@"Home",@"Work",@"Other"];
    
//    self.baseDelegate =self;
//    [self setupNavigationBarTitle:@"SELECT TYPE" showRightButton:YES rightButtonType:UINavigationBarRightButtonTypeDone topBarImage:nil showBackGround:NO];
  
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithImage:[UIImage imageNamed:@"donebt@2x"]
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(optionsButtonClicked:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}


-(void)optionsButtonClicked:(id)sender
{
    
    [activeTextField resignFirstResponder];
    if (activeTextField.text.length > 0) {
        
        [self.delegate setTextAddressType:activeTextField.text];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return arrAddressTypes.count+2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 3) {
        
        return 44;
    }
    return 34;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier;
    UITableViewCell *cell;
    
    if (indexPath.row < 3 ) {
        CellIdentifier = @"Cell_Defaul_Types";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        [cell.textLabel setText:[arrAddressTypes objectAtIndex:indexPath.row]];
        NSLog(@"address selected = %@",self.addressTypeSelected);
        
        if ([self.addressTypeSelected isEqualToString:[arrAddressTypes objectAtIndex:indexPath.row]]) {
            
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
    else if(indexPath.row == 3)
    {
        CellIdentifier = @"Cell_Gray_Style";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
    }
    else
    {
        CellIdentifier = @"Cell_Custom_Types";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    // Configure the cell...
    
    
    
    return cell;
}
- (IBAction)backBtn_pressed:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.delegate setTextAddressType:[arrAddressTypes objectAtIndex:indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    if (textField.text.length > 0) {
        
        [self.delegate setTextAddressType:textField.text];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    activeTextField = textField;
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= 15 || returnKey;
}


@end
