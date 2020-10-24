//
//  AfterInfoCell.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/28.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AfterInfoCell.h"
@implementation AfterInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.goBtn.layer.borderWidth = 0.5;
    self.goBtn.layer.borderColor = kUIColorFromRGB(0x3ACD7B).CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
