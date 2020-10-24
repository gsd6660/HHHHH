//
//  LXMeOneCell.m
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXMeOneCell.h"

@implementation LXMeOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.oneBtn.imagePosition = QMUIButtonImagePositionTop;
    self.oneBtn.spacingBetweenImageAndTitle = 5;
    
//    self.twoBtn.imagePosition = QMUIButtonImagePositionTop;
//    self.twoBtn.spacingBetweenImageAndTitle = 5;
    
    self.threeBtn.imagePosition = QMUIButtonImagePositionTop;
    self.threeBtn.spacingBetweenImageAndTitle = 5;
    
    self.fourBtn.imagePosition = QMUIButtonImagePositionTop;
    self.fourBtn.spacingBetweenImageAndTitle = 5;
    YBDViewBorderRadius(self, 10);
    // Initialization code
}

- (IBAction)oneClick:(id)sender {
    self.oneClickBtn();
    
}
- (IBAction)threeClick:(id)sender {
    self.threeClickBtn();
    
}
- (IBAction)fourClick:(id)sender {
    self.fourClickBtn();
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
