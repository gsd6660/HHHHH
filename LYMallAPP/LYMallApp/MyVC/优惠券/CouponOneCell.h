//
//  CouponOneCell.h
//  LYMallApp
//
//  Created by CC on 2020/3/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CouponModel;
@interface CouponOneCell : UITableViewCell
@property(nonatomic,strong)CouponModel *model;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *titLable;

@property (weak, nonatomic) IBOutlet UILabel *typeLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabe;
@property (weak, nonatomic) IBOutlet UIImageView *bgimgView;


@end

NS_ASSUME_NONNULL_END
