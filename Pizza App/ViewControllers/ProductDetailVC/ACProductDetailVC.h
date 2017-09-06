//
//  ACProductDetailVC.h
//  AimsCareStore
//
//  Created by Adeel Ishaq on 12/26/16.
//  Copyright © 2016 finja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACProductDetailVC : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSDictionary * dictProduct;


@property (nonatomic, weak) IBOutlet UIScrollView * scrollVW;
@property (nonatomic, weak) IBOutlet UILabel * productTitle;
@property (nonatomic, weak) IBOutlet UILabel * productPrice;
@property (nonatomic, weak) IBOutlet UILabel * productDesc;
@property (nonatomic, weak) IBOutlet UILabel * lblSizeColors;

@property (nonatomic, weak) IBOutlet UIButton * btnDescription;
@property (nonatomic, weak) IBOutlet UIButton * btnTechnicalSpecifications;
@property (nonatomic, weak) IBOutlet UIButton * btnDimensions;

@property (nonatomic, weak) IBOutlet UITextView * txtDescription;
@property (nonatomic, weak) IBOutlet UITextView * txtTechnicalSpecifications;
@property (nonatomic, weak) IBOutlet UITextView * txtDimensions;

@property (nonatomic, weak) IBOutlet UICollectionView * collectionVW;
@property (nonatomic, weak) IBOutlet UICollectionView * sizesCollectionVW;

@end
