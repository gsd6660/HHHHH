//
//  LoginView.m
//  LYMallApp
//
//  Created by Mac on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LoginView.h"
#import "ForgotPassWVC.h"
#import "VerifiedVC.h"
#import "TabBarViewVC.h"
@interface LoginView ()<QMUITextFieldDelegate>
{
    NSInteger i;//定义全局变量
}

@end

@implementation LoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.type = @"1";
    self.backgroundColor = [UIColor whiteColor];
    self.phoneImageView = [[UIImageView alloc]init];
    self.phoneImageView.image = CCImage(@"jft_icon_telephone");
    self.phoneTF = [[QMUITextField alloc]init];
    self.phoneTF.placeholder = @"请输入手机号";
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTF.font = FONTSIZE(15);
    self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;

//    self.phoneTF.backgroundColor = [UIColor redColor];
    self.phoneTF.placeholderColor = kUIColorFromRGB(0x999999);
    
    self.lineLabel1 = [[UILabel alloc]init];
    self.lineLabel1.backgroundColor = kUIColorFromRGB(0xDCDCDC);
  
    self.lineLabel2 = [[UILabel alloc]init];
    self.lineLabel2.backgroundColor = kUIColorFromRGB(0xDCDCDC);
    
    self.passImageView = [[UIImageView alloc]init];
    self.passImageView.image = CCImage(@"jft_icon_password");
   
    self.passTF = [[QMUITextField alloc]init];
    self.passTF.placeholder = @"请输入密码";
    self.passTF.placeholderColor = kUIColorFromRGB(0x999999);
    self.passTF.font = FONTSIZE(15);

    
    self.lineLabel3 = [[UILabel alloc]init];
    self.lineLabel3.backgroundColor = kUIColorFromRGB(0xDCDCDC);
    
    self.getCodeButn = [[QMUIButton alloc]init];
    [self.getCodeButn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.getCodeButn.titleLabel.font = FONTSIZE(15);
    [self.getCodeButn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.getCodeButn addTarget:self action:@selector(getCodeButn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.codeButn = [[QMUIButton alloc]init];
     [self.codeButn setTitle:@"使用验证码登录" forState:UIControlStateNormal];
     self.codeButn.titleLabel.font = FONTSIZE(12);
     [self.codeButn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [self.codeButn addTarget:self action:@selector(codeButn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.forgetButn = [[QMUIButton alloc]init];
     [self.forgetButn setTitle:@"忘记密码？" forState:UIControlStateNormal];
     self.forgetButn.titleLabel.font = FONTSIZE(12);
     [self.forgetButn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
    
    self.loginButn = [[QMUIFillButton alloc]init];
     [self.loginButn setTitle:@"登录" forState:UIControlStateNormal];
     self.loginButn.titleLabel.font = FONTSIZE(18);
     [self.loginButn setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    self.loginButn.fillColor = kUIColorFromRGB(0x3ACD7B);
    
    self.registerButn = [[QMUIButton alloc]init];
     [self.registerButn setTitle:@"还没有账号？注册" forState:UIControlStateNormal];
     self.registerButn.titleLabel.font = FONTSIZE(15);
     [self.registerButn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
    
    [self addSubview:self.phoneImageView];
    [self addSubview:self.phoneTF];
    [self addSubview:self.lineLabel1];
    [self addSubview:self.passTF];
    [self addSubview:self.lineLabel2];
    [self addSubview:self.lineLabel3];
    [self addSubview:self.getCodeButn];
    [self addSubview:self.codeButn];
    [self addSubview:self.passImageView];
    [self addSubview:self.forgetButn];
    [self addSubview:self.loginButn];
    [self addSubview:self.registerButn];

    self.getCodeButn.hidden = YES;
    self.lineLabel3.hidden = YES;

    
    [self.phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(57.5);
        make.top.mas_equalTo(29);
        make.width.mas_equalTo(12.5);
        make.height.mas_equalTo(15.5);
    }];
    
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.phoneImageView.mas_right).offset(14);
           make.top.mas_equalTo(27);
           make.right.mas_equalTo(-58);
       }];
    
    [self.lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(58);
        make.top.equalTo(self.phoneTF.mas_bottom).offset(10);
        make.right.mas_equalTo(-58);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.passImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(57.5);
        make.top.equalTo(self.lineLabel1.mas_bottom).offset(25);
        make.width.mas_equalTo(12.5);
        make.height.mas_equalTo(15.5);
    }];
    [self.lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(58);
          make.top.equalTo(self.passImageView.mas_bottom).offset(10);
          make.right.mas_equalTo(-58);
          make.height.mas_equalTo(0.5);
      }];
    
    [self.getCodeButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineLabel1.mas_bottom).offset(12);
        make.right.mas_equalTo(-58);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
    }];
    [self.lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineLabel1.mas_bottom).offset(25);
        make.right.equalTo(self.getCodeButn.mas_left).offset(-13);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.passTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passImageView.mas_right).offset(14);
        make.top.equalTo(self.lineLabel1.mas_bottom).offset(22);
        make.right.equalTo(self.lineLabel3.mas_left).offset(-10);
    }];
    
    
     [self.codeButn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(56);
         make.top.equalTo(self.lineLabel2.mas_bottom).offset(16);
         make.height.mas_equalTo(20);

     }];
