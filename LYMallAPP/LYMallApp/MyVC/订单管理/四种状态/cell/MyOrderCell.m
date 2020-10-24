//
//  MyOrderCell.m
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "MyOrderCell.h"

@implementation MyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftButn.layer.masksToBounds = YES;
    self.leftButn.layer.cornerRadius = 3;
    
    self.leftButn.layer.borderWidth = 1;
    self.leftButn.layer.borderColor = kUIColorFromRGB(0x7B8391).CGColor;
}
-(void)setDicData:(NSDictionary *)dicData{
    _dicData = dicData;
    self.snLable.text = [NSString stringWithFormat:@"订单号：%@",dicData[@"order_sn"]];
    [self.bgImageView yy_setImageWithURL:[NSURL URLWithString:dicData[@"goods_image"]] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
    self.statelabel.text = @"已取消";
    
    self.titLable.text = dicData[@"goods_name"];
    self.guigeLable.text = dicData[@"description"];
    self.moneyLable.text = [NSString stringWithFormat:@"¥%@",dicData[@"order_amount"]];
    self.countLable.text = [NSString stringWithFormat:@"数量：%@",dicData[@"goods_num"]];
    
}

- (IBAction)leftButn:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
