


//
//  SureOrderSectionFootView.m
//  LYMallApp
//
//  Created by Mac on 2020/3/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "SureOrderSectionFootView.h"

@implementation SureOrderSectionFootView

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
//       UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 20, 10)];
//        bgView.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:bgView];
//
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(7, 7)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = bgView.bounds;
//        maskLayer.path = maskPath.CGPath;
//        bgView.layer.mask  = maskLayer;
        
        UIView * grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth , 10)];
        grayView.backgroundColor = kUIColorFromRGB(0xf9f9f9);
        [self.contentView addSubview:grayView];

        
        
    }
    return self;
}


@end
