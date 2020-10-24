//
//  MallModel.h
//  LYMallApp
//
//  Created by Mac on 2020/4/2.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class SKUModel;
@interface MallModel : NSObject
@property(strong,nonatomic)NSString * selling_point;
@property(strong,nonatomic)NSString * goods_image;
@property(strong,nonatomic)NSString * goods_name;
@property(strong,nonatomic)NSNumber * goods_id;
@property(strong,nonatomic)NSNumber * goods_sales;
@property(strong,nonatomic)NSDictionary * goods_sku;
@property(strong,nonatomic)NSNumber * gift_goods_type;


@end




NS_ASSUME_NONNULL_END
