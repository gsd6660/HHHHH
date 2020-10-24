//
//  JSCartCell.h
//  JSShopCartModule
//
//  Created by 乔同新 on 16/6/9.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartModel.h"

@interface JSCartCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;//数量

@property (weak, nonatomic) IBOutlet UIButton *cutBtn;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

/**
 选中
 */
@property (nonatomic, copy) void (^ClickRowBlock)(BOOL isClick);

/**
 加
 */
@property (nonatomic, copy) void (^AddBlock)(UILabel *countLabel);

/**
 减
 */
@property (nonatomic, copy) void (^CutBlock)(UILabel *countLabel);


@property (nonatomic, strong) GoodsModel *goodsModel;

@end
