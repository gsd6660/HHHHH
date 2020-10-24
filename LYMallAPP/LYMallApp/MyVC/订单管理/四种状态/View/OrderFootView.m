

//
//  OrderFootView.m
//  LYMallApp
//
//  Created by Mac on 2020/3/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "OrderFootView.h"

@implementation OrderFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 20, 90)];
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
    [self.leftButn setTitle:leftTitle forState:UIControlStateNormal];
}

-(void)setRightTitle:(NSString *)rightTitle{
    _rightTitle = rightTitle;
    [self.rightButn setTitle:rightTitle forState:UIControlStateNormal];

}


-(void)setCenterTitle:(NSString *)centerTitle{
    _centerTitle = centerTitle;
    [self.centerButn setTitle:centerTitle forState:UIControlStateNormal];

}


-(void)setUI{
    self.priceLable = [[UILabel alloc]init];
    self.priceLable.textColor = kUIColorFromRGB(0x333333);
    self.priceLable.font = FONTSIZE(13);
    self.priceLable.text = @"共0件商品  实付款：¥0.0";
    self.priceLable.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.priceLable];
    
    self.leftButn = [[UIButton alloc]init];
    self.leftButn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    [self.leftButn setTitle:self.leftTitle forState:UIControlStateNormal];
    self.leftButn.titleLabel.font = FONTSIZE(13);
    [self.leftButn setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    self.leftButn.layer.borderWidth = 0.7;
       self.leftButn.layer.borderColor = kUIColorFromRGB(0x333333).CGColor;
       self.leftButn.layer.masksToBounds = YES;
       self.leftButn.layer.cornerRadius = 14;
    
    [self.bgView addSubview:self.leftButn];

    self.centerButn = [[UIButton alloc]init];
    self.centerButn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    self.centerButn.layer.borderWidth = 0.7;
       self.centerButn.layer.borderColor = kUIColorFromRGB(0x333333).CGColor;
       self.centerButn.layer.masksToBounds = YES;
       self.centerButn.layer.cornerRadius = 14;
    [self.centerButn setTitle:self.centerTitle forState:UIControlStateNormal];
    self.centerButn.titleLabel.font = FONTSIZE(13);
    [self.centerButn setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [self.bgView addSubview:self.centerButn];
    
    
    self.rightButn = [[QMUIButton alloc]init];
    self.rightButn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    [self.rightButn setTitleColor:kUIColorFromRGB(0x3ACD7B) forState:UIControlStateNormal];
    self.rightButn.layer.borderWidth = 0.7;
    self.rightButn.layer.borderColor = kUIColorFromRGB(0x3ACD7B).CGColor;
    self.rightButn.layer.masksToBounds = YES;
    self.rightButn.layer.cornerRadius = 14;
    
    [self.rightButn setTitle:self.rightTitle forState:UIControlStateNormal];
    self.rightButn.titleLabel.font = FONTSIZE(13);
    [self.bgView addSubview:self.rightButn];
    
    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(14);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
    }];
    
    
    [self.rightButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(28);
        make.bottom.mas_equalTo(-15.5);
        make.width.mas_equalTo(80);

    }];
    
    [self.centerButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightButn.mas_left).offset(-15);
        make.height.mas_equalTo(28);
        make.bottom.mas_equalTo(-15.5);
        make.width.mas_equalTo(80);

    }];
    
    [self.leftButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.centerButn.mas_left).offset(-15);
        make.height.mas_equalTo(28);
        make.bottom.mas_equalTo(-15.5);
        make.width.mas_equalTo(80);

    }];
    
    [self.leftButn addTarget:self action:@selector(leftButnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.centerButn addTarget:self action:@selector(centerButnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButn addTarget:self action:@selector(rightButnAction:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)leftButnAction:(UIButton *)butn{
    self.leftBtnClick(butn);
}

-(void)centerButnAction:(UIButton *)butn{
    self.centerBtnClick(butn);
}
-(void)rightButnAction:(UIButton *)butn{
    self.rightBtnClick(butn);
}

@end
