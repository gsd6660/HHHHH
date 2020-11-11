//
//  RecommentModel.h
//  LYMallApp
//
//  Created by Mac on 2020/4/1.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommentModel : NSObject
@property(nonatomic,strong)NSString *selling_point;
@property(nonatomic,strong)NSString *goods_name;
@property(nonatomic,strong)NSNumber *goods_id;
@property(nonatomic,strong)NSString *goods_image;
@property(nonatomic,strong)NSNumber *goods_sales;
@property(nonatomic,strong)NSArray *tags;
@property(nonatomic,strong)NSDictionary *goods_sku;
@property(nonatomic, strong) NSString * sliver;
@end

NS_ASSUME_NONNULL_END
