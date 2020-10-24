//
//  RefundRequestVC.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

typedef enum Order_Status{
    OrderStatusNotSend, //未发货
    OrderStatusNotArrive //没收到货物
} OrderStatus;

NS_ASSUME_NONNULL_BEGIN

@interface RefundRequestVC : BaseViewController
@property(nonatomic,strong)NSString * order_id;
@property(nonatomic,assign) OrderStatus status;
@end

NS_ASSUME_NONNULL_END
