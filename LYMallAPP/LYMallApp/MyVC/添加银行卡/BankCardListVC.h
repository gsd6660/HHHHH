//
//  BankCardListVC.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/3.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^refreshDataBlock)(void);
@interface BankCardListVC : BaseViewController
@property(nonatomic,copy)refreshDataBlock block;
@end

NS_ASSUME_NONNULL_END
