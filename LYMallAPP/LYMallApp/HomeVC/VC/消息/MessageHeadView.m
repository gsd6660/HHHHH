

//
//  MessageHeadView.m
//  LYMallApp
//
//  Created by Mac on 2020/3/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MessageHeadView.h"
#import "NewPagedFlowView.h"


@interface MessageHeadView ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

/**
 *  指示label
 */
@property (nonatomic, strong) UILabel *indicateLabel;
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;

@end


@implementation MessageHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
//    for (int index = 0; index < 5; index++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite%02d",index]];
//        [self.imageArray addObject:image];
//    }
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 11, ScreenWidth, 155)];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.1;
    pageFlowView.isCarousel = YES;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = YES;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 32, ScreenWidth, 8)];
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];
    
    [self addSubview:pageFlowView];
    self.pageFlowView = pageFlowView;
    //添加到主view上
    [self addSubview:self.indicateLabel];

}

-(void)setArray:(NSArray *)array{
    _array = array;
    
    for (NSDictionary *dic in array) {
        [self.imageArray addObject:dic[@"image"][@"file_path"]];
    }
    [self.pageFlowView reloadData];

    
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(ScreenWidth - 60, 145);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
//    self.indicateLabel.text = [NSString stringWithFormat:@"点击了第%ld张图",(long)subIndex + 1];
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    NSDictionary *dic = self.array[pageNumber];

    self.indicateLabel.text = [NSString stringWithFormat:@"%@",dic[@"name"]];

    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
    
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    NSDictionary *dic = self.array[index];
    
    //在这里下载网络图片
      [bannerView.mainImageView yy_setImageWithURL:[NSURL URLWithString:dic[@"image"][@"file_path"]] placeholder:CCImage(@"")];
//    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;
}


#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UILabel *)indicateLabel {
    
    if (_indicateLabel == nil) {
        _indicateLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 175, ScreenWidth - 54, 16)];
        _indicateLabel.textColor = kUIColorFromRGB(0x333333);
        _indicateLabel.font = [UIFont systemFontOfSize:14.0];
        _indicateLabel.textAlignment = NSTextAlignmentCenter;
        _indicateLabel.text = @"隆源农业董事长任成顺受邀参加行动者联盟公益盛典";
    }
    
    return _indicateLabel;
}
@end
