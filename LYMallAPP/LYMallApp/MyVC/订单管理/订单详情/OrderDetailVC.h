//
//  OrderDetailVC.h
//  LYMallApp
//
//  Created by CC on 2020/3/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailVC : BaseViewController
@property(nonatomic,strong)NSString * order_id;
@property(nonatomic,strong)NSString * order_refund_id;

@end

NS_ASSUME_NONNULL_END
