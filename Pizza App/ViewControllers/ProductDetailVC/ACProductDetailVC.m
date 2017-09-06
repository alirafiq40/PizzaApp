//
//  ACProductDetailVC.m
//  AimsCareStore
//
//  Created by Adeel Ishaq on 12/26/16.
//  Copyright © 2016 finja. All rights reserved.
//

#import "ACProductDetailVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProfileImagesViewerVC.h"

enum {
    noOneClicked =0,
    description=1,
    technicalDetails=2,
    dimensions=3,
}subViewPressed;


@interface ACProductDetailVC () <UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    NSMutableArray * arrImages;
    NSArray * arrColors;
    UILabel *numberBadge;
    int selectedColor;
    int selectedSize;
}
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScroller;

@end

@implementation ACProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    subViewPressed = noOneClicked;
    [self updateSubViews];
    
    [self updateSizeColorDetail];
    
    selectedColor = 0;
    selectedSize = 0;
    arrColors = [NSArray new];
    
//    if([_prevMatch.profileImages isKindOfClass:[NSArray class]]){
       int profilePicCount = 0;
//    NSArray * arrImages = [NSArray new];
    
    NSLog(@"%@",_dictProduct);
    
    _productTitle.text = [_dictProduct valueForKey:@"name"];
    
    NSString * price = [_dictProduct valueForKey:@"price"];
    NSArray * arrDicPrices = [price componentsSeparatedByString:@","];
    _productPrice.text = [NSString stringWithFormat:@"£%@",[arrDicPrices objectAtIndex:selectedSize]];
    
//    _productPrice.text = [NSString stringWithFormat:@"£%@",[_dictProduct valueForKey:@"price"]];

    if(![[_dictProduct valueForKey:@"description"] isEqualToString:@""]) {
        [_txtDescription setText:[_dictProduct valueForKey:@"description"]];
    }
    else {
        [_txtDescription setHidden:true];
        [_btnDescription setHidden:true];
    }

    if(![[_dictProduct valueForKey:@"variation"] isEqualToString:@""]) {
        [_txtTechnicalSpecifications setText:[_dictProduct valueForKey:@"variation"]];
    }
    else {
        [_txtTechnicalSpecifications setHidden:true];
        [_btnTechnicalSpecifications setHidden:true];
    }
    
     arrImages = [[NSMutableArray alloc] init];
    if(![[_dictProduct valueForKey:@"image1"] isEqualToString:@""])  [arrImages addObject:[_dictProduct valueForKey:@"image1"]];
    if(![[_dictProduct valueForKey:@"image2"] isEqualToString:@""])  [arrImages addObject:[_dictProduct valueForKey:@"image2"]];
    if(![[_dictProduct valueForKey:@"image3"] isEqualToString:@""])  [arrImages addObject:[_dictProduct valueForKey:@"image3"]];
    if(![[_dictProduct valueForKey:@"image4"] isEqualToString:@""])  [arrImages addObject:[_dictProduct valueForKey:@"image4"]];
    if(![[_dictProduct valueForKey:@"image5"] isEqualToString:@""])  [arrImages addObject:[_dictProduct valueForKey:@"image5"]];
    
    if([[_dictProduct objectForKey:@"color"] isKindOfClass:[NSArray class]]) {
     arrColors = (NSArray*)[_dictProduct objectForKey:@"color"];
    }
    [_collectionVW reloadData];
    
    _imageScroller.delegate = self;
    
        for(NSString * profilePic in arrImages){
            
            
            if([profilePic isKindOfClass:[NSString class]]){
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(profilePicCount*KSCREEN_WIDTH, 0, KSCREEN_WIDTH, _imageScroller.frame.size.height)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:profilePic] placeholderImage:[[UIImage alloc]init]];
           //     [imageView setImage:[UIImage imageNamed:profilePic]];
                [imageView setContentMode:UIViewContentModeScaleAspectFit];
                imageView.clipsToBounds = YES;
                [_imageScroller addSubview:imageView];
                [_imageScroller setContentSize:CGSizeMake(CGRectGetMaxX(imageView.frame), 0)];
                profilePicCount++;
                _pageController.numberOfPages = profilePicCount;
                
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
                tapGesture1.numberOfTapsRequired = 1;
                [tapGesture1 setDelegate:self];
                [imageView addGestureRecognizer:tapGesture1];
            }
        }
//    }
}


