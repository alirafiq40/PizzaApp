//
//  ACSearchVcViewController.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 1/21/17.
//  Copyright © 2017 finja. All rights reserved.
//

#import "ACSearchVcViewController.h"
#import "ACProductCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ACProductDetailVC.h"
#import "AppDelegate.h"
#import "RESideMenu.h"

@interface ACSearchVcViewController ()<CAAnimationDelegate>
{
    UILabel *numberBadge;
    NSMutableArray *searchResults;
    BOOL isSearching;
    UIImageView *imageViewLogo;
}
@property (nonatomic, strong) NSMutableArray *arrResponce;
@property (nonatomic, strong) IBOutlet UIButton *btnSignIn;

@end

@implementation ACSearchVcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _collectionVW.delegate = self;
    _collectionVW.dataSource = self;
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];

    self.searchBar.layer.borderWidth = 1.0f;
    self.searchBar.layer.borderColor = [KAppTheme_COLOR CGColor];

    
    self.searchBar.delegate = self;
    //    self.searchBar.showsCancelButton = YES;
    searchResults = [[NSMutableArray alloc] init];
    isSearching = NO;

    ACAPIManager *manager = [ACAPIManager new];
    [manager allProductsList:^(NSString *message, NSMutableArray * resArr,BOOL isSuccessfull) {
        
        _arrResponce = resArr;
        [self.collectionVW reloadData];
        // NSLog(@"%@",resArr);
    }];
    
    if([[NSUserDefaults standardUserDefaults] isUserLogin]) {
        [_btnSignIn setHidden:true];
        [_searchBar setFrame:CGRectMake(_btnSignIn.frame.origin.x, _searchBar.frame.origin.y,  _searchBar.frame.size.width + _btnSignIn.frame.size.width,  _searchBar.frame.size.height)];
    }
    
}

-(IBAction)btnSignInAction:(id)sender {
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ACLoginVC"]] animated:NO];
}


-(void)viewWillAppear:(BOOL)animated {
    
//    self.title = @"Search";
    
    imageViewLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ACS_DarkOrange.png"]];
    CGSize imageSize = CGSizeMake(100, 51);
    CGFloat marginX = (self.navigationController.navigationBar.frame.size.width / 2) - (imageSize.width / 2);
    imageViewLogo.frame = CGRectMake(marginX, 0, imageSize.width, imageSize.height);
    [self.navigationController.navigationBar addSubview:imageViewLogo];

    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = KAppTheme_COLOR;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],  NSFontAttributeName: ProximaNova_LIGHT(15)}];

    [self.searchBar setBarTintColor:KAppTheme_COLOR];

    [self addCartView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [imageViewLogo removeFromSuperview];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(isSearching)
        return searchResults.count;
    
    return _arrResponce.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KSCREEN_WIDTH-40)/2, 200);
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ACProductCollectionViewCell *cell = (ACProductCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ACProductCollectionViewCell" forIndexPath:indexPath];
    
    NSMutableDictionary * dict;
    
    if(isSearching)
    dict = [searchResults objectAtIndex:indexPath.row];
    else
    dict = [_arrResponce objectAtIndex:indexPath.row];
    
    [cell.imgProduct sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"image1"]] placeholderImage:[UIImage imageNamed:@"sitting.png"]];
    cell.titleProduct.text = [dict valueForKey:@"name"];
    

    cell.contentView.layer.cornerRadius = 4.0f;
    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.borderColor = KAppTheme_COLOR.CGColor;
    cell.contentView.layer.masksToBounds = YES;

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * dict;
    
    if(isSearching)
        dict = [searchResults objectAtIndex:indexPath.row];
    else
        dict = [_arrResponce objectAtIndex:indexPath.row];
    
    ACProductDetailVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ACProductDetailVC"];
    vc.dictProduct = dict;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- Button Actions

