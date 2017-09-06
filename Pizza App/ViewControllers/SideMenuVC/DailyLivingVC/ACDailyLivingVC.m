//
//  ACDailyLivingVC.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 12/23/16.
//  Copyright © 2016 finja. All rights reserved.
//

#import "ACDailyLivingVC.h"
#import "FMMosaicCellView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ACProductCollectionVC.h"

@interface ACDailyLivingVC () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    UILabel *numberBadge;
}
@property (nonatomic, strong) NSMutableArray *arrResponce;

@end

@implementation ACDailyLivingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [[NSUserDefaults standardUserDefaults] categoryTitle];
    _arrResponce = [NSMutableArray new];
    
    ACAPIManager *manager = [ACAPIManager new];
    [manager specificCategory:[[NSUserDefaults standardUserDefaults] categoryID]  completionBlock:^(NSString *message, NSMutableArray * resArr,BOOL isSuccessfull) {
        _arrResponce = resArr;
        [self.collectionView reloadData];
       // NSLog(@"%@",resArr);
    }];

    [self.collectionView  setBackgroundColor:KAppTheme_COLOR];
    [self.view setBackgroundColor:KAppTheme_COLOR];
    [self adjustContentInsets];
    [self addCartView];
  }

-(void)addCartView {
    numberBadge = [[UILabel alloc] initWithFrame:CGRectMake(26.4, 0, 14,12)];
    numberBadge.text = [NSString stringWithFormat:@"%lu",(unsigned long)[[ACCartSingeltonManager sharedManager].dictCartProducts allKeys].count];
    numberBadge.textColor = [UIColor whiteColor];
    numberBadge.textAlignment = NSTextAlignmentCenter;
    numberBadge.font = [UIFont systemFontOfSize:10.0f];
    numberBadge.numberOfLines = 1;
    numberBadge.adjustsFontSizeToFitWidth = YES;
    numberBadge.lineBreakMode = NSLineBreakByClipping;
    
    
    // Allocate UIButton
    UIButton *badgeButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    badgeButton.frame = CGRectMake(0, 0, 40, 26.4);
    badgeButton.layer.cornerRadius = 8;
    [badgeButton setBackgroundImage:[UIImage imageNamed:@"cart-icon"] forState:UIControlStateNormal];
    [badgeButton addTarget:self action:@selector(btnCartAction:) forControlEvents:UIControlEventTouchUpInside];
    [badgeButton setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.1 alpha:0.2]];
    [badgeButton addSubview: numberBadge]; //Add NKNumberBadgeView as a subview on UIButton
    badgeButton.backgroundColor = [UIColor clearColor];
    
    // Initialize UIBarbuttonitem…
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:badgeButton];
    self.navigationItem.rightBarButtonItem = barButton;

}

- (IBAction)btnCartAction:(id)sender {
    
        ACCartVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ACCartVC"];
        [self.navigationController pushViewController:vc animated:YES];
}

- (void)adjustContentInsets {
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.contentInset = insets;
    self.collectionView.scrollIndicatorInsets = insets;
}


-(void)viewWillAppear:(BOOL)animated {
    
    numberBadge.text = [NSString stringWithFormat:@"%lu",(unsigned long)[[ACCartSingeltonManager sharedManager].dictCartProducts allKeys].count];

    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = KRED_COLOR;
    self.navigationController.navigationBar.barTintColor = KAppTheme_COLOR;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],  NSFontAttributeName: ProximaNova_LIGHT(15)}];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(menuAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"menu-icon"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 20.0, 30.0, 20.0);
    [button setContentMode:UIViewContentModeScaleAspectFit];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]
                                   initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = buttonItem;
    
}

- (void) menuAction: (id) sender {
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _arrResponce.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMMosaicCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FMMosaicCellView reuseIdentifier] forIndexPath:indexPath];
    
    // Configure the cell
    NSDictionary * dict = [_arrResponce objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [dict valueForKey:@"name"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"sitting.png"]];
//    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    cell.imageView.clipsToBounds = YES;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_arrResponce.count == 3) {
        return CGSizeMake(KSCREEN_WIDTH, (KSCREEN_HEIGHT-([[[self tabBarController] tabBar] bounds].size.height * 2))/3 -5);

    }
    if(_arrResponce.count == 6) {
        return CGSizeMake(KSCREEN_WIDTH/2-5, (KSCREEN_HEIGHT-([[[self tabBarController] tabBar] bounds].size.height * 2))/3 -5);
        
    }
    if(_arrResponce.count == 5) {
        if (indexPath.row == 2)
            return CGSizeMake(KSCREEN_WIDTH, (KSCREEN_HEIGHT-([[[self tabBarController] tabBar] bounds].size.height * 2))/3 -5);

        return CGSizeMake(KSCREEN_WIDTH/2-5, (KSCREEN_HEIGHT-([[[self tabBarController] tabBar] bounds].size.height * 2))/3 -5);
    }
    
    if(_arrResponce.count == 9) {
        if (indexPath.row == 5)
            return CGSizeMake(KSCREEN_WIDTH, (KSCREEN_HEIGHT-([[[self tabBarController] tabBar] bounds].size.height * 2))/4 -5);
        
        return CGSizeMake(KSCREEN_WIDTH/2-5, (KSCREEN_HEIGHT-([[[self tabBarController] tabBar] bounds].size.height * 2))/4 -5);
    }
    
    if(_arrResponce.count == 8 || _arrResponce.count == 10) {
        
        return CGSizeMake(KSCREEN_WIDTH/2-5, (KSCREEN_HEIGHT-([[[self tabBarController] tabBar] bounds].size.height * 2))/(_arrResponce.count/2) -5);
    }
    
    return CGSizeMake(KSCREEN_WIDTH, (KSCREEN_HEIGHT-([[[self tabBarController] tabBar] bounds].size.height * 2))/(_arrResponce.count/2 <1? 1 : _arrResponce.count/2) -5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * dict = [_arrResponce objectAtIndex:indexPath.row];
    
    ACProductCollectionVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ACProductCollectionVC"];
    vc.subCategoryID = [dict valueForKey:@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}



- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

#pragma mark - Status Bar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}




@end
