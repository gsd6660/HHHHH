//
//  PaySuccessVC.h
//  LYMallApp
//
//  Created by Mac on 2020/4/24.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PaySuccessVC : BaseViewController
@property (weak, nonatomic) IBOutlet QMUIFillButton *lookButn;
@property (weak, nonatomic) IBOutlet QMUIGhostButton *backHomeButn;
@property (nonatomic,strong) NSString * order_id;
@end

NS_ASSUME_NONNULL_END
