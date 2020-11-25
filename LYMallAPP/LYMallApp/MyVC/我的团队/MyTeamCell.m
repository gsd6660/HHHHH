//
//  MyTeamCell.m
//  LYMallApp
//
//  Created by Mac on 2020/4/9.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MyTeamCell.h"
#import "MyTeamModel.h"
@implementation MyTeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(MyTeamModel *)model{
    _model = model;
    [self.userImageView yy_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholder:CCImage(@"jft_icon_headportrait")];
    self.nameLabel.text = model.nickName;
    self.phoneLabel.text = [NSString stringWithFormat:@"手机号：%@",model.phone];
//    self.moneyLabel.text = [NSString stringWithFormat:@"累计佣金：%@",model.commission];
    self.leveLabel.text = model.levelname;

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
