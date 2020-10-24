//
//  ZQChatImgCell.m
//  TSYCAPP
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "ZQChatImgCell.h"

#define ICON_WH 40
@interface ZQChatImgCell()<PYPhotoBrowseViewDelegate,PYPhotoBrowseViewDataSource>{
    UIControl * control;
}
@property (nonatomic, strong) UIImageView *descImg;
@end
@implementation ZQChatImgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        UIView *backView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView = backView;
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews {
    
    //头像
    self.iconIV = [[UIImageView alloc] init];
    self.iconIV.frame = CGRectMake(0, 0, ICON_WH, ICON_WH);
    self.iconIV.contentMode = UIViewContentModeScaleAspectFit;
    self.iconIV.image = [UIImage imageNamed:@"default_icon"];
    [self.contentView addSubview:self.iconIV];
    
    self.descImg = [[UIImageView alloc] init];
    self.descImg.frame = CGRectMake(ICON_WH + 10, 10, ICON_WH, ICON_WH);
    self.descImg.contentMode = UIViewContentModeScaleAspectFit;
    self.descImg.image = [UIImage imageNamed:@"default_icon"];
    [self.contentView addSubview:self.descImg];
    self.descImg.userInteractionEnabled = YES;
    control = [[UIControl alloc]initWithFrame:self.descImg.bounds];
    [self.descImg addSubview:control];
    MJWeakSelf;
    [control addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if ([CheackNullOjb cc_isNullOrNilWithObject:self.descImg.image] == NO) {
            [weakSelf showImgeView];

        }
    }];
}

- (void)showImgeView{
    PYPhotoBrowseView *browseView = [[PYPhotoBrowseView alloc] init];
    browseView.images = @[self.descImg.image];
    // 2.设置数据源和代理并实现数据源和代理方法
    browseView.dataSource = self;
    browseView.delegate = self;
    [browseView show];
}
#pragma mark - PYPhotoBrowseViewDataSource
// 返回将要浏览的图片(UIImage)数组
- (NSArray *)imagesForBrowse
{
 
    return @[self.descImg.image];
}

// 返回默认显示图片的下标(默认为0)
//- (NSInteger)currentIndex
//{
//    return 0;
//}
//
// 返回从窗口的哪个位置开始显示（注意：frame是相当于window）
//- (CGRect)frameFormWindow
//{
//    return CGRectMake(self.descImg.frame.origin.x, self.descImg.frame.origin.y, 0, 0);
//}

//// 返回消失到窗口的哪个位置（注意：frame是相当于window）
- (CGRect)frameToWindow
{
    return CGRectMake(self.descImg.frame.origin.x, self.descImg.frame.origin.y, 0, 0);
}

// 实现代理方法
#pragma mark PYPhotoBrowseViewDelegate
- (void)photoBrowseView:(PYPhotoBrowseView *)photoBrowseView didSingleClickedImage:(UIImage *)image index:(NSInteger)index
{
    NSLog(@"图片单击时调用");
    // 关闭浏览
    [photoBrowseView hidden];
}

- (void)setModel:(SendModel *)model {
    //头像位置
    CGFloat iconX = model.from_side == 1 ? 15 : (SCREEN_WIDTH - ICON_WH - 15);
    self.iconIV.frame = CGRectMake(iconX, 15, ICON_WH, ICON_WH);
    //    self.iconIV.image = [UIImage imageNamed: model.from_side  == 1 ? @"default_icon" : @"teacher_image"];
    CGFloat descX = model.from_side == 1 ? 20 + ICON_WH : (SCREEN_WIDTH - ICON_WH - 120);
    self.descImg.frame = CGRectMake(descX, 15, 100, 100);
    self.descImg.yy_imageURL = [NSURL URLWithString:model.content];
    control.frame = self.descImg.bounds;
}

- (void)setModel1:(SendModel *)model1{
    CGFloat iconX = model1.from_side == 2 ? 15 : (SCREEN_WIDTH - ICON_WH - 15);
    self.iconIV.frame = CGRectMake(iconX, 15, ICON_WH, ICON_WH);
    //    self.iconIV.image = [UIImage imageNamed: model.from_side  == 1 ? @"default_icon" : @"teacher_image"];
    CGFloat descX = model1.from_side == 2 ? 20 + ICON_WH : (SCREEN_WIDTH - ICON_WH - 120);
    self.descImg.frame = CGRectMake(descX, 15, 100, 100);
    self.descImg.yy_imageURL = [NSURL URLWithString:model1.content];
    control.frame = self.descImg.bounds;
}

@end