-(void)viewWillAppear:(BOOL)animated {
    
    self.title = @"Product Detail";
    
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = KAppTheme_COLOR;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],  NSFontAttributeName: ProximaNova_LIGHT(15)}];
    
    [_btnDescription setAdjustsImageWhenHighlighted:NO];
    [_btnTechnicalSpecifications setAdjustsImageWhenHighlighted:NO];
    [_btnDimensions setAdjustsImageWhenHighlighted:NO];
    
    [self addCartView];
}

-(IBAction)btnDescriptionAction:(id)sender {
 
    if (_btnDescription.isSelected) {
        [_btnDescription setSelected:NO];
        subViewPressed = noOneClicked;
    }
    else {
        [_btnDescription setSelected:YES];
        [_btnDescription setHighlighted:FALSE];
        [_btnTechnicalSpecifications setSelected:NO];
        [_btnDimensions setSelected:NO];
        subViewPressed = description;
    }
    [self updateSubViews];
}

-(IBAction)btnTechnicalSpecificationsAction:(id)sender {
    if (_btnTechnicalSpecifications.isSelected) {
        [_btnTechnicalSpecifications setSelected:NO];
        subViewPressed = noOneClicked;
    }
    else {
        [_btnTechnicalSpecifications setSelected:YES];
        [_btnTechnicalSpecifications setHighlighted:FALSE];
        [_btnDescription setSelected:NO];
        [_btnDimensions setSelected:NO];
        subViewPressed = technicalDetails;
    }
    [self updateSubViews];
}

-(IBAction)btnDimensionsAction:(id)sender {
    if (_btnDimensions.isSelected) {
        [_btnDimensions setSelected:NO];
        subViewPressed = noOneClicked;

    }
    else {
        [_btnDimensions setSelected:YES];
        [_btnDimensions setHighlighted:FALSE];
        [_btnDescription setSelected:NO];
        [_btnTechnicalSpecifications setSelected:NO];
        subViewPressed = dimensions;
    }
    [self updateSubViews];
}

-(void)updateSubViews {
    
    int heightTxtDescription = 0;
    int heightTxtTechnicalDetails = 0;
    int heightTxtDimensions = 0;

    switch (subViewPressed) {
        case description:
            heightTxtDescription = [self getLabelHeight:_txtDescription];
            break;
        case technicalDetails:
            heightTxtTechnicalDetails = [self getLabelHeight:_txtTechnicalSpecifications];
            break;
        case dimensions:
            heightTxtDimensions = [self getLabelHeight:_txtDimensions];
            break;
        case noOneClicked:
            heightTxtDescription = 0;
            heightTxtTechnicalDetails = 0;
            heightTxtDimensions = 0;
            break;
    }
    
    [UIView animateWithDuration:0.4
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^ {

    
    [_scrollVW setContentSize:CGSizeMake(_scrollVW.frame.size.width, 455+heightTxtDescription + heightTxtTechnicalDetails+heightTxtDimensions)];
    
    [_btnDescription  setFrame:CGRectMake(_btnDescription.frame.origin.x, _btnDescription.frame.origin.y, _btnDescription.frame.size.width, _btnDescription.frame.size.height)];
    
    [_txtDescription  setFrame:CGRectMake(_txtDescription.frame.origin.x, _txtDescription.frame.origin.y, _txtDescription.frame.size.width, heightTxtDescription)];
    
    [_btnTechnicalSpecifications  setFrame:CGRectMake(_btnTechnicalSpecifications.frame.origin.x,4+ heightTxtDescription +_txtDescription.frame.origin.y, _btnTechnicalSpecifications.frame.size.width,_btnTechnicalSpecifications.frame.size.height)];

    [_txtTechnicalSpecifications  setFrame:CGRectMake(_txtTechnicalSpecifications.frame.origin.x, _btnTechnicalSpecifications.frame.origin.y + _btnTechnicalSpecifications.frame.size.height, _txtTechnicalSpecifications.frame.size.width, heightTxtTechnicalDetails)];

    [_btnDimensions  setFrame:CGRectMake(_btnDimensions.frame.origin.x, 4+ heightTxtTechnicalDetails +_txtTechnicalSpecifications.frame.origin.y, _btnDimensions.frame.size.width,_btnDimensions.frame.size.height)];

    [_txtDimensions  setFrame:CGRectMake(_txtDimensions.frame.origin.x, _btnDimensions.frame.origin.y + _btnDimensions.frame.size.height, _txtDimensions.frame.size.width, heightTxtDimensions)];

    }completion:^(BOOL finished) {
    }];
}

- (int)getLabelHeight:(UITextView*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return (int)size.height+50;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageController.currentPage = scrollView.contentOffset.x/KSCREEN_WIDTH;
}

