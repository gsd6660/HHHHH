//
//  RegisterVC.m
//  CDZAPP
//
//  Created by Mac on 2019/2/23.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterView.h"
@interface RegisterVC ()
@property (strong, nonatomic)RegisterView *registerView;



@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.registerView = [[RegisterView alloc]initWithFrame:CGRectMake(0, 80 , ScreenWidth, ScreenHeight )];
    [self.view addSubview:self.registerView];
    
       [self.registerView.registerButn addTarget:self action:@selector(registerButn:) forControlEvents:UIControlEventTouchUpInside];
        
    [self.registerView.codeButn addTarget:self action:@selector(codeButn:) forControlEvents:UIControlEventTouchUpInside];

    
 }


-(void)registerButn:(UIButton *)butn{
        
    if ([self cheackStrISEmpty]) {
        [NetWorkConnection postURL:@"api/user/app_reg" param:@{@"phone":self.registerView.phoneTF.text,@"invite_code":self.registerView.inviterTF.text,@"code":self.registerView.codeTF.text,@"password":self.registerView.passTF.text} success:^(id responseObject, BOOL success) {
            if (responseSuccess) {
                ShowHUD(@"注册成功");
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }else{
                ShowErrorHUD(responseMessage);
            }
            
        } fail:^(NSError *error) {
            ShowErrorHUD(@"注册失败，请重试");
        }];
    }
        
}

-(BOOL)cheackStrISEmpty{
    if (self.registerView.phoneTF.text.length == 0) {
        ShowErrorHUD(@"请输入手机号");
        return NO;
    }
    if (self.registerView.codeTF.text.length == 0) {
        ShowErrorHUD(@"请输入验证码");
        return NO;
    }
    if (self.registerView.passTF.text.length == 0) {
        ShowErrorHUD(@"请输入密码");
        return NO;
    }
//    if (self.registerView.inviterTF.text.length == 0) {
//
//        return NO;
//    }
    return YES;
    
}

-(void)codeButn:(UIButton *)butn{
    if (self.registerView.phoneTF.text.length == 0) {
           [QMUITips showError:@"请输入手机号"];
           return;
       }
       if (self.registerView.phoneTF.text.length < 11) {
           [QMUITips showError:@"手机号格式不正确"];
           return;
       }
       if (![self.registerView.phoneTF.text hasPrefix:@"1"]) {
           [QMUITips showError:@"手机号格式不正确"];
           return;
       }
       
       NSLog(@"注册号码=====%@",[self.registerView.phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""]);
       [NetWorkConnection postURL:@"api/user/sendSmsCode" param:@{@"mobile":[self.registerView.phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""],@"type":@"register"} success:^(id responseObject, BOOL success) {
           if (responseDataSuccess) {
               [self getcode];
           }else{
               [QMUITips showInfo:responseObject[@"message"]];
           }
       } fail:^(NSError *error) {
           
       }];
    
}

-(void)getcode{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.registerView.codeButn setTitle:@"点击获取" forState:UIControlStateNormal];
                self.registerView.codeButn.userInteractionEnabled = YES;
                
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.registerView.codeButn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //To do
                [UIView commitAnimations];
                self.registerView.codeButn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
