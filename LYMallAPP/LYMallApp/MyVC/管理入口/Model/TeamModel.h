//
//  TeamModel.h
//  LYMallApp
//
//  Created by Mac on 2020/4/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeamModel : NSObject
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *order_consume;
@property(nonatomic,strong)NSString *level_name;
@property(nonatomic,strong)NSString *order_not_account;
@property(nonatomic,strong)NSString *avatarUrl;
@property(nonatomic,strong)NSString *real_name;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *order_agency;
@property(nonatomic,strong)NSString *up_real_name;
@property(nonatomic,strong)NSNumber *user_id;
@property(nonatomic,strong)NSNumber *order_sum;

@end

NS_ASSUME_NONNULL_END
