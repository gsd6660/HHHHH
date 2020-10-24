
//
//  CommissionManagerTwoCell.m
//  LYMallApp
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CommissionManagerTwoCell.h"
#import "CommissionModel.h"
@implementation CommissionManagerTwoCell

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
    self.tixianTimeLable.text = [NSString stringWithFormat:@"提现时间：%@",model.create_time];
    self.daozhangLabel.text = [NSString stringWithFormat:@"到账时间：%@",model.audit_time_type];
    self.qudaoLabel.text = [NSString stringWithFormat:@"提现渠道：%@",model.channel_type];
    self.moneyLabel.text = [NSString stringWithFormat:@"提现金额：%@",model.money];
    self.feeLabel.text = [NSString stringWithFormat:@"手续费：%@",model.fee];
    self.realMoneyLable.text = [NSString stringWithFormat:@"到账金额：%@",model.real_money];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
