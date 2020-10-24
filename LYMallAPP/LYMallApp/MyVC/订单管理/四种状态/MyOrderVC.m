
//
//  MyOrderVC.m
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "MyOrderVC.h"
#import "MyOrderOneVC.h"
#import "MyOrderTwoVC.h"
#import "MyOrderThreeVC.h"
#import "MyOrderFourVC.h"
#import "WaitingEvaluationVC.h"
#import "MyOrderRefundVC.h"
@interface MyOrderVC ()<ZJScrollPageViewDelegate>
@property(nonatomic,strong)ZJScrollPageView *scrollPageView;

@end

@implementation MyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单管理";
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
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:scrollPageViewFrame segmentStyle:style titles:@[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"] parentViewController:self delegate:self];
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
    return 5;// 传入页面的总数, 推荐使用titles.count
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    
    if (index == 0) {
        // 注意这个效果和tableView的deque...方法一样, 会返回一个可重用的childVc
        // 请首先判断返回给你的是否是可重用的
        // 如果为nil就重新创建并返回
        // 如果不为nil 直接使用返回给你的reuseViewController并进行需要的设置 然后返回即可
        MyOrderFourVC *childVc = (MyOrderFourVC *)reuseViewController;
        if (childVc == nil) {
            childVc = [[MyOrderFourVC alloc] init];
            childVc.is_SegmentViewH = YES;
        }
        return childVc;
    }
    
    else if (index == 1) {
        MyOrderOneVC *childVc = (MyOrderOneVC *)reuseViewController;
        if (childVc == nil) {
            childVc = [[MyOrderOneVC alloc] init];
            childVc.is_SegmentViewH = YES;
        }
        
        return childVc;
    }
    else if (index == 2){
        MyOrderTwoVC *childVc = (MyOrderTwoVC *)reuseViewController;
        if (childVc == nil) {
            childVc = [[MyOrderTwoVC alloc] init];
            childVc.is_SegmentViewH = YES;
        }
        
        return childVc;
    }else if (index == 3){
        MyOrderThreeVC *childVc = (MyOrderThreeVC *)reuseViewController;
        if (childVc == nil) {
            childVc = [[MyOrderThreeVC alloc] init];
            childVc.is_SegmentViewH = YES;
        }
        
        return childVc;
    } else {
        
        WaitingEvaluationVC *childVc = (WaitingEvaluationVC *)reuseViewController;
        if (childVc == nil) {
            childVc = [[WaitingEvaluationVC alloc] init];
            childVc.is_SegmentViewH = YES;
        }
        
        return childVc;
    }
}


@end
