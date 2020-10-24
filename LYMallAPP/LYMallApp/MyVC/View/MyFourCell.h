//
//  MyFourCell.h
//  LYMallApp
//
//  Created by Mac on 2020/3/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyFourCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property(nonatomic,assign)BOOL is_periods;//是否拥有订阅订单 true/false
@property(nonatomic,assign)BOOL is_show_sigend;//是否展示分销商（个人中心管理入口） true展示 false不展示

@end

NS_ASSUME_NONNULL_END
