//
//  LXMeTwoTableViewCell.m
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXMeTwoTableViewCell.h"

@implementation LXMeTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame{
    frame.size.width -=20;
    frame.origin.x = 10;
//    self.layer.cornerRadius = 25;
    [super setFrame:frame];
}
@end