- (void) tapGesture: (id)sender
{
    ProfileImagesViewerVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileImagesViewerVC"];
      vc.arrImages = arrImages;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView == _sizesCollectionVW) {
        if([[_dictProduct valueForKey:@"variation"] isEqualToString:@""]) {
            return 0;
        }
        
        NSString * price = [_dictProduct valueForKey:@"variation"];
        NSArray * arrDicPrices = [price componentsSeparatedByString:@","];
        return arrDicPrices.count;
    }
    
    return arrColors.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(collectionView == _sizesCollectionVW)     return CGSizeMake(40 ,40);
    
    return CGSizeMake(25 ,25);
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    
    if(collectionView == _sizesCollectionVW)
    cell = (UICollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"sizeCell" forIndexPath:indexPath];
    else
    cell = (UICollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"colorCell" forIndexPath:indexPath];

    
    
    if(collectionView == _sizesCollectionVW) {
        NSString * price = [_dictProduct valueForKey:@"variation"];
        NSArray * arrDicPrices = [price componentsSeparatedByString:@","];

        UILabel * lblSize = (UILabel*) [cell viewWithTag:3];

        [lblSize setText:[[arrDicPrices objectAtIndex:indexPath.row] substringToIndex:1]];
        
        if(selectedSize == indexPath.row)
            lblSize.layer.borderWidth = 3.0f;
        else
            lblSize.layer.borderWidth = 0.0f;
        
        lblSize.layer.borderColor = [UIColor darkGrayColor].CGColor;
        lblSize.layer.masksToBounds = YES;

        return cell;

    }
    
    
    UIView * colorVW = [cell viewWithTag:2];
    [colorVW setBackgroundColor:[self returnColor:[arrColors objectAtIndex:indexPath.row]]];
    colorVW.layer.cornerRadius = 12.5f;
    
    if(selectedColor == indexPath.row)
    colorVW.layer.borderWidth = 3.0f;
    else
    colorVW.layer.borderWidth = 0.0f;
    
    colorVW.layer.borderColor = [UIColor darkGrayColor].CGColor;
    colorVW.layer.masksToBounds = YES;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(collectionView == _sizesCollectionVW) {
        selectedSize = (int)indexPath.row;
        [self.sizesCollectionVW reloadData];
        
        NSString * price = [_dictProduct valueForKey:@"price"];
        NSArray * arrDicPrices = [price componentsSeparatedByString:@","];
        _productPrice.text = [NSString stringWithFormat:@"£%@",[arrDicPrices objectAtIndex:selectedSize]];
        
        return;
    }
    
    selectedColor = (int) indexPath.row;
    [self.collectionVW reloadData];
}

-(UIColor*)returnColor:(NSString*)colorName {
    
    colorName = colorName.lowercaseString;
    
    if([colorName isEqualToString:@"red"])
        return [UIColor redColor];
    if([colorName isEqualToString:@"green"])
        return [UIColor greenColor];
    if([colorName isEqualToString:@"blue"])
        return [UIColor blueColor];
    if([colorName isEqualToString:@"yellow"])
        return [UIColor yellowColor];
    if([colorName isEqualToString:@"black"])
        return [UIColor blackColor];
    if([colorName isEqualToString:@"white"])
        return [UIColor whiteColor];
    if([colorName isEqualToString:@"orange"])
        return [UIColor orangeColor];
    if([colorName isEqualToString:@"pink"])
        return [UIColor colorWithRed:255/255.0f green:192/255.0f blue:203/255.0f alpha:1.0f];
    if([colorName isEqualToString:@"purple"])
        return [UIColor purpleColor];
    if([colorName isEqualToString:@"voilet"])
        return [UIColor colorWithRed:238/255.0f green:130/255.0f blue:238/255.0f alpha:1.0f];
    if([colorName isEqualToString:@"grey"])
        return [UIColor grayColor];

    
    return [UIColor whiteColor];
}

