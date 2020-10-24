//
//  MallVC.h
//  LYMallApp
//
//  Created by Mac on 2020/3/10.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MallVC : BaseViewController
@property(nonatomic,strong)NSString * category_id;
@property(nonatomic,strong)NSString * filter_type;
@end

NS_ASSUME_NONNULL_END
