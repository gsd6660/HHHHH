//
//  GoodsTopPriceCell.m
//  LYMallApp
//
//  Created by 科技 on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GoodsTopPriceCell.h"

@implementation GoodsTopPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",dataDic[@"goods_sku"][@"goods_price"]];
    self.beforePriceLabel.text = [NSString stringWithFormat:@"¥%@",dataDic[@"goods_sku"][@"line_price"]];
    self.countLabel.text = [NSString stringWithFormat:@"已售%@件",dataDic[@"goods_sales"]];
}





@end
