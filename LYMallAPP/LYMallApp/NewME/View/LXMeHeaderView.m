//
//  LXMeHeaderView.m
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXMeHeaderView.h"
#import "XinWithdrawVC.h"
#import "MyOrderVC.h"
#import "InviteFriendsVC.h"
#import "MyDetailMessageVC.h"
#import "LXIncomeListVC.h"
@implementation LXMeHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.oneBtn.imagePosition = QMUIButtonImagePositionTop;
    self.oneBtn.spacingBetweenImageAndTitle = 5;
    
    self.twoBtn.imagePosition = QMUIButtonImagePositionTop;
    self.twoBtn.spacingBetweenImageAndTitle = 5;
    
    self.threeBtn.imagePosition = QMUIButtonImagePositionTop;
    self.threeBtn.spacingBetweenImageAndTitle = 5;
    
    self.fourBtn.imagePosition = QMUIButtonImagePositionTop;
    self.fourBtn.spacingBetweenImageAndTitle = 5;
    YBDViewBorderRadius(self.bgView, 10);
    YBDViewBorderRadius(self.vipBtn, 12.5);
    YBDViewBorderRadius(self.imgV, 30);
}

- (IBAction)oneClick:(id)sender {
    XinWithdrawVC * vc = [[XinWithdrawVC alloc]init];
    vc.title = @"提现";
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (IBAction)twolick:(id)sender {
    MyOrderVC * vc = [MyOrderVC new];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (IBAction)click:(id)sender {//不要了
    
}

- (IBAction)fourClick:(id)sender {
    
    InviteFriendsVC * vc = [InviteFriendsVC new];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)settingClick:(id)sender {
    
    MyDetailMessageVC * vc = [MyDetailMessageVC new];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}


- (IBAction)leftClick:(id)sender {
    LXIncomeListVC * vc = [[LXIncomeListVC alloc]init];
    vc.type = LXSilver;
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}



- (IBAction)rightClick:(id)sender {
    LXIncomeListVC * vc = [[LXIncomeListVC alloc]init];
    vc.type = LXGold;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}


@end
