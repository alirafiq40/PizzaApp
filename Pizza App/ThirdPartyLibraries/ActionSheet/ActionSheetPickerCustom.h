//
//  ActionSheetPicker.h
//  wealize
//
//  Created by Afzaal Ahmad on 7/19/13.
//  Copyright (c) 2013 DevBatch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
@class ActionSheetPickerCustom;

#pragma mark- ActionSheetDelegate Protocol
@protocol ActionSheetPickerCustomDelegate

// define protocol functions that can be used in any class using this delegate
-(void)selectedString :(ActionSheetPickerCustom*) actionSheet selectedString:(NSString*)selectedString  indexPath:(NSInteger)indexPath;
-(void)cancleActionSheet :(ActionSheetPickerCustom*) actionSheet;

@end

@interface ActionSheetPickerCustom : NSObject <UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIActionSheet *actionSheet;
    UIDatePicker *datePickerView;
    UIView *parent;
    
    BOOL isDatePicker;
    NSString *selectedString;
    NSUInteger selectedIntegar;
    UIPickerView *pickerView;
    NSArray *dataArr;
    UIPopoverPresentationController *popover;
    UIAlertController *alertController;
}
@property (nonatomic, assign) id  delegate;


- (id)initWithDatePicker:(NSString *)title parentView : (UIView*)parentView;
- (id)initWithStringPicker:(NSString *)title parentView : (UIView*)parentView dataArray:(NSArray*)dataArray;
-(void)showPicker;

-(void)setMinimumDate :(NSDate*)minimumDate;
@end
