//
//  MySubscripCell.m
//  LYMallApp
//
//  Created by Mac on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MySubscripCell.h"

@implementation MySubscripCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)getDataDic:(NSDictionary *)dic{
    
    self.namelable.text = dic[@"name"];
    self.skuLable.text = dic[@"sku"];
    self.cycle_numLable.text = [NSString stringWithFormat:@"第%@期",dic[@"cycle_num"]];
    if ([dic[@"status"] intValue] == 0) {
        //0未发货 1已发货 2已完成
        self.statusLable.text = @"未发货 ";
        self.period_timeLable.text = [NSString stringWithFormat:@"预发货时间：%@",dic[@"period_time"]];

    }else if ([dic[@"status"] intValue] == 1) {
        self.statusLable.text = @"已发货";
    }else if ([dic[@"status"] intValue] == 2) {
        self.statusLable.text = @"已完成";
        self.period_timeLable.text = [NSString stringWithFormat:@"收货时间：%@",dic[@"period_time"]];

    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
