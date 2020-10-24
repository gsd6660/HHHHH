//
//  MySubscriptiveVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MySubscriptiveVC.h"
#import "MySubscriptiveOneVC.h"
#import "MySubscriptiveTwoVC.h"
#import "MySubscriptiveHeadView.h"
@interface MySubscriptiveVC ()<ZJScrollPageViewDelegate>
@property(nonatomic,strong)ZJScrollPageView *scrollPageView;
@property(nonatomic,strong)MySubscriptiveHeadView *headView;

@end

@implementation MySubscriptiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订阅";
    self.view.backgroundColor = kUIColorFromRGB(0xF5F5F5);
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self setUI];
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
    CGRect scrollPageViewFrame = CGRectMake(0, 200, self.view.bounds.size.width, ScreenHeight - SafeAreaTopHeight);
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:scrollPageViewFrame segmentStyle:style titles:@[@"待发货",@"待收货",@"已完成"] parentViewController:self delegate:self];
    self.scrollPageView = scrollPageView;
    // 额外的按钮响应的block
    __weak typeof(self) weakSelf = self;
    
    
    self.scrollPageView.extraBtnOnClick = ^(UIButton *extraBtn){
        weakSelf.title = @"点击了extraBtn";
        NSLog(@"点击了extraBtn");
        
    };
    [self.view addSubview:self.scrollPageView];
}


-(void)setUI{
    self.headView = [[MySubscriptiveHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 203)];
    [self.view addSubview:self.headView];
}


- (NSInteger)numberOfChildViewControllers {
    return 3;// 传入页面的总数, 推荐使用titles.count
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    
    if (index == 0) {
        // 注意这个效果和tableView的deque...方法一样, 会返回一个可重用的childVc
        // 请首先判断返回给你的是否是可重用的
        // 如果为nil就重新创建并返回
        // 如果不为nil 直接使用返回给你的reuseViewController并进行需要的设置 然后返回即可
        MySubscriptiveOneVC *childVc = (MySubscriptiveOneVC *)reuseViewController;
        if (childVc == nil) {
            childVc = [[MySubscriptiveOneVC alloc] init];
            childVc.dataType = @"1";
        }
        MJWeakSelf;
        childVc.block = ^(NSDictionary * _Nonnull dic, UITableView * _Nonnull tableView) {
            [weakSelf.headView getDataDic:dic];
            [tableView reloadData];

        };
        return childVc;
    }
    else  if (index == 1) {
           // 注意这个效果和tableView的deque...方法一样, 会返回一个可重用的childVc
           // 请首先判断返回给你的是否是可重用的
           // 如果为nil就重新创建并返回
           // 如果不为nil 直接使用返回给你的reuseViewController并进行需要的设置 然后返回即可
           MySubscriptiveTwoVC *childVc = (MySubscriptiveTwoVC *)reuseViewController;
           if (childVc == nil) {
               childVc = [[MySubscriptiveTwoVC alloc] init];
//               childVc.dataType = @"2";

           }
       
        
           return childVc;
       }
   else {
        
        MySubscriptiveOneVC *childVc = (MySubscriptiveOneVC *)reuseViewController;
        if (childVc == nil) {
            childVc = [[MySubscriptiveOneVC alloc] init];
            childVc.dataType = @"3";

        }
        
        return childVc;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
@end

