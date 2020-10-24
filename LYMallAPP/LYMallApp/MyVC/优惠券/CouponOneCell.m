//
//  CouponOneCell.m
//  LYMallApp
//
//  Created by CC on 2020/3/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CouponOneCell.h"
#import "CouponModel.h"
@implementation CouponOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(CouponModel *)model{
    _model = model;
    self.titLable.text = model.name;
    self.timeLabel.text = [NSString stringWithFormat:@"%@至%@",model.start_time[@"text"],model.end_time[@"text"]];
    self.moneyLabel.text = model.reduce_price;
    self.typeLable.text = model.coupon_type[@"text"];
    self.stateLabe.text =model.state[@"text"];
   
    if ([model.state[@"text"] isEqualToString:@"已过期"]) {
        self.bgimgView.image = CCImage(@"jft_img_alreadyused");
    }else if ([model.state[@"text"] isEqualToString:@"未使用"]) {
        self.bgimgView.image = CCImage(@"jft_img_coupon");
    }else if ([model.state[@"text"] isEqualToString:@"已使用"]) {
        self.bgimgView.image = CCImage(@"jft_img_alreadyused");
        
    }
    
    

}


@end
