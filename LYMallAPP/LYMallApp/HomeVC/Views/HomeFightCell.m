//
//  HomeFightCell.m
//  LYMallApp
//
//  Created by Mac on 2020/3/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "HomeFightCell.h"

@implementation HomeFightCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.goodsImageView.layer.masksToBounds = YES;
//
//    self.goodsImageView.layer.cornerRadius = 15;
    
    self.goodsImageView.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner |QMUILayerMaxXMinYCorner;
    self.goodsImageView.layer.cornerRadius = 7.5;
    
}

@end
