//
//  LXRuleTableViewCell.m
//  LYMallApp
//
//  Created by gds on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXRuleTableViewCell.h"

@implementation LXRuleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    YBDViewBorderRadius(self.titleLabel, self.titleLabel.height/2);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
