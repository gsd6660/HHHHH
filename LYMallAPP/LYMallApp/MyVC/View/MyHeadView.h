//
//  MyHeadView.h
//  LYMallApp
//
//  Created by Mac on 2020/3/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyHeadView : UIView
@property(nonatomic)UIImageView *userImageView;
@property(nonatomic)UIImageView *vipImageView;
@property(nonatomic)UILabel *userNameLabel;//用户名
@property(nonatomic)UILabel *inviteCodeLabel;//邀请码
@property(nonatomic)QMUILinkButton *duplicateButn;//复制按钮
@property(nonatomic)UIButton *setButn;
@property(nonatomic)UIView *butnGgView;

@property(nonatomic)UILabel *balanceLabel;//账户余额
@property(nonatomic)UILabel *balancedesLabel;
@property(nonatomic)UILabel *integralLabel;//可提现佣金
@property(nonatomic)UILabel *integraldesLabel;
@property(nonatomic)UILabel *lineLabel;
@property(nonatomic)QMUIButton *outButn;

@property(nonatomic)UIView *commissionBgView;
@property(nonatomic)UILabel *commissionLabel;
@property(nonatomic)QMUIButton *commissionManagerButn;//佣金button
@property(nonatomic)UILabel *lineLabel1;
@property(nonatomic)UILabel *lineLabel2;

@property(nonatomic)UILabel *cumulativeCommissionLabel;//奖金
@property(nonatomic)UILabel *cumulativeCommissionDesLabel;
@property(nonatomic)UILabel *withdrawalCommissionLabel;//收益
@property(nonatomic)UILabel *withdrawalCommissionDesLabel;
@property(nonatomic)QMUIGhostButton *withdrawalButn;



@end

NS_ASSUME_NONNULL_END
