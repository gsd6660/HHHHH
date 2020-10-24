//
//  MyCouponCell.h
//  LYMallApp
//
//  Created by CC on 2020/3/29.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CouponModel;
NS_ASSUME_NONNULL_BEGIN

@interface MyCouponCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property(nonatomic,strong)CouponModel *model;
@end

NS_ASSUME_NONNULL_END
