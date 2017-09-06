//
//  ActionSheetPicker.m
//  wealize
//
//  Created by Afzaal Ahmad on 7/19/13.
//  Copyright (c) 2013 DevBatch. All rights reserved.
//

#import "ActionSheetPickerCustom.h"

@implementation ActionSheetPickerCustom

@synthesize delegate;


- (id)initWithDatePicker:(NSString *)title parentView : (UIView*)parentView
{
    self = [super init];
    if (self) {
       
        if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
            {
            actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:nil];
                
            parent = parentView;
            
            // Add the picker
            datePickerView = [[UIDatePicker alloc] init];
            datePickerView.datePickerMode = UIDatePickerModeDate;
            [actionSheet addSubview:datePickerView];
        
            [self addToolBar];
            }
       
        else {
            alertController =[UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:alertAction];
            
            // Add the picker
            datePickerView = [[UIDatePicker alloc] init];
            datePickerView.datePickerMode = UIDatePickerModeDate;
      
            [alertController.view addSubview:datePickerView];

            
             [self addToolBar];
            }
        
            isDatePicker = YES;
    }
    return self;
}


- (id)initWithStringPicker:(NSString *)title parentView : (UIView*)parentView dataArray:(NSArray*)dataArray
{
    self = [super init];
    if (self) {
        
        if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
        actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
        parent = parentView;
        
        dataArr = dataArray;
        pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        
        pickerView.delegate = self;
        
        pickerView.dataSource = self;
        
        
        [pickerView setBackgroundColor:[UIColor whiteColor]];
        [pickerView  setShowsSelectionIndicator:YES];
        
        [actionSheet addSubview:pickerView];
        
        if (dataArr.count > 0)
        {
            selectedString = [dataArr objectAtIndex:0];
        }
        [self addToolBar];
        }
        else {
            
            alertController =[UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:alertAction];
            parent = parentView;
            
            dataArr = dataArray;
            pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
            
            pickerView.delegate = self;
            
            pickerView.dataSource = self;
            
            
            [pickerView setBackgroundColor:[UIColor whiteColor]];
            [pickerView  setShowsSelectionIndicator:YES];
            
            [alertController.view addSubview:pickerView];
            
            if (dataArr.count > 0)
            {
                selectedString = [dataArr objectAtIndex:0];
            }
            [self addToolBar];
            

            

            
        }
        
    }
    return self;
    

}

-(void)addToolBar
{
    UIToolbar *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerDateToolbar.barStyle = UIBarStyleDefault;
    [pickerDateToolbar sizeToFit];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClick:)];
    //[barItems addObject:doneBtn];
    
    UIBarButtonItem *cancleBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pickerCancleClick:)];
    UIBarButtonItem *spaceBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];

    [pickerDateToolbar setItems:[NSArray arrayWithObjects:cancleBtn,spaceBtn,doneBtn, nil] animated:YES];
    if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {

        [actionSheet addSubview:pickerDateToolbar];
    }
    else {
        [alertController.view addSubview:pickerDateToolbar];
        
    }
    
}

-(void)showPicker
{
    if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {

    [actionSheet showInView:parent];
    CGRect actionSheetRect = actionSheet.frame;
    CGFloat orgHeight = actionSheetRect.size.height;
    actionSheetRect.origin.y -= 220; //height of picker
    actionSheetRect.size.height = orgHeight+220;
    actionSheet.frame = actionSheetRect;
       if (isDatePicker)
    {
        
        CGRect pickerRect = datePickerView.frame;
        pickerRect.origin.y = orgHeight;
        datePickerView.frame = pickerRect;
    }
    else
    {
        
        CGRect pickerRect = pickerView.frame;
        pickerRect.origin.y = orgHeight;
        pickerView.frame = pickerRect;
         
    }
    }
    else{
        
      popover = alertController.popoverPresentationController;
        if (!popover)
        {
         
            popover.sourceRect = CGRectMake(0,-220, 150, 220);
            
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
        
        
    }


}

-(void)setMinimumDate :(NSDate*)minimumDate
{
    datePickerView.minimumDate = minimumDate;
}


#pragma mark- UIToolBar Buttons Actions

-(void)pickerDoneClick :(id)sender
{
    if (isDatePicker) {
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@""];
        
        selectedString = [outputFormatter stringFromDate:datePickerView.date];
        [delegate selectedString:self selectedString:selectedString  indexPath:selectedIntegar];
    }
    else
    {
        [delegate selectedString:self selectedString:selectedString  indexPath:selectedIntegar];
    }
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];

}

-(void)pickerCancleClick :(id)sender
{
    [delegate cancleActionSheet:self];
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark- UIPickerView DataSource & Delegates
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [dataArr count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [dataArr objectAtIndex:row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    selectedString = (NSString *)[dataArr objectAtIndex:row];
    selectedIntegar=row;
}

@end
