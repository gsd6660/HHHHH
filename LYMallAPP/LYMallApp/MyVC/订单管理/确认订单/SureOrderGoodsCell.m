//
//  SureOrderGoodsCell.m
//  LYMallApp
//
//  Created by Mac on 2020/3/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "SureOrderGoodsCell.h"
#import "LYGoodsModel.h"
@implementation SureOrderGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


-(void)setModel:(LYGoodsModel *)model{
    _model = model;
    [self.goodsImageView yy_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholder:nil];
    self.goodsNameLable.text = model.goods_name;
    self.priceLabel.text = model.goods_price;
    self.countLabel.text = [NSString stringWithFormat:@"x%@",model.total_num];
    self.realPriceLabel.text = model.goods_price;
    self.sizeLable.text = model.goods_sku[@"goods_attr"];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
