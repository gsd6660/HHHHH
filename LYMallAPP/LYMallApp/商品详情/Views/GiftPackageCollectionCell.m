//
//  GiftPackageCollectionCell.m
//  LYMallApp
//
//  Created by Mac on 2020/5/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GiftPackageCollectionCell.h"

@implementation GiftPackageCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    [self.goodsImageView yy_setImageWithURL:[NSURL URLWithString:dataDic[@"image"]] placeholder:nil];
    self.goodsNameLable.text = dataDic[@"goods_name"];
    self.priceLable.text = dataDic[@"goods_price"];
}
@end
