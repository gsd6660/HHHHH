//
//  RegisterView.h
//  LYMallApp
//
//  Created by Mac on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterView : UIView
@property(nonatomic,strong)UIImageView * phoneImageView;
@property(nonatomic,strong)QMUITextField * phoneTF;
@property(nonatomic,strong)UILabel * lineLabel1;

@property(nonatomic,strong)UIImageView * codeImageView;//验证码
@property(nonatomic,strong)QMUITextField * codeTF;
@property(nonatomic,strong)UILabel * lineLabel21;
@property(nonatomic,strong)UIButton * codeButn;
@property(nonatomic,strong)UILabel * lineLabel2;

@property(nonatomic,strong)UIImageView * passImageView;
@property(nonatomic,strong)QMUITextField * passTF;
@property(nonatomic,strong)UILabel * lineLabel3;

@property(nonatomic,strong)UIImageView * inviterImageView;
@property(nonatomic,strong)QMUITextField * inviterTF;
@property(nonatomic,strong)UILabel * lineLabel4;

@property(nonatomic,strong)QMUIFillButton * registerButn;
@property(nonatomic,strong)UIButton * treatyButn;
@property(nonatomic,strong)UIButton * treatyButn1;


@end

NS_ASSUME_NONNULL_END
