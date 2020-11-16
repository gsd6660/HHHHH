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
    YBDViewBorderRadius(self.rightBtn, 15);
    self.rightBtn.backgroundColor = UIColorHex(0x008AFF);
    [self.rightBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    // Initialization code
}



- (void)setFrame:(CGRect)frame{
    frame.size.width -=20;
    frame.origin.x = 10;
//    self.layer.cornerRadius = 25;
    [super setFrame:frame];
}

 
- (IBAction)rightClick:(id)sender {
    
    self.ClickBtn();
    
}



@end
