//
//  LoginVC.m
//  CDZAPP
//
//  Created by Mac on 2019/2/23.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "ForgotPassWVC.h"
#import "CCNavigationVC.h"
#import <AdSupport/AdSupport.h>

#import "RegisterView.h"
#import "LoginView.h"
//#import <WXApi.h>
//#import "WeiXinBandPhoneVC.h"
@interface LoginVC ()<QMUITextFieldDelegate>
{
    NSInteger i;//定义全局变量
}
@property (strong, nonatomic)  UIButton *loginButn;
@property (strong, nonatomic)  UIButton *registerButn;
@property (strong, nonatomic)  UITextField *phoneTF;
@property (strong, nonatomic)  UITextField *passTF;
@property (strong, nonatomic)  LoginView * login;


@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    LoginView * login = [[LoginView alloc]initWithFrame:CGRectMake(0, 80 , ScreenWidth, ScreenHeight)];
    self.login = login;
    [self.view addSubview:login];
    [self.login.loginButn addTarget:self action:@selector(loginButn:) forControlEvents:UIControlEventTouchUpInside];
    [self.login.getCodeButn addTarget:self action:@selector(getCodeButn:) forControlEvents:UIControlEventTouchUpInside];

}


-(void)loginButn:(UIButton *)butn{
    
    
    if ((self.login.phoneTF.text.length > 0 && self.login.phoneTF.text.length == 11)&& self.login.passTF.text.length > 0) {
        [NetWorkConnection postURL:@"api/user/app_login" param:@{@"phone":self.login.phoneTF.text,@"type":self.login.type,@"code":[self.login.type intValue] == 2 ? self.login.passTF.text :@"",@"password":[self.login.type intValue] == 1 ? self.login.passTF.text :@""} success:^(id responseObject, BOOL success) {
            if (responseSuccess) {
               

               [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"token"] forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:nil];
                               NSLog(@"发送通知的线程为%@", [NSThread currentThread]);
                ShowHUD(@"登录成功");
//                [self leftClick];
            }else{
                ShowErrorHUD(responseMessage);
            }
            
        } fail:^(NSError *error) {
            
        }];
    }else{
        ShowErrorHUD(@"输入框不能为空");

    }
}

- (void)leftClick{
   [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


-(void)getCodeButn:(UIButton *)butn{
    if (self.login.phoneTF.text.length == 0) {
           [QMUITips showError:@"请输入手机号"];
           return;
       }
       if (self.login.phoneTF.text.length < 11) {
           [QMUITips showError:@"手机号格式不正确"];
           return;
       }
       if (![self.login.phoneTF.text hasPrefix:@"1"]) {
           [QMUITips showError:@"手机号格式不正确"];
           return;
       }
       
       NSLog(@"注册号码=====%@",[self.login.phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""]);
       [NetWorkConnection postURL:@"api/user/sendSmsCode" param:@{@"mobile":[self.login.phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""],@"type":@"login"} success:^(id responseObject, BOOL success) {
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
                [self.login.getCodeButn setTitle:@"点击获取" forState:UIControlStateNormal];
                self.login.getCodeButn.userInteractionEnabled = YES;
                
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.login.getCodeButn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //To do
                [UIView commitAnimations];
                self.login.getCodeButn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

-(void)textFieldDidEditing:(UITextField *)textField{
    if (textField == self.phoneTF) {
        if (textField.text.length > i) {
            if (textField.text.length == 4 || textField.text.length == 9 ) {//输入
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }if (textField.text.length >= 13 ) {//输入完成
                textField.text = [textField.text substringToIndex:13];
                [textField resignFirstResponder];
            }
            i = textField.text.length;

        }else if (textField.text.length < i){//删除
            if (textField.text.length == 4 || textField.text.length == 9) {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            i = textField.text.length;
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{// 只要设置为密文，再次输入就是会清空原来的
    //得到输入框的内容
    NSString * textfieldContent = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.passTF && textField.isSecureTextEntry ) {
        textField.text = textfieldContent;
        return NO;
    }
    return YES;
}

@end
