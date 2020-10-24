//
//  EditUserNameVC.h
//  LYMallApp
//
//  Created by Mac on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditUserNameVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (weak, nonatomic) IBOutlet QMUIFillButton *sureButn;
@property (nonatomic,copy)void (^changeName)();

@end

NS_ASSUME_NONNULL_END
