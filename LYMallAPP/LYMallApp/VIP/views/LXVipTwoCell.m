//
//  LXVipTwoCell.m
//  LYMallApp
//
//  Created by guxiang on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXVipTwoCell.h"

@implementation LXVipTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    YBDViewBorderRadius(self, 10);
    // Initialization code
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
