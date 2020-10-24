//
//  CommissionModel.h
//  LYMallApp
//
//  Created by Mac on 2020/4/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommissionModel : NSObject
@property(nonatomic,strong)NSString *level_name;
@property(nonatomic,strong)NSString *avatarUrl;
@property(nonatomic,strong)NSString *commission_price;
@property(nonatomic,strong)NSString *settle_time;
@property(nonatomic,strong)NSString *real_name;
@property(nonatomic,strong)NSNumber *order_id;
@property(nonatomic,strong)NSNumber *user_id;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *fee;
@property(nonatomic,strong)NSString *real_money;


@property(nonatomic,strong)NSString *money;
@property(nonatomic,strong)NSString *audit_time_type;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *channel_type;



@end

NS_ASSUME_NONNULL_END
