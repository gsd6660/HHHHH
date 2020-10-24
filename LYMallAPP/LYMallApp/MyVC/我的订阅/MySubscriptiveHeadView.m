//
//  MySubscriptiveHeadView.m
//  LYMallApp
//
//  Created by Mac on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MySubscriptiveHeadView.h"
#import "GoodsDetailsVC.h"
@implementation MySubscriptiveHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    [self setUI];
    }
    return self;
}

-(void)setUI{
    
    CGFloat H = ScreenHeight > 812 ? 224 : 203;
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
    label.text = @"我的订阅";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONTSIZE(19);
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(26,90,ScreenWidth - 52,17);
    label1.numberOfLines = 0;
    label1.font = FONTSIZE(15);
    label1.textColor = [UIColor whiteColor];
    label1.text = @"我的订阅服务：三口之家";
    self.nameLable = label1;
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(26.5,label1.bottom + 12.5,205,12.5);
    label2.numberOfLines = 0;
    label2.text = @"开始时间：2020-01-01";
    label2.font = FONTSIZE(13);
    label2.textColor = [UIColor whiteColor];
    self.crea_timeLable = label2;

    [self addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.frame = CGRectMake(26.5,label2.bottom + 12.5,205,12.5);
    label3.numberOfLines = 0;
    label3.text = @"结束时间：2020-12-01";
    label3.font = FONTSIZE(13);
    label3.textColor = [UIColor whiteColor];
    self.end_timeLable = label3;

    [self addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] init];
       label4.frame = CGRectMake(26.5,label3.bottom + 12.5,205,12.5);
       label4.numberOfLines = 0;
       label4.text = @"共12期，已完成5期";
       label4.font = FONTSIZE(13);
       label4.textColor = [UIColor whiteColor];
    self.cycle_numLable = label4;

       [self addSubview:label4];
    
    
    QMUIFillButton * xufeiButn = [[QMUIFillButton alloc]initWithFrame:CGRectMake(ScreenWidth - 90 - 23, H - 45 - 27.5, 90, 27.5)];
    xufeiButn.backgroundColor = [UIColor whiteColor];
    [xufeiButn setTitle:@"立即续订" forState:UIControlStateNormal];
    [xufeiButn setTitleColor:kUIColorFromRGB(0x3ACD7B) forState:UIControlStateNormal];
    xufeiButn.titleLabel.font = FONTSIZE(14);
    [xufeiButn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        GoodsDetailsVC * vc = [GoodsDetailsVC new];
               vc.goods_id = [NSString stringWithFormat:@"%@",self.goods_id];
        vc.typeStr = @"1";
               [[self viewController].navigationController pushViewController:vc animated:YES];
    }];
    [self addSubview:xufeiButn];
  
    
}


-(void)leftButn:(UIButton *)butn{
    UIViewController * vc = [self  viewController];
    [vc.navigationController popViewControllerAnimated:YES];
}

-(void)getDataDic:(NSDictionary *)dic{
    self.nameLable.text = [NSString stringWithFormat:@"我的订阅服务：%@",dic[@"cycle_name"]];
    self.cycle_numLable.text = [NSString stringWithFormat:@"共%@期 已完成%@期",dic[@"cycle_num"],dic[@"cycle_ok"]];
    self.crea_timeLable.text = [NSString stringWithFormat:@"开始时间：%@",dic[@"crea_time"]];
    self.end_timeLable.text = [NSString stringWithFormat:@"结束时间：%@",dic[@"end_time"]];
    self.goods_id = [NSString stringWithFormat:@"%@",dic[@"goods_id"]];
}
@end
