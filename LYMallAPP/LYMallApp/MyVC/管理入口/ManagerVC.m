//
//  ManagerVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ManagerVC.h"
#import "CommissionManagerVC.h"
#import "TeamVC.h"
#import "ManagerOrderVC.h"
@interface ManagerVC ()

@end

@implementation ManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分销管理";
    //创建相应的子控制器
    CommissionManagerVC *vc1 = [[CommissionManagerVC alloc]init];
    vc1.tabBarItem.title = @"佣金";
    vc1.tabBarItem.image = [[UIImage imageNamed:@"jft_but_commission-2"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"jft_but_commission"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    TeamVC *vc2 = [[TeamVC alloc]init];
    vc2.tabBarItem.title = @"团队";
    vc2.tabBarItem.image = [[UIImage imageNamed:@"jft_icon_team"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc2.tabBarItem.selectedImage = [[UIImage imageNamed:@"jft_but_team1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ManagerOrderVC *vc3 = [[ManagerOrderVC alloc]init];
    vc3.tabBarItem.title = @"订单";
    vc3.tabBarItem.image = [[UIImage imageNamed:@"jft_icon_order"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc3.tabBarItem.selectedImage = [[UIImage imageNamed:@"jft_icon_order-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.tabBar.tintColor = [UIColor colorWithRed:58.0/255.0 green:205.0/255.0 blue:123.0/255.0 alpha:1];
    self.viewControllers = @[vc1,vc2,vc3];
}



@end
