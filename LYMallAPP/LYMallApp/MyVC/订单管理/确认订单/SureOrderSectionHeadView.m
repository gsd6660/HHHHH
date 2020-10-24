//
//  SureOrderSectionHeadView.m
//  LYMallApp
//
//  Created by Mac on 2020/3/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "SureOrderSectionHeadView.h"

@implementation SureOrderSectionHeadView

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
    
        
        
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 20, 38)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];

        self.lable = [[QMUILabel alloc]initWithFrame:CGRectMake(10, 16, 100, 15)];
        self.lable.font = [UIFont systemFontOfSize:15 weight:30];
        [bgView addSubview:self.lable];

        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        bgView.layer.mask  = maskLayer;
        
    }
    return self;
}


-(void)setTextStr:(NSString *)textStr{
    _textStr = textStr;
   

    self.lable.text = textStr;
}

@end
