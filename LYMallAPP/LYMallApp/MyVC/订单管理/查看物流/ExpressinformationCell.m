//
//  ExpressinformationCell.m
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "ExpressinformationCell.h"

@implementation ExpressinformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.nameLable.text = dic[@"express_name"];
    self.numLable.text = [NSString stringWithFormat:@"更新时间：%@",dic[@"update_time"]];

}

- (void)setDetailModel:(NSDictionary*)dic{
    if (![CheackNullOjb cc_isNullOrNilWithObject:dic[@"express"][@"express_name"]]) {
        self.nameLable.text = dic[@"express"][@"express_name"];
    }
    self.numLable.text = [NSString stringWithFormat:@"订单编号：%@",dic[@"express_no"]];
    self.timeLabel.text = [NSString stringWithFormat:@"发货时间：%@",dic[@"delivery_time"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