-(void)plusButtonClicked:(UIButton*)sender
{
    NSMutableDictionary * dict = [_arrResponce objectAtIndex:sender.tag];
    
    if ([[ACCartSingeltonManager sharedManager].dictCartProducts objectForKey:[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]]]) {
        NSMutableDictionary * tempDict = [[ACCartSingeltonManager sharedManager].dictCartProducts objectForKey:[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]]];
        NSMutableArray * arr = [tempDict objectForKey:@"arrayProducts"];
        [arr addObject:dict];
        
        /*** Selected Colors  ****/
        NSMutableArray * arrSelectedColors =[tempDict objectForKey:@"arrSelectedColors"];;
        NSArray * arrDicColors = [dict objectForKey:@"color"];
        
        if([arrDicColors isKindOfClass:[NSArray class]]){
        if(arrDicColors.count > 0){
            [arrSelectedColors addObject:[arrDicColors objectAtIndex:0]];
        }
        }
        /*** Selected Colors  ****/
        
        /*** Selected Prices  ****/
        NSMutableArray * arrSelectedPRices = [tempDict objectForKey:@"arrSelectedPrices"];
        NSString * price = [dict valueForKey:@"price"];
        NSArray * arrDicPrices = [price componentsSeparatedByString:@","];
        
        if(arrDicPrices.count > 0){
            [arrSelectedPRices addObject:[arrDicPrices objectAtIndex:0]];
        }
        /*** Selected Prices  ****/
        
        /*** Selected Variations  ****/
        NSMutableArray * arrSelectedVariations = [tempDict objectForKey:@"arrSelectedVariations"];
        NSString * variation = [dict valueForKey:@"variation"];
        NSArray * arrDicVariations = [variation componentsSeparatedByString:@","];
        
        if(arrDicVariations.count > 0){
            [arrSelectedVariations addObject:[arrDicVariations objectAtIndex:0]];
        }
        /*** Selected Variations  ****/
        
    }
    else {
        NSMutableDictionary * tempDict = [[NSMutableDictionary alloc] init];
        NSMutableArray * arr = [[NSMutableArray alloc] init];
        [arr addObject:dict];
        
        /*** Selected Colors  ****/
        NSMutableArray * arrSelectedColors = [[NSMutableArray alloc] init];
        NSArray * arrDicColors = [dict objectForKey:@"color"];
        
        if([arrDicColors isKindOfClass:[NSArray class]]){
        if(arrDicColors.count > 0){
            [arrSelectedColors addObject:[arrDicColors objectAtIndex:0]];
        }
            [tempDict setObject:arrSelectedColors forKey:@"arrSelectedColors"];
        }
        else {
            [tempDict setObject:[NSMutableArray new] forKey:@"arrSelectedColors"];
        }
        
        /*** Selected Colors  ****/
        
        
        /*** Selected Prices  ****/
        NSMutableArray * arrSelectedPRices = [[NSMutableArray alloc] init];
        NSString * price = [dict valueForKey:@"price"];
        NSArray * arrDicPrices = [price componentsSeparatedByString:@","];
        
        if(arrDicPrices.count > 0){
            [arrSelectedPRices addObject:[arrDicPrices objectAtIndex:0]];
        }
        [tempDict setObject:arrSelectedPRices forKey:@"arrSelectedPrices"];
        /*** Selected Prices  ****/

        /*** Selected Variations  ****/
        NSMutableArray * arrSelectedVariations = [[NSMutableArray alloc] init];
        NSString * variation = [dict valueForKey:@"variation"];
        NSArray * arrDicVariations = [variation componentsSeparatedByString:@","];
        
        if(arrDicVariations.count > 0){
            [arrSelectedVariations addObject:[arrDicVariations objectAtIndex:0]];
        }
        [tempDict setObject:arrSelectedVariations forKey:@"arrSelectedVariations"];
        /*** Selected Variations  ****/
        
        [tempDict setObject:arr forKey:@"arrayProducts"];
        [tempDict setObject:dict forKey:@"mainDict"];
        
        [[ACCartSingeltonManager sharedManager].dictCartProducts setObject:tempDict forKey:[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]]];
    }
    
    
    NSLog(@"%@",[ACCartSingeltonManager sharedManager].dictCartProducts);
    NSIndexPath *ip = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    [self addToCartTapped:ip];
    
}

