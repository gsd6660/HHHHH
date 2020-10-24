
//
//  ManagerOrderCell.m
//  LYMallApp
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ManagerOrderCell.h"
#import "ManagerOrderModel.h"
@implementation ManagerOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.shadowColor = [UIColor colorWithRed:94/255.0 green:90/255.0 blue:90/255.0 alpha:0.11].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0,0);
    self.bgView.layer.shadowOpacity = 1;
    self.bgView.layer.shadowRadius = 8;
    self.bgView.layer.cornerRadius = 5;
}


-(void)setModel:(ManagerOrderModel *)model{
    _model = model;
    self.orderNumLabel.text = [NSString stringWithFormat:@"订单编号：%@",model.order_sn];
    self.creatTimeLabel.text = [NSString stringWithFormat:@"创建时间：%@",model.create_time];
    self.orderMoneyLabel.text = [NSString stringWithFormat:@"订单金额：%@",model.pay_price];
    self.orderStatusLabel.text = [NSString stringWithFormat:@"订单状态：%@",model.state_type];
    self.orderNumLabel.text = [NSString stringWithFormat:@"订单编号：%@",model.order_sn];
    self.leftLabel.text = [NSString stringWithFormat:@"%@",model.left_level];
    self.rightLabel.text = [NSString stringWithFormat:@"%@",model.right_level];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@",model.commission_price];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
