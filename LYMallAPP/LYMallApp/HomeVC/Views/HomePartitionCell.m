//
//  HomePartitionCell.m
//  LYMallApp
//
//  Created by Mac on 2020/4/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "HomePartitionCell.h"
#import "MallVC.h"
#import "HomeSectionThreeVC.h"
@implementation HomePartitionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setShowView:self.view1];
    [self setShowView:self.view2];
    [self setShowView:self.view3];
    MJWeakSelf;
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf gotoSectionVC:@"1" title:@"隆源自营专区"];
    }];
    [self.selfSaleImgView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf gotoSectionVC:@"2" title:@"超值平价区"];
    }];
    [self.pingjiaSaleImgView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
           [weakSelf gotoSectionVC:@"3" title:@"促销优惠区"];
       }];
       [self.view1 addGestureRecognizer:tap3];
    
    
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
           [weakSelf gotoSectionVC:@"4" title:@"礼包专区"];
       }];
       [self.view2 addGestureRecognizer:tap4];
    
    
    UITapGestureRecognizer * tap5 = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
           [weakSelf gotoSectionVC:@"5" title:@"积分专区"];
       }];
       [self.view3 addGestureRecognizer:tap5];
    
}

-(void)setShowView:(UIView *)view{
    view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.07].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,0);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 5;
    view.layer.cornerRadius = 3;
}

-(void)gotoMallVC:(NSString *)type title:(NSString *)title{
    MallVC * vc = [[MallVC alloc]init];
              vc.filter_type = type;
    vc.title = title;
              [[self viewController].navigationController pushViewController:vc animated:YES];
}

- (void)gotoSectionVC:(NSString*)type title:(NSString*)title{
    HomeSectionThreeVC * vc = [[HomeSectionThreeVC alloc]init];
    vc.title = title;
    vc.filter_type = type;
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

//- (IBAction)selfSalestap:(UITapGestureRecognizer *)sender {
//
//    NSLog(@"2222");
//}



@end
