//
//  LXCollegeOneCell.m
//  LYMallApp
//
//  Created by gds on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//2

#import "LXCollegeOneCell.h"

@implementation LXCollegeOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    YBDViewBorderRadius(self, 10);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setFrame:(CGRect)frame{
    frame.size.width -=20;
    frame.origin.x = 10;
//    self.layer.cornerRadius = 25;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
