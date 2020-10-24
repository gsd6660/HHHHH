//
//  ForgotPassWVC.m
//  FuTaiAPP
//
//  Created by Mac on 2019/1/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "ForgotPassWVC.h"
#import "LoginVC.h"
@interface ForgotPassWVC ()
@property (weak, nonatomic) IBOutlet QMUITextField *phoneTF;
@property (weak, nonatomic) IBOutlet QMUITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBUtn;
@property (weak, nonatomic) IBOutlet QMUITextField *passTF;
@property (weak, nonatomic) IBOutlet QMUITextField *passRTF;

@end

@implementation ForgotPassWVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor whiteColor];
    self.phoneTF.maximumTextLength = 11;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_back_black_HY"] style:UIBarButtonItemStyleDone target:self action:@selector(backVC)];
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

-(void)backVC{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCode:(UIButton *)sender {
    if (self.phoneTF.text.length == 0) {
        ShowHUD(@"请输入手机号");
        return;
    }
    if (self.phoneTF.text.length < 11) {
        ShowHUD(@"手机号格式不正确");
        return;
    }
    
    if (![self.phoneTF.text hasPrefix:@"1"]) {
        ShowHUD(@"手机号格式不正确");
        return;
    }
    
    MJWeakSelf;
    
    [NetWorkConnection postURL:@"api/user/sendSmsCode" param:@{@"mobile":weakSelf.phoneTF.text,@"type":@"forget"} success:^(id responseObject, BOOL success) {
        if(responseSuccess){
            NSLog(@"获取短信验证码====%@",responseJSONString);
            [weakSelf getcode];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
}


- (IBAction)sureButn:(UIButton *)sender {
    if (self.phoneTF.text.length == 0) {
        ShowHUD(@"请输入手机号");
        return;
    }
    if (self.phoneTF.text.length < 11) {
        ShowHUD(@"手机号格式不正确");
        return;
    }
    if (![self.phoneTF.text hasPrefix:@"1"]) {
        ShowHUD(@"手机号格式不正确");
        return;
    }
    
    if (self.codeTF.text.length == 0) {
        ShowHUD(@"请输入验证码");
        return;
    }
    if (self.passTF.text.length == 0) {
        ShowHUD(@"请输入新密码");
        return;
    }
    if (self.passTF.text.length < 6) {
        ShowHUD(@"密码不能低于6位");
        return;
    }
    if (self.passRTF.text.length == 0) {
        ShowHUD(@"请再次输入新密码");
        return;
    }
    if (![self.passTF.text isEqualToString:self.passRTF.text]) {
        ShowHUD(@"两次密码不一致");
        return;
    }
    MJWeakSelf;
    [NetWorkConnection postURL:@"api/user/forget" param:@{@"phone":weakSelf.phoneTF.text,@"password":self.passTF.text,@"code":self.codeTF.text} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            [QMUITips showSucceed:@"设置成功"];
            if (self.navigationController.viewControllers.count > 0) {
                [self.navigationController popToRootViewControllerAnimated:YES];
                [self dismissViewControllerAnimated:NO completion:^{
                }];

            }else{
                [self dismissViewControllerAnimated:NO completion:^{
                }];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                LoginVC *vc = [[LoginVC alloc]init];
                vc.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:vc animated:YES completion:nil];
            });
            
           
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
    }];
}

-(void)getcode{
    __block int timeout= 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeBUtn setTitle:@"点击获取" forState:UIControlStateNormal];
                self.codeBUtn.userInteractionEnabled = YES;
                
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.codeBUtn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                //To do
                [UIView commitAnimations];
                self.codeBUtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
