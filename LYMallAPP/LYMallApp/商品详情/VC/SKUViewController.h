//
//  SKUViewController.h
//  LYMallApp
//
//  Created by gds on 2020/3/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum _SELECTType{
    SELECTPECELL = 0,
    SELECTPEADDBTN,
    SELECTPEBUYBTN
} SELECTType;

@interface SKUViewController : BaseViewController<QMUIModalPresentationContentViewControllerProtocol>
@property (nonatomic,strong)NSDictionary * dataDic;
@property (nonatomic,assign)SELECTType type;
/** 选择商品的数量  */
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *spec_sku_id;

@property (nonatomic, strong)NSDictionary * selectDic;

@property (nonatomic,assign)BOOL is_shrp;//是否是限时折扣商品

@end

NS_ASSUME_NONNULL_END
