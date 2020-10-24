//
//  CommitAppleyView.m
//  LYMallApp
//
//  Created by Mac on 2020/4/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CommitAppleyView.h"

@implementation CommitAppleyView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    [self setUI];
    }
    return self;
}

-(void)setUI{
    
    CGFloat H = ScreenHeight > 812 ? 118+ 24 : 118;
    CGFloat H1 = ScreenHeight > 812 ? 55 : 35;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0,0,ScreenWidth,H);
    view.userInteractionEnabled = YES;
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,ScreenWidth,H);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:58/255.0 green:205/255.0 blue:123/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:89/255.0 green:229/255.0 blue:151/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0f)];

    [self.layer addSublayer:gl];
    
    UIButton * leftButn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButn1 setImage:CCImage(@"jft_but_whitearrow") forState:UIControlStateNormal];
    leftButn1.frame = CGRectMake(10, H1, 180, 30);
    [leftButn1 addTarget:self action:@selector(leftBackButn:) forControlEvents:UIControlEventTouchUpInside];
    leftButn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftButn1.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;

    [self addSubview:leftButn1];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake((ScreenWidth - 100) /2,H1,100,18);
    label.numberOfLines = 0;
    label.text = @"申请代理";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONTSIZE(19);
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    
  

    
}
-(void)leftBackButn:(UIButton *)butn{
    UIViewController * vc = [self  viewController];
    [vc.navigationController popViewControllerAnimated:YES];
}



@end
