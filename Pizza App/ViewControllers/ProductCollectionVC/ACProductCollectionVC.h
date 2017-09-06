//
//  ACProductCollectionVC.h
//  AimsCareStore
//
//  Created by Adeel Ishaq on 12/26/16.
//  Copyright © 2016 finja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACProductCollectionVC : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSString * subCategoryID;
@property (nonatomic, weak) IBOutlet UICollectionView * collectionVW;
@end
