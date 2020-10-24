//
//  CouponModel.h
//  LYMallApp
//
//  Created by Mac on 2020/4/1.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CouponModel : NSObject
@property (copy, nonatomic) NSString *create_time;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *reduce_price;
@property (copy, nonatomic) NSString *min_price;
@property (copy, nonatomic) NSString *update_time;
@property (strong, nonatomic) NSNumber *user_id;
@property (strong, nonatomic) NSNumber *expire_type;
@property (strong, nonatomic) NSNumber *discount;
@property (strong, nonatomic) NSNumber *coupon_id;
@property (strong, nonatomic) NSNumber *is_expire;
@property (strong, nonatomic) NSNumber *wxapp_id;
@property (strong, nonatomic) NSNumber *is_use;
@property (strong, nonatomic) NSNumber *user_coupon_id;
@property (strong, nonatomic) NSNumber *expire_day;
@property (strong, nonatomic) NSDictionary *color;
@property (strong, nonatomic) NSDictionary *coupon_type;
@property (strong, nonatomic) NSDictionary *start_time;
@property (strong, nonatomic) NSDictionary *end_time;
@property (strong, nonatomic) NSDictionary *state;


@end

NS_ASSUME_NONNULL_END
