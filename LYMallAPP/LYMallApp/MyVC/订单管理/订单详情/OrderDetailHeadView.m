//
//  OrderDetailHeadView.m
//  LYMallApp
//
//  Created by CC on 2020/3/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "OrderDetailHeadView.h"

@implementation OrderDetailHeadView

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
    
    CGFloat H = ScreenHeight > 812 ? 137+ 24 : 137;
    CGFloat H1 = ScreenHeight > 812 ? 45 : 35;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0,0,ScreenWidth,H);

    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,ScreenWidth,H);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:58/255.0 green:205/255.0 blue:123/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:89/255.0 green:229/255.0 blue:151/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0f)];

    [self.layer addSublayer:gl];
    
    UIButton * leftButn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButn setImage:CCImage(@"jft_but_whitearrow") forState:UIControlStateNormal];
    leftButn.frame = CGRectMake(10, H1, 80, 30);
    leftButn.backgroundColor = [UIColor clearColor];
    [leftButn addTarget:self action:@selector(leftButn:) forControlEvents:UIControlEventTouchUpInside];
    leftButn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftButn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;

    [self addSubview:leftButn];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake((ScreenWidth - 100) /2,H1,100,18);
    label.numberOfLines = 0;
    label.text = @"订单详情";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONTSIZE(19);
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(26,H - 59,150,16);
    label1.numberOfLines = 0;
    label1.font = FONTSIZE(17);
    label1.textColor = [UIColor whiteColor];
//    label1.text = @"待付款";
    self.titleLabel = label1;
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(26.5,H - 33,ScreenWidth - 80,12.5);
    label2.numberOfLines = 0;
//    label2.text = @"剩13小时自动关闭";
    self.timeLabel = label2;
    label2.font = FONTSIZE(13);
    label2.textColor = [UIColor whiteColor];

    [self addSubview:label2];
    
    
    
}
-(void)leftButn:(UIButton *)butn{
    UIViewController * vc = [self  viewController];
    [vc.navigationController popViewControllerAnimated:YES];
}



@end
