//
//  LXIncomeListVC.h
//  LYMallApp
//
//  Created by guxiang on 2020/11/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"



NS_ASSUME_NONNULL_BEGIN

enum{
    LXSilver,
    LXGold
};
typedef NSInteger PushType;

@interface LXIncomeListVC : BaseViewController

@property(nonatomic, assign)PushType  type;

@end

NS_ASSUME_NONNULL_END
