//
//  AddBankCardVC.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/2.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class BankCardLisModel;
typedef void(^refreshDataBlock)(void);
@interface AddBankCardVC : BaseViewController
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)BankCardLisModel * model;
@property(nonatomic,copy)refreshDataBlock block;

@end

NS_ASSUME_NONNULL_END
