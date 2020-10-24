//
//  MessageListDetailCell.m
//  LYMallApp
//
//  Created by Mac on 2020/5/5.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MessageListDetailCell.h"

@implementation MessageListDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