- (void)addToCartTapped:(NSIndexPath*)indexPath
{
    
    UICollectionViewCell *cell = [self.collectionVW cellForItemAtIndexPath:indexPath];
    
    UIView *view = (UIView*)cell.contentView;
    [view setBackgroundColor:[UIColor whiteColor]];
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageViewToAdd = [[UIImageView alloc] initWithImage:resultingImage];
    [imageViewToAdd setBackgroundColor:[UIColor whiteColor]];
    imageViewToAdd.layer.cornerRadius=5;
    //imageViewToAdd.layer.borderColor=(__bridge CGColorRef)(COLLECTIONVIEW_BACKGROUND);
    imageViewToAdd.layer.borderWidth=0;
    
    // get the exact location of image
    CGRect rect = [view.superview convertRect:imageViewToAdd.frame fromView:nil];
    rect = CGRectMake(5, (rect.origin.y*-1)-10, imageViewToAdd.frame.size.width, view.frame.size.height);
    //NSLog(@"rect is %f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    
    // create new duplicate image
    UIView *starView =  [[UIView alloc] initWithFrame:imageViewToAdd.frame];
    [starView setFrame:rect];
    starView.layer.cornerRadius=5;
    [starView setBackgroundColor:[UIColor whiteColor]];
    starView.layer.borderColor=[[UIColor blackColor]CGColor];
    starView.layer.borderWidth=1;
    [starView addSubview:imageViewToAdd];
    starView.tag = 9999999;
    AppDelegate *appDelegate =(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.window addSubview:starView];
    
    //[self.view addSubview:starView];
    
    // begin ---- apply position animation
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.duration=0.65;
    pathAnimation.delegate=self;
    
    // tab-bar right side item frame-point = end point
    
    CGPoint endPoint;
    if (IS_IPHONE)
    {
        endPoint = CGPointMake(300, 40);
    }
    
    else
    {
        endPoint = CGPointMake(738, 40);
    }
    if(IS_IPHONE) {
        if (indexPath.row%2 == 0)
        {
            CGMutablePathRef curvedPath = CGPathCreateMutable();
            CGPathMoveToPoint(curvedPath, NULL, 29, starView.frame.origin.y+starView.frame.size.height/2);
            CGPathAddCurveToPoint(curvedPath, NULL, endPoint.x, starView.frame.origin.y, endPoint.x, starView.frame.origin.y, endPoint.x, endPoint.y);
            pathAnimation.path = curvedPath;
            CGPathRelease(curvedPath);
        }
        else
        {
            CGMutablePathRef curvedPath = CGPathCreateMutable();
            CGPathMoveToPoint(curvedPath, NULL, 176, starView.frame.origin.y+starView.frame.size.height/2);
            CGPathAddCurveToPoint(curvedPath, NULL, endPoint.x, starView.frame.origin.y, endPoint.x, starView.frame.origin.y, endPoint.x, endPoint.y);
            pathAnimation.path = curvedPath;
            CGPathRelease(curvedPath);
        }
    }
    else
    {
        if (indexPath.row%2 == 0)
        {
            CGMutablePathRef curvedPath = CGPathCreateMutable();
            CGPathMoveToPoint(curvedPath, NULL, 29, starView.frame.origin.y+starView.frame.size.height/2);
            CGPathAddCurveToPoint(curvedPath, NULL, endPoint.x, starView.frame.origin.y, endPoint.x, starView.frame.origin.y, endPoint.x, endPoint.y);
            pathAnimation.path = curvedPath;
            CGPathRelease(curvedPath);
        }
        else
        {
            CGMutablePathRef curvedPath = CGPathCreateMutable();
            CGPathMoveToPoint(curvedPath, NULL, 400, starView.frame.origin.y+starView.frame.size.height/2);
            CGPathAddCurveToPoint(curvedPath, NULL, endPoint.x, starView.frame.origin.y, endPoint.x, starView.frame.origin.y, endPoint.x, endPoint.y);
            pathAnimation.path = curvedPath;
            CGPathRelease(curvedPath);
        }
    }
    
    // end ---- apply position animation
    
    // apply transform animation
    CABasicAnimation *basic=[CABasicAnimation animationWithKeyPath:@"transform"];
    [basic setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.05, 0.05, 0.05)]];
    [basic setAutoreverses:YES];
    [basic setDuration:0.65];
    [starView.layer addAnimation:pathAnimation forKey:@"curveAnimation"];
    [starView.layer addAnimation:basic forKey:@"transform"];
    
    [UIView animateWithDuration:0.67
                     animations:^{starView.alpha = 0.6;}
                     completion:^(BOOL finished){
                         starView.alpha = 0.0;
                         [starView removeFromSuperview];
                         numberBadge.text = [NSString stringWithFormat:@"%lu",(unsigned long)[[ACCartSingeltonManager sharedManager].dictCartProducts allKeys].count];
                     }];
}

#pragma mark - SearchBar

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
    searchResults = [_arrResponce mutableCopy];
    [self.collectionVW reloadData];
    searchBar.showsCancelButton = true;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = false;
}



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d",isSearching);
    
    //Remove all objects first.
    
    if([searchText length] != 0) {
        isSearching = YES;
        [self searchTableList];
    }
    else {
        isSearching = NO;
        
        [self.collectionVW reloadData];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
    isSearching = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
    
    [searchResults removeAllObjects];
    
    [self.collectionVW reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
}

- (void)searchTableList {
    [searchResults removeAllObjects];

    NSString *searchString = self.searchBar.text;
    
    for (NSDictionary *dict in _arrResponce) {
        NSInteger  length  = [[dict valueForKey:@"name"] length];
        
        if (length > [searchString length])
            length = [searchString length];
        
        NSComparisonResult result = [[dict valueForKey:@"name"] compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, length)];
        if (result == NSOrderedSame) {
            [searchResults addObject:dict];
        }
    }
    
    [self.collectionVW reloadData];
}

@end
