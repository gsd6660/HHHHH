//
//  CouponVC.m
//  LYMallApp
//
//  Created by CC on 2020/3/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CouponVC.h"
#import "CouponOneVC.h"

@interface CouponVC ()<ZJScrollPageViewDelegate>
@property(nonatomic,strong)ZJScrollPageView *scrollPageView;


@end

@implementation CouponVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠券";
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    style.backGroundColor = [UIColor whiteColor];
    style.scrollLineColor = kUIColorFromRGB(0x3ACD7B);
    style.selectedTitleColor = kUIColorFromRGB(0x3ACD7B);
    style.normalTitleColor = kUIColorFromRGB(0x7B8391);
    style.autoAdjustTitlesWidth = YES;
    // 初始化
    CGRect scrollPageViewFrame = CGRectMake(0, 0, self.view.bounds.size.width, ScreenHeight - SafeAreaTopHeight);
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:scrollPageViewFrame segmentStyle:style titles:@[@"未使用",@"已使用",@"已过期"] parentViewController:self delegate:self];
    self.scrollPageView = scrollPageView;
    // 额外的按钮响应的block
    __weak typeof(self) weakSelf = self;
    
    self.scrollPageView.extraBtnOnClick = ^(UIButton *extraBtn){
        weakSelf.title = @"点击了extraBtn";
        NSLog(@"点击了extraBtn");
    };
    [self.view addSubview:self.scrollPageView];
}

- (NSInteger)numberOfChildViewControllers {
    return 3;// 传入页面的总数, 推荐使用titles.count
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    
    if (index == 0) {
        //all(可以使用未过期)not_use(未使用)is_use(已使用)is_expire(已过期)
        CouponOneVC *childVc = (CouponOneVC *)reuseViewController;
        if (childVc == nil) {
            childVc = [[CouponOneVC alloc] init];
        }
        childVc.data_type = @"not_use";
        return childVc;
    }
    
    else if (index == 1) {
        CouponOneVC *childVc = (CouponOneVC *)reuseViewController;
        if (childVc == nil) {
            childVc = [[CouponOneVC alloc] init];
        }
        childVc.data_type = @"is_use";

        return childVc;
    }
     else {
        
        CouponOneVC *childVc = (CouponOneVC *)reuseViewController;
        if (childVc == nil) {
            childVc = [[CouponOneVC alloc] init];
        }
        childVc.data_type = @"is_expire";

        return childVc;
    }
}
@end
