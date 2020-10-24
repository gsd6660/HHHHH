//
//  MallCell.h
//  LYMallApp
//
//  Created by Mac on 2020/3/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MallModel;

typedef void(^butnBlock)();
typedef void(^typeBlock)();


@interface MallCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UIButton *joinButn;
@property(nonatomic,copy)butnBlock block;
@property(nonatomic,copy)typeBlock typeblock;

@property(nonatomic,strong)MallModel *model;
@end

NS_ASSUME_NONNULL_END
