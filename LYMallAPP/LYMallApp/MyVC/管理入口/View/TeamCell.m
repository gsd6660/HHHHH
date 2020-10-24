

//
//  TeamCell.m
//  LYMallApp
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "TeamCell.h"
#import "TeamModel.h"
@implementation TeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.shadowColor = [UIColor colorWithRed:94/255.0 green:90/255.0 blue:90/255.0 alpha:0.11].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0,0);
    self.bgView.layer.shadowOpacity = 1;
    self.bgView.layer.shadowRadius = 8;
    self.bgView.layer.cornerRadius = 5;
}

-(void)setModel:(TeamModel *)model{
    _model = model;
    [self.userImgView yy_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholder:nil];
    self.nameLabel.text = model.real_name;
    self.moblieLable.text = [NSString stringWithFormat:@"%@      %@",model.mobile,model.create_time];
    self.up_real_nameLabel.text = [NSString stringWithFormat:@"上级姓名：%@",model.up_real_name];
    if ([model.level_name isEqualToString:@"团员"]) {
        self.typeImagView.image = CCImage(@"团员");
    }else if ([model.level_name isEqualToString:@"团队长"]) {
        self.typeImagView.image = CCImage(@"团队长");
    }

    self.orderCountLabel.text = [NSString stringWithFormat:@"%@",model.order_sum];
    self.xiaofeiLabel.text = [NSString stringWithFormat:@"%@",model.order_consume];
    self.yongjinLabel.text = [NSString stringWithFormat:@"%@",model.order_agency];
    self.noDaozhangLabel.text = [NSString stringWithFormat:@"%@",model.order_not_account];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
