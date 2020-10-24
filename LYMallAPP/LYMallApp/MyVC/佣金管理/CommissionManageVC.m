//
//  CommissionManageVC.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/1.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CommissionManageVC.h"
#import "CommissionOne.h"
#import "CommissionTwo.h"
#import "WithdrawDepositVC.h"
@interface CommissionManageVC ()<ZJScrollPageViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *sumCommissionLabel;

@property (weak, nonatomic) IBOutlet UIButton *withdrawBtn;

@property (weak, nonatomic) IBOutlet UILabel *waitCommissionLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumWithdrawLabel;
@property (weak, nonatomic) IBOutlet UILabel *withdrawLabel;

@property(nonatomic,strong)ZJScrollPageView *scrollPageView;

@end

@implementation CommissionManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"佣金管理";
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    style.backGroundColor = [UIColor whiteColor];
    style.scrollLineColor = kUIColorFromRGB(0x3ACD7B);
    style.selectedTitleColor = kUIColorFromRGB(0x3ACD7B);
    style.normalTitleColor = kUIColorFromRGB(0xCDCDCD);
    style.autoAdjustTitlesWidth = NO;
    style.titleFont = FONTSIZE(15);
    style.titleMargin = 40;
    style.scrollLineHeight = 1;
    //    style.titleBigScale = 1.5;
    [self.withdrawBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        WithdrawDepositVC * vc = [WithdrawDepositVC new];
        vc.urlStr = @"api/user.dealer.withdraw/submit_info";
        vc.submitUrlStr = @"api/user.dealer.withdraw/submit";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    // 初始化
    CGRect scrollPageViewFrame = CGRectMake(10, 154+SafeAreaTopHeight, ScreenWidth - 20, ScreenHeight - SafeAreaTopHeight - 194);
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:scrollPageViewFrame segmentStyle:style titles:@[@"收入",@"提现记录"] parentViewController:self delegate:self];
    self.scrollPageView = scrollPageView;
    // 额外的按钮响应的block
    __weak typeof(self) weakSelf = self;
    self.scrollPageView.extraBtnOnClick = ^(UIButton *extraBtn){
        weakSelf.title = @"点击了extraBtn";
        NSLog(@"点击了extraBtn");
        
    };
    [self.view addSubview:self.scrollPageView];
//    [self loadData];
}

- (void)loadData{
    MJWeakSelf;
    [NetWorkConnection postURL:@"api/user.dealer.order/brokerage" param:@{@"type":@"1"} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            NSLog(@"%@",responseObject);
            NSDictionary * dic = responseObject[@"data"][@"user"];
            weakSelf.sumCommissionLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"grand_broker"]];
            weakSelf.waitCommissionLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"enter_account"]];
            weakSelf.sumWithdrawLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"total_money"]];
            weakSelf.withdrawLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"money"]];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        ShowErrorHUD(@"请求失败");
    }];
}


- (NSInteger)numberOfChildViewControllers {
    return 2;// 传入页面的总数, 推荐使用titles.count
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    
    if (index == 0) {
        // 注意这个效果和tableView的deque...方法一样, 会返回一个可重用的childVc
        // 请首先判断返回给你的是否是可重用的
        // 如果为nil就重新创建并返回
        // 如果不为nil 直接使用返回给你的reuseViewController并进行需要的设置 然后返回即可
        CommissionOne *childVc = (CommissionOne *)reuseViewController;
        if (childVc == nil) {
            childVc = [[CommissionOne alloc] init];
        }
        MJWeakSelf;
        childVc.block = ^(NSDictionary * _Nonnull dic) {
           weakSelf.sumCommissionLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"grand_broker"]];
            weakSelf.waitCommissionLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"enter_account"]];
            weakSelf.sumWithdrawLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"total_money"]];
            weakSelf.withdrawLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"money"]];

        };
        return childVc;
    }
    
    else {
        
        CommissionTwo *childVc = (CommissionTwo *)reuseViewController;
        if (childVc == nil) {
            childVc = [[CommissionTwo alloc] init];
        }
        
        return childVc;
    }
}


@end
