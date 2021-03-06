//
//  LXSheqingDailiViewController.h
//  LYMallApp
//
//  Created by guxiang on 2020/11/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXSheqingDailiViewController : BaseViewController
/// 加载内容
@property (nonatomic,copy)NSString *content;

@property (nonatomic,copy)NSString *baseURL;

/// 进度条颜色(默认：红色)
@property(nonatomic,strong)UIColor *progressTintColor;

@end

NS_ASSUME_NONNULL_END
