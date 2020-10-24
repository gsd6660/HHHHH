//
//  GroupGoodsCell.m
//  LYMallApp
//
//  Created by 科技 on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GroupGoodsCell.h"

@implementation GroupGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timerView.backgroundColor = [UIColor whiteColor];
    self.timerView.textColor =  kUIColorFromRGB(0x0BC160);
    self.timerView.colonColor = [UIColor whiteColor];
//    [self.timerView startTime:@"2020/03/30 12:00:00" endTime:@"2020/03/31 18:00:00" cdStyle:CutDownHome];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",dataDic[@"goods_sku"][@"seckill_price"]];
    self.descLabel.text = [NSString stringWithFormat:@"%@人团  已售%@件",dataDic[@"sharp_info"][@"total_sales"],dataDic[@"goods_sales"]];
    [self.timerView startTime:dataDic[@"sharp_info"][@"start_time"] endTime:dataDic[@"sharp_info"][@"end_time"] cdStyle:CutDownHome];
}

@end
