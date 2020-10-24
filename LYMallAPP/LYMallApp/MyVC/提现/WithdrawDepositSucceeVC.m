//
//  WithdrawDepositSucceeVC.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/1.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "WithdrawDepositSucceeVC.h"

@interface WithdrawDepositSucceeVC ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation WithdrawDepositSucceeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现结果";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
    self.moneyLable.text = [NSString stringWithFormat:@"成功提交系统审核后至%@",self.payType];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LOTAnimationView *animation = [LOTAnimationView animationNamed:@"17775-success"];
        animation.frame = CGRectMake(0, 0, 80, 80);
        animation.loopAnimation = NO;
        animation.contentMode  = UIViewContentModeScaleAspectFit;
        [animation play];
        [animation playWithCompletion:^(BOOL animationFinished) {
            // Do Something
        }];
        [self.bgView addSubview:animation];
    });
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem qmui_backItemWithTarget:self action:@selector(rightItemClick)];
    
}

- (void)rightItemClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
