//
//  LYGoodsModel.h
//  LYMallApp
//
//  Created by Mac on 2020/4/3.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYGoodsModel : NSObject
@property (nonatomic, copy) NSString *goods_image;
@property (nonatomic, copy) NSString *total_num;
@property (nonatomic, copy) NSNumber *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_type;
@property (nonatomic, copy) NSString *orginalPrice;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSNumber *category_id;
@property (nonatomic, copy) NSNumber *goods_sales;
@property (nonatomic, copy) NSDictionary *goods_sku;
@property (nonatomic, copy) NSString *cart_id;
@property (nonatomic, copy) NSString *selling_point;
@property (nonatomic, copy) NSString *total_pay_price;
@property (nonatomic, copy) NSString *express_price;
@property (nonatomic, copy) NSArray *goods_list;
@property (nonatomic, copy) NSArray *address;
@end

NS_ASSUME_NONNULL_END
