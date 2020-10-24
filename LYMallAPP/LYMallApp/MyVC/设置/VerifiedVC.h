//
//  VerifiedVC.h
//  LYMallApp
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^refreshDataBlock)(void);
@interface VerifiedVC : BaseViewController
@property(nonatomic,copy)refreshDataBlock block;
@property(nonatomic,strong)NSString *type;

@end

NS_ASSUME_NONNULL_END
