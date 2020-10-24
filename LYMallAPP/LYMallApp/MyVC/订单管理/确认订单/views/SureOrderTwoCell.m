//
//  SureOrderTwoCell.m
//  LYMallApp
//
//  Created by 科技 on 2020/3/31.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "SureOrderTwoCell.h"

@implementation SureOrderTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.descBtn.imagePosition = QMUIButtonImagePositionRight;
    self.descBtn.spacingBetweenImageAndTitle = 3;
    [self.descBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        self.btnClick(self.descBtn);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
