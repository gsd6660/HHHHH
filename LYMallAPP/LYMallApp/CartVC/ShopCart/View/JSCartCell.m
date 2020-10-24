//
//  JSCartCell.m
//  JSShopCartModule
//
//  Created by 乔同新 on 16/6/9.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import "JSCartCell.h"

#import "CartModel.h"

@interface JSCartCell ()



@end

@implementation JSCartCell

- (void)awakeFromNib {
    [super awakeFromNib];

}
//减
- (IBAction)cut:(UIButton *)sender {
    NSInteger count = [self.countLabel.text integerValue];
    count--;
    if (count <= 0) {
        return;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%ld", count];
    if (self.CutBlock) {
        self.CutBlock(self.countLabel);
    }
}

//加
- (IBAction)add:(UIButton *)sender {
    NSInteger count = [self.countLabel.text integerValue];
    count++;
    self.countLabel.text = [NSString stringWithFormat:@"%ld", count];
    if (self.AddBlock) {
        self.AddBlock(self.countLabel);
    }
}

//选中
- (IBAction)click:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"jft_but_selected"] forState:(UIControlStateNormal)];
    } else {
        [sender setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:(UIControlStateNormal)];
    }
    if (self.ClickRowBlock) {
        self.ClickRowBlock(sender.selected);
    }
}



- (void)setGoodsModel:(GoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    self.clickBtn.selected = goodsModel.isSelect;
    if (goodsModel.isSelect) {
        [self.clickBtn setImage:[UIImage imageNamed:@"jft_but_selected"] forState:(UIControlStateNormal)];
    } else {
        [self.clickBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:(UIControlStateNormal)];
    }
    self.countLabel.text = [NSString stringWithFormat:@"%@", goodsModel.total_num];
    [self.goodImageView yy_setImageWithURL:[NSURL URLWithString:goodsModel.goods_image] placeholder:nil];
    self.goodsNameLabel.text = goodsModel.goods_name;
    self.priceLabel.text = [NSString stringWithFormat:@"%@元", goodsModel.goods_price];
    self.brandLabel.text = [NSString stringWithFormat:@"%@", goodsModel.goods_sku[@"goods_attr"]];
}

@end
