//
//  ACHomeVC.h
//  AimsCareStore
//
//  Created by Adeel Ishaq on 2/20/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface ACHomeVC : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSString * subCategoryID;
@property (nonatomic, weak) IBOutlet UICollectionView * collectionVW;
@property (nonatomic, weak) IBOutlet UIPageControl * pageControl;
@property (nonatomic, weak) IBOutlet UIView * headerView;

@end
