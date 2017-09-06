//
//  ACSearchVcViewController.h
//  AimsCareStore
//
//  Created by Adeel Ishaq on 1/21/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACSearchVcViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) NSString * subCategoryID;
@property (nonatomic, weak) IBOutlet UICollectionView * collectionVW;
@property (weak, nonatomic) IBOutlet UISearchBar * searchBar;

@end
