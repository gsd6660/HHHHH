//
//  NewHoemTwoCell.m
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "NewHoemTwoCell.h"
#import "LXTaskHallVC.h"
@implementation NewHoemTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    YBDViewBorderRadius(self.bgView, 10);
 

//    LXTaskHallVC * vc = [[LXTaskHallVC alloc]init];
//       [self.navigationController pushViewController:vc animated:YES];

    
    UIControl * tap1 = [[UIControl alloc]initWithFrame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, self.height)];
    [self addSubview:tap1];
    [tap1 addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)tapClick{
    LXTaskHallVC * vc = [[LXTaskHallVC alloc]init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

@end