//
    [self.forgetButn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-64);
            make.top.equalTo(self.lineLabel2.mas_bottom).offset(16);
            make.height.mas_equalTo(20);
        
        }];
    
       
    [self.loginButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(66);
        make.top.equalTo(self.forgetButn.mas_bottom).offset(36);
        make.right.mas_equalTo(-66);
        make.height.mas_equalTo(40.5);
    }];

    [self.registerButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(66);
        make.bottom.equalTo(self.mas_bottom).offset(-40);
        make.right.mas_equalTo(-66);
        make.height.mas_equalTo(40.5);
    }];
    
    [self.loginButn addTarget:self action:@selector(loginButn:) forControlEvents:UIControlEventTouchUpInside];
      [self.getCodeButn addTarget:self action:@selector(getCodeButn:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetButn addTarget:self action:@selector(forgetButn:) forControlEvents:UIControlEventTouchUpInside];

    [self.phoneTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
}

- (void)textFieldChanged:(UITextField*)textField{

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
-(void)forgetButn:(UIButton *)butn{
    ForgotPassWVC * vc = [[ForgotPassWVC alloc]init];
    [[[self viewController] navigationController] pushViewController:vc animated:YES];
    
}

-(void)codeButn:(UIButton *)butn{
    butn.selected = !butn.selected;
    if (butn.selected) {
        self.forgetButn.hidden = YES;
        self.getCodeButn.hidden = NO;
        self.lineLabel3.hidden = NO;
        self.passTF.placeholder = @"请输入验证码";
        self.passTF.keyboardType = UIKeyboardTypeNumberPad;
        [butn setTitle:@"使用密码登录" forState:UIControlStateNormal];
        self.passImageView.image = CCImage(@"jft_icon_verificationcode");
        self.type = @"2";
    }else{
        [butn setTitle:@"使用验证码登录" forState:UIControlStateNormal];
        self.forgetButn.hidden = NO;
        self.passImageView.image = CCImage(@"jft_icon_password");
        self.getCodeButn.hidden = YES;
        self.lineLabel3.hidden = YES;
        self.passTF.placeholder = @"请输入密码";
        self.type = @"1";
        self.passTF.keyboardType = UIKeyboardTypeDefault;

    }
    
    
}
-(void)loginButn:(UIButton *)butn{
    
    
    if (([[self.phoneTF.text qmui_trimAllWhiteSpace] length] > 0 && [[self.phoneTF.text qmui_trimAllWhiteSpace] length] ==11)&& self.passTF.text.length > 0) {
        [NetWorkConnection postURL:@"api/user/app_login" param:@{@"phone":[self.phoneTF.text qmui_trimAllWhiteSpace],@"type":self.type,@"code":[self.type intValue] == 2 ? self.passTF.text :@"",@"password":[self.type intValue] == 1 ? self.passTF.text :@""} success:^(id responseObject, BOOL success) {
            if (responseSuccess) {
               
                [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"token"] forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] synchronize];
               [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:nil];

                ShowHUD(@"登录成功");
//                if ([responseObject[@"data"][@"is_need_authen"] intValue] ==1) {
//                    VerifiedVC * vc = [[VerifiedVC alloc]init];
//                    vc.type = @"0";
//
//                    vc.block = ^{
//                        [self leftClick];
//
//                    };
//                    [[[self viewController] navigationController] pushViewController:vc animated:YES];
//                }else{
                    [self leftClick];

//                }
                
                
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
    TabBarViewVC *tabBarViewController = [[TabBarViewVC alloc] init];
    self.window.rootViewController = tabBarViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    
//   [[self viewController].navigationController dismissViewControllerAnimated:YES completion:nil];
}


-(void)getCodeButn:(UIButton *)butn{
    if ([[self.phoneTF.text qmui_trimAllWhiteSpace] length] == 0) {
           [QMUITips showError:@"请输入手机号"];
           return;
       }
       if ([[self.phoneTF.text qmui_trimAllWhiteSpace] length] < 11) {
           [QMUITips showError:@"手机号格式不正确"];
           return;
       }
       if (![self.phoneTF.text hasPrefix:@"1"]) {
           [QMUITips showError:@"手机号格式不正确"];
           return;
       }
       
       NSLog(@"注册号码=====%@",[self.phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""]);
       [NetWorkConnection postURL:@"api/user/sendSmsCode" param:@{@"mobile":[self.phoneTF.text qmui_trimAllWhiteSpace],@"type":@"login"} success:^(id responseObject, BOOL success) {
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
                [self.getCodeButn setTitle:@"点击获取" forState:UIControlStateNormal];
                self.getCodeButn.userInteractionEnabled = YES;
                
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.getCodeButn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //To do
                [UIView commitAnimations];
                self.getCodeButn.userInteractionEnabled = NO;
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
