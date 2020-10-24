//
//  HomePartitionCell.h
//  LYMallApp
//
//  Created by Mac on 2020/4/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePartitionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selfSaleImgView;
@property (weak, nonatomic) IBOutlet UIImageView *pingjiaSaleImgView;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;

@end

NS_ASSUME_NONNULL_END
