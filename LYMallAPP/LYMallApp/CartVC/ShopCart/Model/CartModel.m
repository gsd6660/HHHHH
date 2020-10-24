
//
//  CartModel.m
//  LYMallApp
//
//  Created by Mac on 2020/3/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CartModel.h"

@implementation StoreModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.goodsArray = [NSMutableArray new];
    }
    return self;
}

//- (void)setGoods:(NSMutableArray<GoodsModel *> *)goods {
//    _goods = goods;
//    NSMutableArray *tempArray = [NSMutableArray new];
//    for (NSDictionary *dic in goods) {
//        GoodsModel *model = [[GoodsModel alloc] init];
//        [model setValuesForKeysWithDictionary:dic];
//        [tempArray addObject:model];
//    }
//    self.goodsArray = [NSMutableArray arrayWithArray: tempArray];
//}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


@end

@implementation GoodsModel

@end
