//
//  SureOrderVC.h
//  LYMallApp
//
//  Created by Mac on 2020/3/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

typedef enum _PushType{
    CartPush = 0, //购物车跳转
    DetailPush    ,  //商品详情跳转
    SharpDetailPush //限时商品详情跳转
} PushType;

NS_ASSUME_NONNULL_BEGIN

@interface SureOrderVC : BaseViewController
@property(nonatomic,copy)NSString * cart_ids;
@property(nonatomic,strong)NSMutableDictionary * prmDic;
@property(nonatomic,assign)PushType type;
@end

NS_ASSUME_NONNULL_END
