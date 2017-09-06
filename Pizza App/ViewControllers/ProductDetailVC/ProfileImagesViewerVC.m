//
//  ProfileImagesViewerVC.m
//  Kafaah
//
//  Created by Adeel Ishaq on 1/3/17.
//  Copyright © 2017 Muhammad Ahsan. All rights reserved.
//

#import "ProfileImagesViewerVC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ProfileImagesViewerVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *imageScroller;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (nonatomic,retain) NSMutableArray* imageArray;

@end

@implementation ProfileImagesViewerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if([_prevMatch.profileImages isKindOfClass:[NSArray class]]){
        int profilePicCount = 0;
        
        for(NSString * profilePic in _arrImages){
            
            
            if([profilePic isKindOfClass:[NSString class]]){
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(profilePicCount*KSCREEN_WIDTH, 0, KSCREEN_WIDTH, _imageScroller.frame.size.height)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:profilePic] placeholderImage:[[UIImage alloc]init]];
//                [imageView setImage:[UIImage imageNamed:profilePic]];
                [imageView setContentMode:UIViewContentModeScaleAspectFit];
                [_imageScroller addSubview:imageView];
                [_imageScroller setContentSize:CGSizeMake(CGRectGetMaxX(imageView.frame), 0)];
                profilePicCount++;
                _pageController.numberOfPages = profilePicCount;
                
            }
        }
 //   }

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageController.currentPage = scrollView.contentOffset.x/KSCREEN_WIDTH;
}

-(IBAction)btnDoneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
