//
//  LXTaskHeaderView.m
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXTaskHeaderView.h"

@implementation LXTaskHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    YBDViewBorderRadius(self.sdcyleScrollView, 10);
    YBDViewBorderRadius(self.bgView, 10);
    self.backgroundColor = UIColor.clearColor;
    self.top.constant = -StatusBarHeight;
    
    
    
    
}



- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    NSMutableArray * images = [NSMutableArray array];
    for (NSDictionary * dic in dataArray) {
        [images addObject:dic[@"thumb"]];
    }
    self.sdcyleScrollView.imageURLStringsGroup = images;
    
}

@end
