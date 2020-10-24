//
//  LXTaskListTableViewCell.m
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXTaskListTableViewCell.h"

@implementation LXTaskListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    YBDViewBorderRadius(self, 10);
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    // Initialization code
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
