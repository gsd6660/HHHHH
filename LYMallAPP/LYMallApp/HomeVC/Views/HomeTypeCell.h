//
//  HomeTypeCell.h
//  LYMallApp
//
//  Created by Mac on 2020/3/10.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTypeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;


-(void)setValuecationWithDataDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
