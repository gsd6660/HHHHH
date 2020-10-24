//
//  SureOrderGoodsCell.h
//  LYMallApp
//
//  Created by Mac on 2020/3/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberCalculate.h"

@class LYGoodsModel;
NS_ASSUME_NONNULL_BEGIN

@interface SureOrderGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NumberCalculate *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLable;
@property (weak, nonatomic) IBOutlet UILabel *sizeLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *realPriceLabel;
@property(nonatomic,strong)LYGoodsModel * model;

@end

NS_ASSUME_NONNULL_END
