//
//  MySubscriptiveFootView.m
//  LYMallApp
//
//  Created by Mac on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MySubscriptiveFootView.h"

@implementation MySubscriptiveFootView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 20, 50)];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgView];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
         CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];        maskLayer.frame = self.bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.bgView.layer.mask  = maskLayer;
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



- (void)setUI{
    self.leftBtn = [[UIButton alloc]init];
    //    self.leftButn.backgroundColor = [UIColor yellowColor];
    [self.leftBtn setTitle:self.leftTitle forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = FONTSIZE(13);
    [self.leftBtn setTitleColor:kUIColorFromRGB(0x3ACD7B) forState:UIControlStateNormal];
    self.leftBtn.layer.borderWidth = 0.7;
    self.leftBtn.layer.borderColor = kUIColorFromRGB(0x3ACD7B).CGColor;
    self.leftBtn.layer.masksToBounds = YES;
    self.leftBtn.layer.cornerRadius = 14;
    [self addSubview:self.leftBtn];
    
    self.rightBtn = [[QMUIButton alloc]init];
    //    self.rightButn.backgroundColor = [UIColor orangeColor];
    [self.rightBtn setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    self.rightBtn.layer.borderWidth = 0.7;
    self.rightBtn.layer.borderColor = kUIColorFromRGB(0xB5B5B5).CGColor;
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
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.rightBtn.mas_left).offset(-10);
        make.width.offset(77.5);
        make.height.offset(30);
    }];
    
    
}

@end

