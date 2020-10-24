//
//  LXCollegeHeaderView.m
//  LYMallApp
//
//  Created by guxiang on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXCollegeHeaderView.h"

@implementation LXCollegeHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    YBDViewBorderRadius(self.bgView, 20);
    YBDViewBorderRadius(self.serachBtn, 20);
}

@end
