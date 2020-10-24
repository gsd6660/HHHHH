//
//  ManagerOrderModel.h
//  LYMallApp
//
//  Created by Mac on 2020/4/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagerOrderModel : NSObject
@property(nonatomic,strong)NSString *right_level;
@property(nonatomic,strong)NSString *pay_price;
@property(nonatomic,strong)NSString *state_type;
@property(nonatomic,strong)NSString *left_level;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSNumber *order_sn;
@property(nonatomic,strong)NSNumber *left_name;
@property(nonatomic,strong)NSString *right_name;
@property(nonatomic,strong)NSString *commission_price;

@end

NS_ASSUME_NONNULL_END
