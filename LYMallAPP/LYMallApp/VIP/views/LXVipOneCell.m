//
//  LXVipOneCell.m
//  LYMallApp
//
//  Created by guxiang on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXVipOneCell.h"

@implementation LXVipOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    YBDViewBorderRadius(self, 10);
//    self.topBgView.layer.cornerRadius = 10;
//    self.top
    YBDViewBorderRadius(self.topBgView, 10);
    YBDViewBorderRadius(self.contentBgView, 10);
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