-(void)updateSizeColorDetail {
    
    _lblSizeColors.text = @"";
    
    NSMutableDictionary * dict = [_dictProduct mutableCopy];
    NSMutableDictionary * tempDict = [[ACCartSingeltonManager sharedManager].dictCartProducts objectForKey:[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]]];

    NSMutableArray * arrSelectedColors =[tempDict objectForKey:@"arrSelectedColors"];;
    NSMutableArray * arrSelectedVariations = [tempDict objectForKey:@"arrSelectedVariations"];

    NSMutableArray * arrSizeColorDetail = [NSMutableArray new];
    
    for (int index = 0 ; index < arrSelectedColors.count ; ++ index) {
        if([[arrSelectedVariations objectAtIndex:index] isEqualToString:@""])
          [arrSizeColorDetail addObject:[NSString stringWithFormat:@"%@",[arrSelectedColors objectAtIndex:index]]];
          else
          [arrSizeColorDetail addObject:[NSString stringWithFormat:@"%@_%@",[[arrSelectedVariations objectAtIndex:index] substringToIndex:1],[arrSelectedColors objectAtIndex:index]]];
    }
    
    NSArray *uniqueArray = [[NSSet setWithArray:arrSizeColorDetail] allObjects];

    for (NSString * uniqueCompareStr in uniqueArray) {
    
        int occurrences = 0;
        for(NSString *string in arrSizeColorDetail){
            occurrences += ([string isEqualToString:uniqueCompareStr]?1:0); //certain object is @"Apple"
        }
        
        if([_lblSizeColors.text isEqualToString:@""]) {
            [_lblSizeColors setText:[NSString stringWithFormat:@"%d %@",occurrences,uniqueCompareStr]];
        }
        else {
            [_lblSizeColors setText:[_lblSizeColors.text stringByAppendingString: [NSString stringWithFormat:@", %d %@",occurrences,uniqueCompareStr]]];
        }
    }
}


#pragma mark- Button Actions

-(IBAction)plusButtonClicked:(UIButton*)sender
{
    NSMutableDictionary * dict = [_dictProduct mutableCopy];
    
    if ([[ACCartSingeltonManager sharedManager].dictCartProducts objectForKey:[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]]]) {
        NSMutableDictionary * tempDict = [[ACCartSingeltonManager sharedManager].dictCartProducts objectForKey:[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]]];
        NSMutableArray * arr = [tempDict objectForKey:@"arrayProducts"];
        [arr addObject:dict];
        
        /*** Selected Colors  ****/
        NSMutableArray * arrSelectedColors =[tempDict objectForKey:@"arrSelectedColors"];;
        NSArray * arrDicColors = [dict objectForKey:@"color"];
        
        if([arrDicColors isKindOfClass:[NSArray class]]){
        if(arrDicColors.count > 0){
            [arrSelectedColors addObject:[arrDicColors objectAtIndex:selectedColor]];
        }
        }
        /*** Selected Colors  ****/
        
        /*** Selected Prices  ****/
        NSMutableArray * arrSelectedPRices = [tempDict objectForKey:@"arrSelectedPrices"];
        NSString * price = [dict valueForKey:@"price"];
        NSArray * arrDicPrices = [price componentsSeparatedByString:@","];
        
        if(arrDicPrices.count > 0){
            [arrSelectedPRices addObject:[arrDicPrices objectAtIndex:selectedSize]];
        }
        /*** Selected Prices  ****/
        
        /*** Selected Variations  ****/
        NSMutableArray * arrSelectedVariations = [tempDict objectForKey:@"arrSelectedVariations"];
        NSString * variation = [dict valueForKey:@"variation"];
        NSArray * arrDicVariations = [variation componentsSeparatedByString:@","];
        
        if(arrDicVariations.count > 0){
            [arrSelectedVariations addObject:[arrDicVariations objectAtIndex:selectedSize]];
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
            [arrSelectedColors addObject:[arrDicColors objectAtIndex:selectedColor]];
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
            [arrSelectedPRices addObject:[arrDicPrices objectAtIndex:selectedSize]];
        }
        [tempDict setObject:arrSelectedPRices forKey:@"arrSelectedPrices"];
        /*** Selected Prices  ****/
        
        /*** Selected Variations  ****/
        NSMutableArray * arrSelectedVariations = [[NSMutableArray alloc] init];
        NSString * variation = [dict valueForKey:@"variation"];
        NSArray * arrDicVariations = [variation componentsSeparatedByString:@","];
        
        if(arrDicVariations.count > 0){
            [arrSelectedVariations addObject:[arrDicVariations objectAtIndex:selectedSize]];
        }
        [tempDict setObject:arrSelectedVariations forKey:@"arrSelectedVariations"];
        /*** Selected Variations  ****/
        
        
        [tempDict setObject:arr forKey:@"arrayProducts"];
        [tempDict setObject:dict forKey:@"mainDict"];
        
        
        [[ACCartSingeltonManager sharedManager].dictCartProducts setObject:tempDict forKey:[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]]];
    }
    
    numberBadge.text = [NSString stringWithFormat:@"%lu",(unsigned long)[[ACCartSingeltonManager sharedManager].dictCartProducts allKeys].count];

    [self updateSizeColorDetail];
    
    NSLog(@"%@",[ACCartSingeltonManager sharedManager].dictCartProducts);
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

@end
