//
//  HomeFourCell.h
//  TableViewDemo
//
//  Created by C C on 2020/3/9.
//  Copyright © 2020 CC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallModel.h"
NS_ASSUME_NONNULL_BEGIN
@class RecommentModel;
typedef void(^refreshDataBlock)(void);

@interface HomeFourCell : UICollectionViewCell
@property(nonatomic)UIImageView * goodsImageView;
@property(nonatomic)UIButton * markImageButnView;

@property(nonatomic)UILabel * titleLable;
@property(nonatomic)UILabel * desLable;
@property(nonatomic)UILabel * priceLable;
@property(nonatomic)UILabel * salesLable;
@property(nonatomic)UIButton * cartButn;
@property(nonatomic,copy)refreshDataBlock block;

@property(nonatomic)RecommentModel * model;


@property(nonatomic)MallModel * mallModel;


@end

NS_ASSUME_NONNULL_END
