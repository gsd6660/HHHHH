//
//  NibView.h
//  LEEAlertDemo
//
//  Created by 李响 on 2018/9/20.
//  Copyright © 2018年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NibView : UIView

typedef void(^AgreeBlock)(void);

+ (instancetype)instance;
@property(nonatomic,copy)AgreeBlock block;

@end

NS_ASSUME_NONNULL_END
