
//
//  MyOrderOneCell.m
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "MyOrderOneCell.h"

@implementation MyOrderOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setConsumeData:(NSDictionary *)consumeData{
    _consumeData = consumeData;
     [self.bgImageView yy_setImageWithURL:[NSURL URLWithString:consumeData[@"goods_image"]] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
     
     self.titLable.text = consumeData[@"goods_name"];
     if ([consumeData[@"goods_sku"] length] == 0) {
         self.guigeLable.text = @"规格：此商品没有规格";
     }else{
         self.guigeLable.text = [NSString stringWithFormat:@"规格：%@",consumeData[@"goods_sku"]];
     }
     self.moneyLable.text = [NSString stringWithFormat:@"¥%@",consumeData[@"goods_price"]];
     self.numLbale.text = [NSString stringWithFormat:@"%@",consumeData[@"total_num"]];
}

-(void)setDicData:(NSDictionary *)dicData{
    _dicData = dicData;
    [self.bgImageView yy_setImageWithURL:[NSURL URLWithString:dicData[@"image"][@"file_path"]] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
   
    
    self.titLable.text = dicData[@"goods_name"];
    if ([dicData[@"goods_attr"] length] == 0) {
        self.guigeLable.text = @"规格：此商品没有规格";

    }else{
        self.guigeLable.text = [NSString stringWithFormat:@"规格：%@",dicData[@"goods_attr"]];

    }
    self.moneyLable.text = [NSString stringWithFormat:@"¥%@",dicData[@"goods_price"]];
    self.numLbale.text = [NSString stringWithFormat:@"x%@",dicData[@"total_num"]];
//    self.moneyLable.text = [NSString stringWithFormat:@"￥%@",dicData[@"goods_price"]];
    
}

- (void)setAfterDetailModel:(NSDictionary *)dataDic{
     [self.bgImageView yy_setImageWithURL:[NSURL URLWithString:dataDic[@"goods_img"]] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
    self.titLable.text = dataDic[@"goods_name"];
    if ([dataDic[@"goods_attr"] length] == 0) {
        self.guigeLable.text = @"规格：此商品没有规格";

    }else{
        self.guigeLable.text = [NSString stringWithFormat:@"规格：%@",dataDic[@"goods_attr"]];

    }
    self.moneyLable.hidden = YES;
    self.numLbale.hidden = YES;
//    self.moneyLable.text = [NSString stringWithFormat:@"¥%@",dataDic[@"goods_price"]];
//    self.numLbale.text = [NSString stringWithFormat:@"x%@",dataDic[@"total_num"]];
}


- (IBAction)leftButn:(UIButton *)sender {
    if (self.blocka) {
        self.blocka(self.index);
    }
}

- (IBAction)rightButn:(UIButton *)sender {
    if (self.blockb) {
        self.blockb(self.index);
    
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
