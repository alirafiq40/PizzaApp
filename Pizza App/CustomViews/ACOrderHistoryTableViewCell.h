//
//  ACOrderHistoryTableViewCell.h
//  AimsCareStore
//
//  Created by Adeel Ishaq on 1/21/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACOrderHistoryTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel * lblItemsList;
@property (nonatomic, weak) IBOutlet UILabel * lblAddress;
@property (nonatomic, weak) IBOutlet UILabel * lblTotalPrice;

@end
