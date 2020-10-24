//
//  AddressModel.h
//  ZSWYAPP
//
//  Created by Mac on 2019/4/8.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressModel : NSObject
@property(nonatomic,strong)NSString * area_info;
@property(nonatomic,strong)NSNumber * address_id;
@property(nonatomic,strong)NSString * is_default;
@property(nonatomic,strong)NSNumber * province_id;
@property(nonatomic,strong)NSNumber * city_id;
@property(nonatomic,strong)NSNumber * area_id;


@property(nonatomic,strong)NSDictionary *region;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)NSString * phone;

@end

NS_ASSUME_NONNULL_END
