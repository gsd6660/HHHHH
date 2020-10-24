//
//  OrderPayViewController.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/1.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface OrderPayViewController : BaseViewController
@property(nonatomic,strong)NSDictionary * parmDic;
@property(nonatomic,strong)NSDictionary * dataSource;
@property(nonatomic,strong)NSString * order_id;//订单ID

@end

NS_ASSUME_NONNULL_END
