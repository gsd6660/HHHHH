//
//  LXHZViewController.m
//  LYMallApp
//
//  Created by guxiang on 2020/11/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXHZViewController.h"

@interface LXHZViewController ()

@property (weak, nonatomic) IBOutlet UIView *V1;
@property (weak, nonatomic) IBOutlet UIView *V2;

@property (weak, nonatomic) IBOutlet UIView *V3;


@property (weak, nonatomic) IBOutlet UITextField *TF1;

@property (weak, nonatomic) IBOutlet UITextField *TF2;
@property (weak, nonatomic) IBOutlet UITextField *TF3;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation LXHZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YBDViewBorderRadius(_V1, 5);
    YBDViewBorderRadius(_V2, 5);
    YBDViewBorderRadius(_V3, 5);
    YBDViewBorderRadius(_commitBtn, 5);
    self.title = @"合作";
}


- (IBAction)commitClick:(id)sender {
    
    if (_TF1.text.length == 0) {
        [QMUITips showError:@"请输入意向"];
        return;
    }

    if (_TF2.text.length == 0) {
        [QMUITips showError:@"请输入手机号"];
        return;
    }
   
    if (_TF3.text.length == 0) {
        [QMUITips showError:@"请输入邮箱"];
        return;
    }
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [QMUITips showSucceed:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}

 

@end
