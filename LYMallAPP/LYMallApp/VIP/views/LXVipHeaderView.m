//
//  LXVipHeaderView.m
//  LYMallApp
//
//  Created by guxiang on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXVipHeaderView.h"

@implementation LXVipHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.top.constant = -StatusBarHeight;

//    self.imgV.mj_y = -StatusBarHeight;
    
    
    self.headerView.contentMode= UIViewContentModeScaleToFill;
    YBDViewBorderRadius(self.headerView, 5);
    
    self.height.constant += StatusBarHeight;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    self.progressView.transform = transform;
    self.progressView.progressTintColor = UIColorHex(0xd7ecfe);
    self.progressView.trackTintColor = UIColorHex(0x3ba3fc);
    YBDViewBorderRadius(self.progressView, self.progressView.height/2);
    [self.progressView setProgress:0.3 animated:YES];
    
    YBDViewBorderRadius(self.scyScrollView, 10);
    self.scyScrollView.backgroundColor = UIColor.whiteColor;
//    self.scyScrollView.imageURLStringsGroup = @[@"",@"",@""];
    self.scyScrollView.localizationImageNamesGroup = @[@"home_scroll",@"home_scroll",@"home_scroll"];
    self.scyScrollView.pageDotColor = UIColor.whiteColor;
    self.scyScrollView.currentPageDotColor = UIColor.blueColor;
    self.scyScrollView.pageControlBottomOffset = 20;
    self.scyScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.scyScrollView.pageControlDotSize = CGSizeMake(25, 6);
    
}

@end
