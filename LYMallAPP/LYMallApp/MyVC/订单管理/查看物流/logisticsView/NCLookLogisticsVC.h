//
//  NCLookLogisticsVC.h
//  ElleShop
//
//  Created by xiuchanghui on 2017/7/14.
//  Copyright © 2017年 BeautyFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface NCLookLogisticsVC : BaseViewController
@property (nonatomic, strong) NSString * logisticsNumber;
@property (nonatomic, strong) NSString * headImageUrl;

@property (nonatomic,strong)NSString * order_id;

@property (nonatomic,assign)NSInteger is_refund;
@property (nonatomic,strong)NSString * typeString;

@end
