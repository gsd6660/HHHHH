//
//  AgentManagerTwoCell.m
//  LYMallApp
//
//  Created by Mac on 2020/4/23.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AgentManagerTwoCell.h"

@implementation AgentManagerTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
        self.layer.cornerRadius = 5;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
