//
//  LXMeHeaderView.m
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXMeHeaderView.h"
#import "BonusManagementVC.h"
#import "MyOrderVC.h"
#import "InviteFriendsVC.h"
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
}

- (IBAction)oneClick:(id)sender {
    BonusManagementVC * vc = [[BonusManagementVC alloc]init];
    vc.title = @"收益管理";
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
@end
