//
//  AppraiseListCell.h
//  LYMallApp
//
//  Created by Mac on 2020/3/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TggStarEvaluationView.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppraiseListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbale;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet TggStarEvaluationView *starView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *orderLalbel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;

@property (nonatomic,strong)NSArray * imagesArray;
@end

NS_ASSUME_NONNULL_END
