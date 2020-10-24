//
//  MyCouponCell.m
//  LYMallApp
//
//  Created by CC on 2020/3/29.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MyCouponCell.h"
#import "CouponModel.h"
@implementation MyCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(CouponModel *)model{
    _model = model;
    self.moneyLabel.text = model.reduce_price;
    self.couponLabel.text = model.name;

}


@end
