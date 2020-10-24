//
//  ViewController.m
//  LYMallApp
//
//  Created by Mac on 2020/3/5.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<SDCycleScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSDCycleView];
    
}


-(void)creatSDCycleView{
    
    // 网络加载图片的轮播器
    SDCycleScrollView *cycleScrollView =
    [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 162.5) delegate:self placeholderImage:CCImage(@"jft_img_palmyitongcommodityoccupancymap")];
    cycleScrollView.imageURLStringsGroup = @[@"https://image.suning.cn/uimg/aps/material/158347480488169766.jpg",@"https://oss.suning.com/aps/aps_learning/iwogh/2020/03/06/18/iwoghBannerPicture/da989233469b4bd4810dea9df6d77676.png",@"https://oss.suning.com/aps/aps_learning/iwogh/2020/02/25/11/iwoghBannerPicture/f5156d70c35940bc8c0be6562c8025da.png"];
        cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        cycleScrollView.delegate = self;
    [self.view addSubview:cycleScrollView];
}





@end
