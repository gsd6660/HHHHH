//
//  OrderDetailBottomView.m
//  LYMallApp
//
//  Created by 科技 on 2020/3/31.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "OrderDetailBottomView.h"

@implementation OrderDetailBottomView


- (instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
}

-(void)setRightTitle:(NSString *)rightTitle{
    _rightTitle = rightTitle;
    [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];

}
- (void)setCenterTitle:(NSString *)centerTitle{
    _centerTitle = centerTitle;
    [self.centerBtn setTitle:centerTitle forState:UIControlStateNormal];
}


- (void)setUI{
    self.leftBtn = [[UIButton alloc]init];
    //    self.leftButn.backgroundColor = [UIColor yellowColor];
    [self.leftBtn setTitle:self.leftTitle forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = FONTSIZE(13);
    [self.leftBtn setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    self.leftBtn.layer.borderWidth = 0.7;
    self.leftBtn.layer.borderColor = kUIColorFromRGB(0xB5B5B5).CGColor;
    self.leftBtn.layer.masksToBounds = YES;
    self.leftBtn.layer.cornerRadius = 14;
    [self addSubview:self.leftBtn];
    
    self.centerBtn = [[UIButton alloc]init];
    //    self.leftButn.backgroundColor = [UIColor yellowColor];
    [self.centerBtn setTitle:self.centerTitle forState:UIControlStateNormal];
    self.centerBtn.titleLabel.font = FONTSIZE(13);
    [self.centerBtn setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    self.centerBtn.layer.borderWidth = 0.7;
    self.centerBtn.layer.borderColor = kUIColorFromRGB(0xB5B5B5).CGColor;
    self.centerBtn.layer.masksToBounds = YES;
    self.centerBtn.layer.cornerRadius = 14;
    [self addSubview:self.centerBtn];
    
    self.rightBtn = [[QMUIButton alloc]init];
    //    self.rightButn.backgroundColor = [UIColor orangeColor];
    [self.rightBtn setTitleColor:kUIColorFromRGB(0x3ACD7B) forState:UIControlStateNormal];
    self.rightBtn.layer.borderWidth = 0.7;
    self.rightBtn.layer.borderColor = kUIColorFromRGB(0x3ACD7B).CGColor;
    self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.layer.cornerRadius = 14;
    [self.rightBtn setTitle:self.rightTitle forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = FONTSIZE(13);
    [self addSubview:self.rightBtn];
    
    UILabel * lineLabel = [UILabel new];
    lineLabel.backgroundColor = kUIColorFromRGB(0xF5F5F5);
    [self addSubview:lineLabel];
    
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.offset(1);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-20);
        make.width.offset(77.5);
        make.height.offset(30);
    }];
    
    [self.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self.mas_centerY);
           make.right.equalTo(self.rightBtn.mas_left).offset(-10);
           make.width.offset(77.5);
           make.height.offset(30);
    }];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.centerBtn.mas_left).offset(-10);
        make.width.offset(77.5);
        make.height.offset(30);
    }];
    
    
}

@end
