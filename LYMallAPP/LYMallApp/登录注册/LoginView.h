//
//  LoginView.h
//  LYMallApp
//
//  Created by Mac on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginView : UIView
@property(nonatomic,strong)UIImageView * phoneImageView;
@property(nonatomic,strong)QMUITextField * phoneTF;
@property(nonatomic,strong)UILabel * lineLabel1;

@property(nonatomic,strong)UIImageView * passImageView;
@property(nonatomic,strong)QMUITextField * passTF;
@property(nonatomic,strong)UILabel * lineLabel2;

@property(nonatomic,strong)UILabel * lineLabel3;
@property(nonatomic,strong)UIButton * getCodeButn;


@property(nonatomic,strong)QMUIButton * codeButn;
@property(nonatomic,strong)QMUIButton * forgetButn;
@property(nonatomic,strong)QMUIFillButton * loginButn;
@property(nonatomic,strong)QMUIButton * registerButn;

@property (strong, nonatomic)  NSString * type;//登录方式 1密码登录 2验证码登录
@end

NS_ASSUME_NONNULL_END
