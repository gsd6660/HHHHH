//
//  WebInfoViewController.h
//  Shengshi
//
//  Created by yibingding/王 on 17/3/3.
//  Copyright © 2017年 yibingding.com. All rights reserved.
//

#import "BaseViewController.h"

@interface WebInfoViewController : BaseViewController

/// 加载内容
@property (nonatomic,copy)NSString *content;

@property (nonatomic,copy)NSString *baseURL;

/// 进度条颜色(默认：红色)
@property(nonatomic,strong)UIColor *progressTintColor;


@end
