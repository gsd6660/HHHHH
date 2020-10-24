//
//  CommissionManagerCell.m
//  LYMallApp
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CommissionManagerCell.h"
#import "CommissionModel.h"
@implementation CommissionManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.shadowColor = [UIColor colorWithRed:94/255.0 green:90/255.0 blue:90/255.0 alpha:0.11].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0,0);
    self.bgView.layer.shadowOpacity = 1;
    self.bgView.layer.shadowRadius = 8;
    self.bgView.layer.cornerRadius = 5;
}

-(void)setModel:(CommissionModel *)model{
    _model = model;
    [self.userImageView yy_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholder:nil];
    self.nameLable.text = model.real_name;
    self.timeLabel.text = model.settle_time;
    self.moneyLable.text = model.commission_price;
    self.mobilelable.text = model.phone;
    if ([model.level_name isEqualToString:@"团员"]) {
        self.typeImageView.image = CCImage(@"团员");
    }else if ([model.level_name isEqualToString:@"团队长"]) {
        self.typeImageView.image = CCImage(@"团队长");
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
