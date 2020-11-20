

//
//  MyHeadView.m
//  LYMallApp
//
//  Created by Mac on 2020/3/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MyHeadView.h"
#import "CommissionManageVC.h"
#import "WithdrawDepositVC.h"
#import "MyDetailMessageVC.h"
#import "MyPurseVC.h"
#import "XinWithdrawVC.h"
#import "XinWithDrawRecordVC.h"
@implementation MyHeadView

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
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.userImageView = [[UIImageView alloc]init];
    self.userImageView.image = CCImage(@"xiaomi");
    self.userImageView.userInteractionEnabled = YES;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.layer.cornerRadius = 71 / 2;
    
    [self addSubview:self.userImageView];
    
    self.userNameLabel = [[UILabel alloc]init];
    self.userNameLabel.text = @"和乐宝APP";
    self.userNameLabel.textColor = kUIColorFromRGB(0x666666);
    self.userNameLabel.font = [UIFont systemFontOfSize:18 weight:30];
    [self addSubview:self.userNameLabel];

    self.inviteCodeLabel = [[UILabel alloc]init];
    self.inviteCodeLabel.backgroundColor = [UIColor clearColor];
    self.inviteCodeLabel.text = @"邀请码：******";
    self.inviteCodeLabel.textColor = kUIColorFromRGB(0x333333);
    self.inviteCodeLabel.font = FONTSIZE(12);
    [self addSubview:self.inviteCodeLabel];
    
    self.vipImageView = [[UIImageView alloc]init];
    self.vipImageView.image = CCImage(@"jft_icon_V1");
    [self addSubview:self.vipImageView];
    
    self.duplicateButn = [[QMUILinkButton alloc]init];
    [self.duplicateButn setTitle:@"复制" forState:UIControlStateNormal];
    self.duplicateButn.titleLabel.font = FONTSIZE(12);

    [self addSubview:self.duplicateButn];

    self.setButn = [[UIButton alloc]init];
    [self.setButn setImage:CCImage(@"jft_but_setup") forState:UIControlStateNormal];
    [self.setButn addTarget:self action:@selector(setButnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.setButn];
    
    self.butnGgView = [[UIView alloc]init];
    self.butnGgView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.butnGgView];
    
    self.balanceLabel = [[UILabel alloc]init];
    self.balanceLabel.textAlignment = NSTextAlignmentCenter;
    self.balanceLabel.text = @"0.0";
    self.balanceLabel.textColor = kUIColorFromRGB(0x333333);
    self.balanceLabel.font = FONTSIZE(14);
    [self.butnGgView addSubview:self.balanceLabel];
    
    self.balancedesLabel = [[UILabel alloc]init];
    self.balancedesLabel.textAlignment = NSTextAlignmentCenter;
    self.balancedesLabel.text = @"账户余额";
    self.balancedesLabel.textColor = kUIColorFromRGB(0x333333);
    self.balancedesLabel.font = [UIFont systemFontOfSize:14];
    [self.butnGgView addSubview:self.balancedesLabel];
    
    self.integralLabel = [[UILabel alloc]init];
    self.integralLabel.textAlignment = NSTextAlignmentCenter;
    self.integralLabel.text = @"0.00";
    self.integralLabel.textColor = kUIColorFromRGB(0x333333);
    self.integralLabel.font = [UIFont systemFontOfSize:14];
    [self.butnGgView addSubview:self.integralLabel];
    
    self.integraldesLabel = [[UILabel alloc]init];
    self.integraldesLabel.textAlignment = NSTextAlignmentCenter;
    self.integraldesLabel.text = @"账户积分";
    self.integraldesLabel.textColor = kUIColorFromRGB(0x333333);
    self.integraldesLabel.font = [UIFont systemFontOfSize:14];
    [self.butnGgView addSubview:self.integraldesLabel];
    
    self.lineLabel = [[UILabel alloc]init];
    self.lineLabel.backgroundColor = kUIColorFromRGB(0xE6E6E6);
    [self.butnGgView addSubview:self.lineLabel];
    
    self.outButn = [[QMUIButton alloc]init];
    [self.outButn setTitle:@"我的钱包" forState:UIControlStateNormal];
    [self.outButn setImage:CCImage(@"jft_but_mywallet") forState:UIControlStateNormal];
    self.outButn.imagePosition = QMUIButtonImagePositionTop;
    self.outButn.spacingBetweenImageAndTitle = 8;
   
    self.outButn.titleLabel.font = FONTSIZE(14);
    [self.outButn setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [self.butnGgView addSubview:self.outButn];
    
    self.commissionBgView = [[UIView alloc]init];
    self.commissionBgView.backgroundColor = [UIColor whiteColor];
    self.commissionBgView.layer.shadowColor = [UIColor colorWithRed:94/255.0 green:90/255.0 blue:90/255.0 alpha:0.16].CGColor;
    self.commissionBgView.layer.shadowOffset = CGSizeMake(0,0);
    self.commissionBgView.layer.shadowOpacity = 0.5;
    self.commissionBgView.layer.shadowRadius = 3;
    self.commissionBgView.layer.cornerRadius = 5;
    [self addSubview:self.commissionBgView];
    
    self.commissionLabel = [[UILabel alloc]init];
    self.commissionLabel.textColor = kUIColorFromRGB(0x333333);
    self.commissionLabel.text = @"可提现收入";
    self.commissionLabel.font = FONTSIZE(14);
    [self.commissionBgView addSubview:self.commissionLabel];
    
    self.commissionManagerButn = [[QMUIButton alloc]init];
    [self.commissionManagerButn setTitle:@"提现记录" forState:UIControlStateNormal];
    [self.commissionManagerButn setImage:CCImage(@"jft_but_rightarrow") forState:UIControlStateNormal];
    self.commissionManagerButn.imagePosition = QMUIButtonImagePositionRight;
    self.commissionManagerButn.spacingBetweenImageAndTitle = 3;
    self.commissionManagerButn.titleLabel.font = FONTSIZE(12);
    [self.commissionManagerButn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [self.commissionBgView addSubview:self.commissionManagerButn];
    
    self.lineLabel1 = [[UILabel alloc]init];
    self.lineLabel1.backgroundColor = kUIColorFromRGB(0xF5F5F5);
    [self.commissionBgView addSubview:self.lineLabel1];
    
    
    
    self.cumulativeCommissionLabel = [[UILabel alloc]init];
    self.cumulativeCommissionLabel.textAlignment = NSTextAlignmentCenter;
    self.cumulativeCommissionLabel.text = @"0.00";
    self.cumulativeCommissionLabel.textColor = kUIColorFromRGB(0x333333);
    self.cumulativeCommissionLabel.font = FONTSIZE(14);
    [self.commissionBgView addSubview:self.cumulativeCommissionLabel];
    
    self.cumulativeCommissionDesLabel = [[UILabel alloc]init];
    self.cumulativeCommissionDesLabel.textAlignment = NSTextAlignmentCenter;
    self.cumulativeCommissionDesLabel.text = @"奖金";
    self.cumulativeCommissionDesLabel.textColor = kUIColorFromRGB(0x333333);
    self.cumulativeCommissionDesLabel.font = [UIFont systemFontOfSize:14];
    [self.commissionBgView addSubview:self.cumulativeCommissionDesLabel];
    
    self.withdrawalCommissionLabel = [[UILabel alloc]init];
    self.withdrawalCommissionLabel.textAlignment = NSTextAlignmentCenter;
    self.withdrawalCommissionLabel.text = @"0.00";
    self.withdrawalCommissionLabel.textColor = kUIColorFromRGB(0x333333);
    self.withdrawalCommissionLabel.font = [UIFont systemFontOfSize:14];
    [self.commissionBgView addSubview:self.withdrawalCommissionLabel];
    
    self.withdrawalCommissionDesLabel = [[UILabel alloc]init];
    self.withdrawalCommissionDesLabel.textAlignment = NSTextAlignmentCenter;
    self.withdrawalCommissionDesLabel.text = @"收益";
    self.withdrawalCommissionDesLabel.textColor = kUIColorFromRGB(0x333333);
    self.withdrawalCommissionDesLabel.font = [UIFont systemFontOfSize:14];
    [self.commissionBgView addSubview:self.withdrawalCommissionDesLabel];
    
    self.lineLabel2 = [[UILabel alloc]init];
    self.lineLabel2.backgroundColor = kUIColorFromRGB(0xE6E6E6);
    [self.commissionBgView addSubview:self.lineLabel2];
    
    self.withdrawalButn = [[QMUIGhostButton alloc]init];
    [self.withdrawalButn setTitle:@"提现" forState:UIControlStateNormal];
    self.withdrawalButn.layer.borderWidth = 1.5;
    self.withdrawalButn.layer.borderColor = kUIColorFromRGB(0x3ACD7B).CGColor;
    self.withdrawalButn.layer.cornerRadius = 12.5;
    self.withdrawalButn.titleLabel.font = FONTSIZE(14);
    [self.withdrawalButn setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [self.commissionBgView addSubview:self.withdrawalButn];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12.5);
        make.top.mas_equalTo(30.5);
        make.width.height.mas_equalTo(71);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(14);
        make.top.mas_equalTo(44);
    }];
  
    [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel.mas_right).offset(9.5);
        make.top.mas_equalTo(44);
        make.height.width.mas_equalTo(18);
    }];
    
    [self.inviteCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.userImageView.mas_right).offset(14);
           make.top.equalTo(self.userNameLabel.mas_bottom).offset(15);
    }];
    
    
    [self.duplicateButn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.inviteCodeLabel.mas_right).offset(14);
        make.height.mas_equalTo(12); make.top.equalTo(self.userNameLabel.mas_bottom).offset(15);
       }];
    

    [self.setButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(57);
        make.height.width.mas_equalTo(18);
    }];
    
    [self.butnGgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12.5);
        make.left.mas_equalTo(12.5);
        make.top.equalTo(self.userImageView.mas_bottom).offset(9);
        make.height.mas_equalTo(74);
    }];
    
    
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo((ScreenWidth - 60) / 3);
        make.top.equalTo(self.userImageView.mas_bottom).offset(20);
    }];
    
    [self.balancedesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo((ScreenWidth - 60) / 3);
        make.top.equalTo(self.balanceLabel.mas_bottom).offset(11.5);
    }];
    
    
    [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.balanceLabel.mas_width);
        make.top.equalTo(self.userImageView.mas_bottom).offset(20);
    }];
    
    [self.integraldesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.balanceLabel.mas_width);
        make.top.equalTo(self.balanceLabel.mas_bottom).offset(11.5);
    }];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.integraldesLabel.mas_right).offset(10);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(31);
        make.top.mas_equalTo(21.5);
    }];
    
    [self.outButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-22);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(69);
        make.top.equalTo(self.userImageView.mas_bottom).offset(20);

       }];
    
    [self.commissionBgView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.right.mas_equalTo(-12.5);
     make.left.mas_equalTo(12.5);
     make.height.mas_equalTo(115.5);
     make.top.equalTo(self.butnGgView.mas_bottom).offset(10);
    }];

    [self.commissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.left.mas_equalTo(10.5);
        make.top.mas_equalTo(17);
        make.height.mas_equalTo(13.5);

    }];
    [self.commissionManagerButn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.width.mas_equalTo(74);
           make.right.mas_equalTo(-12.5);
           make.top.mas_equalTo(17);
        make.height.mas_equalTo(12);
       }];
    
    [self.lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.left.mas_equalTo(5);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(41);
    }];
    
    [self.cumulativeCommissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo((ScreenWidth -60) / 3);
        make.left.mas_equalTo(10);
        make.top.equalTo(self.lineLabel1.mas_bottom).offset(18);
    }];
    
    [self.cumulativeCommissionDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(self.cumulativeCommissionLabel.mas_bottom).offset(11.5);
        make.width.mas_equalTo((ScreenWidth - 60) / 3);
    }];
    
    [self.withdrawalCommissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo((ScreenWidth - 60) / 3);
        make.top.equalTo(self.lineLabel1.mas_bottom).offset(18);
    }];
    
    [self.withdrawalCommissionDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo((ScreenWidth - 60) / 3);
        make.top.equalTo(self.cumulativeCommissionLabel.mas_bottom).offset(11.5);
    }];
    
    [self.lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.withdrawalCommissionDesLabel.mas_right).offset(10);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(31);
        make.top.equalTo(self.lineLabel1.mas_bottom).offset(20);
    }];
    
    [self.withdrawalButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-22);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(69);
        make.top.equalTo(self.lineLabel1.mas_bottom).offset(23.5);

       }];
    
    if (ScreenWidth == 320) {
        self.lineLabel.hidden = YES;
        self.lineLabel2.hidden = YES;
    }
    MJWeakSelf;
    [self.commissionManagerButn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        XinWithDrawRecordVC * vc = [XinWithDrawRecordVC new];
        [[weakSelf viewController].navigationController pushViewController:vc animated:YES];
    }];
    
    [self.withdrawalButn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        
//        WithdrawDepositVC * vc = [WithdrawDepositVC new];
//        vc.urlStr = @"api/user.dealer.withdraw/submit_info";
//        vc.submitUrlStr = @"api/user.dealer.withdraw/submit";
//        [[weakSelf viewController].navigationController pushViewController:vc animated:YES];
        XinWithdrawVC * vc = [XinWithdrawVC new];
        [[weakSelf viewController].navigationController pushViewController:vc animated:YES];
        
    }];
    [self.outButn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//        WithdrawDepositVC * vc = [WithdrawDepositVC new];
//        vc.urlStr = @"api/user.withdraw/submit_info";
//        vc.submitUrlStr = @"api/user.withdraw/submit";
//        [[weakSelf viewController].navigationController pushViewController:vc animated:YES];
        
        MyPurseVC * vc = [MyPurseVC new];
     [[weakSelf viewController].navigationController pushViewController:vc animated:YES];
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
       [self.userImageView addGestureRecognizer:tap];
    
    
    
    
    
}
-(void)setButnAction:(UIButton *)butn{
    MyDetailMessageVC * vc = [[MyDetailMessageVC alloc]init];
    [[self viewController].navigationController pushViewController:vc animated:YES];
}
-(void)tap:(UITapGestureRecognizer *)tap{
    MyDetailMessageVC * vc = [[MyDetailMessageVC alloc]init];
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

@end
