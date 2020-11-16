//
//  NewHoemTwoCell.m
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "NewHoemTwoCell.h"
#import "LXTaskHallVC.h"
#import "MallVC.h"
@implementation NewHoemTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    YBDViewBorderRadius(self.bgView, 10);
 

//    LXTaskHallVC * vc = [[LXTaskHallVC alloc]init];
//       [self.navigationController pushViewController:vc animated:YES];
    UIControl * tap = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2, self.height)];
    [self addSubview:tap];
    [tap addTarget:self action:@selector(tapClick1) forControlEvents:UIControlEventTouchUpInside];
    
    UIControl * tap1 = [[UIControl alloc]initWithFrame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, self.height)];
    [self addSubview:tap1];
    [tap1 addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)tapClick1{
    
    MallVC * vc = [[MallVC alloc]init];
    vc.title = @"商城";
//    vc.category_id = [NSString stringWithFormat:@"%@",dic[@"category_id"]];
    [[self viewController].navigationController pushViewController:vc animated:YES];
}


- (void)tapClick{
    LXTaskHallVC * vc = [[LXTaskHallVC alloc]init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

@end
