//
//  ACCartTableViewCell.h
//  AimsCareStore
//
//  Created by Adeel Ishaq on 1/21/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACCartTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView * imgProduct;
@property (nonatomic, weak) IBOutlet UILabel * lblProduct;
@property (nonatomic, weak) IBOutlet UILabel * lblProductCount;
@property (nonatomic, weak) IBOutlet UILabel * lblProductPrice;
@property (nonatomic, weak) IBOutlet UIButton * btnProductPlus;
@property (nonatomic, weak) IBOutlet UIButton * btnProductMinus;
@property (nonatomic, weak) IBOutlet UILabel * lblTotalProductPrice;

@end
