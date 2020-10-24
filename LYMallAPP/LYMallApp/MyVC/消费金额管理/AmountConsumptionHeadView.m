//
//  AmountConsumptionHeadView.m
//  LYMallApp
//
//  Created by Mac on 2020/5/29.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AmountConsumptionHeadView.h"

@implementation AmountConsumptionHeadView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
     if (self) {
//         self.contentView.backgroundColor = [UIColor whiteColor];
         
         [self setUI];
       }
       return self;
}




-(void)setUI{
    self.grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
            self.grayView.backgroundColor = kUIColorFromRGB(0xf1f4f8);
            [self addSubview:self.grayView];
  
    
            self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, 39)];
            self.topView.backgroundColor = [UIColor whiteColor];
            [self addSubview:self.topView];
          

    self.orderNumLable = [[UILabel alloc]init];
    self.orderNumLable.text = @"订单号：451789648578";
    self.orderNumLable.textColor = kUIColorFromRGB(0x333333);
    self.orderNumLable.font = FONTSIZE(14);
    [self.topView addSubview:self.orderNumLable];
    
    self.stateLable = [[UILabel alloc]init];
    self.stateLable.text = @"订单状态";
    self.stateLable.textColor = kUIColorFromRGB(0x666666);
    self.stateLable.font = FONTSIZE(14);
    [self.topView addSubview:self.stateLable];

    
    [self.orderNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(10.5);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(230);
    }];
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.right.mas_equalTo(-9.5);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(13);
    }];

      
}







@end

