//
//  LXTaskDetalViewController.h
//  LYMallApp
//
//  Created by gds on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXTaskDetalViewController : BaseViewController

/// 加载内容
@property (nonatomic,copy)NSString *content;

@property (nonatomic,copy)NSString *baseURL;

/// 进度条颜色(默认：红色)
@property(nonatomic,strong)UIColor *progressTintColor;

@property(nonatomic, strong) NSString * orderID;

@end

NS_ASSUME_NONNULL_END
