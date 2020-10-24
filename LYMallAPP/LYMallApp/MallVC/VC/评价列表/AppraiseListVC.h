//
//  AppraiseListVC.h
//  LYMallApp
//
//  Created by Mac on 2020/3/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppraiseListVC : BaseViewController
@property(nonatomic,strong)NSString * goods_id;//商品id
@property(nonatomic,strong)NSString * type;//0 全部（默认） 1有图 2最新
@property(nonatomic,strong)NSString * goods_type;//0 全部（默认） 1有图 2最新

@end

NS_ASSUME_NONNULL_END
