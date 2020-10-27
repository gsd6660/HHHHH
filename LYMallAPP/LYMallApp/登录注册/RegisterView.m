//
//  RegisterView.m
//  LYMallApp
//
//  Created by Mac on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "RegisterView.h"
#import "VerifiedVC.h"
#import "NibView.h"
#import "TabBarViewVC.h"
@interface RegisterView ()
{
    NSInteger i;//定义全局变量
}

@end


@implementation RegisterView

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
    self.backgroundColor = [UIColor whiteColor];
    
    self.phoneImageView = [[UIImageView alloc]init];
    self.phoneImageView.image = CCImage(@"jft_icon_telephone");
    self.phoneTF = [[QMUITextField alloc]init];
    self.phoneTF.placeholder = @"请输入您的手机号";
    self.phoneTF.font = FONTSIZE(15);
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;

    self.phoneTF.placeholderColor = kUIColorFromRGB(0x999999);
    
    self.lineLabel1 = [[UILabel alloc]init];
    self.lineLabel1.backgroundColor = kUIColorFromRGB(0xDCDCDC);
    
    self.codeImageView = [[UIImageView alloc]init];
    self.codeImageView.image = CCImage(@"jft_icon_verificationcode");
    
    self.codeTF = [[QMUITextField alloc]init];
    self.codeTF.placeholder = @"请输入验证码";
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.font = FONTSIZE(15);

    self.codeTF.placeholderColor = kUIColorFromRGB(0x999999);
    
    self.lineLabel21 = [[UILabel alloc]init];
    self.lineLabel21.backgroundColor = kUIColorFromRGB(0xDCDCDC);
    
    self.codeButn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.codeButn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.codeButn.titleLabel.font = FONTSIZE(15);
    [self.codeButn setTitleColor:kUIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.lineLabel2 = [[UILabel alloc]init];
    self.lineLabel2.backgroundColor = kUIColorFromRGB(0xDCDCDC);
    
    self.passImageView = [[UIImageView alloc]init];
    self.passImageView.image = CCImage(@"jft_icon_password");
   
    self.passTF = [[QMUITextField alloc]init];
    self.passTF.placeholder = @"请输入您的密码";
    self.passTF.placeholderColor = kUIColorFromRGB(0x999999);
   self.passTF.font = FONTSIZE(15);

    self.lineLabel3 = [[UILabel alloc]init];
    self.lineLabel3.backgroundColor = kUIColorFromRGB(0xDCDCDC);
    
    self.inviterImageView = [[UIImageView alloc]init];
     self.inviterImageView.image = CCImage(@"jft_icon_invitationcode");
    
     self.inviterTF = [[QMUITextField alloc]init];
     self.inviterTF.placeholder = @"请输入您的邀请码";
     self.inviterTF.placeholderColor = kUIColorFromRGB(0x999999);
     self.inviterTF.font = FONTSIZE(15);

     self.lineLabel4 = [[UILabel alloc]init];
     self.lineLabel4.backgroundColor = kUIColorFromRGB(0xDCDCDC);
    
    self.treatyButn = [UIButton buttonWithType:UIButtonTypeCustom];
//       [self.treatyButn setTitle:@" 用户隐私协议" forState:UIControlStateNormal];
    [self.treatyButn setImage:CCImage(@"yuankuang1") forState:UIControlStateNormal];
    self.treatyButn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.treatyButn.titleLabel.font = FONTSIZE(11);
    self.treatyButn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.treatyButn1 setTitle:@"用户隐私协议" forState:UIControlStateNormal];
    [self.treatyButn1 setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];


    self.treatyButn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.treatyButn1.titleLabel.font = FONTSIZE(11);
    
    self.registerButn = [[QMUIFillButton alloc]init];
    [self.registerButn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButn setTitleColor:kUIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    self.registerButn.fillColor = kUIColorFromRGB(0x3ACD7B);
    
    
    [self addSubview:self.phoneImageView];
    [self addSubview:self.phoneTF];
    [self addSubview:self.lineLabel1];
    [self addSubview:self.codeImageView];
    [self addSubview:self.codeTF];
    [self addSubview:self.lineLabel21];
    [self addSubview:self.lineLabel2];
    [self addSubview:self.codeButn];
    [self addSubview:self.passImageView];
    [self addSubview:self.passTF];
    [self addSubview:self.lineLabel3];
    [self addSubview:self.inviterImageView];
    [self addSubview:self.inviterTF];
    [self addSubview:self.lineLabel4];
    [self addSubview:self.registerButn];
    [self addSubview:self.treatyButn];
    [self addSubview:self.treatyButn1];

    
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
    
    
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(58);
           make.top.equalTo(self.lineLabel1.mas_bottom).offset(25);
           make.width.mas_equalTo(12.5);
           make.height.mas_equalTo(15.5);
       }];
       
       
       [self.lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(58);
           make.top.equalTo(self.codeTF.mas_bottom).offset(10);
           make.right.mas_equalTo(-58);
           make.height.mas_equalTo(0.5);
       }];
    
    [self.codeButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineLabel1.mas_bottom).offset(10);
        make.right.mas_equalTo(-58);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
    }];
    [self.lineLabel21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineLabel1.mas_bottom).offset(25);
        make.right.equalTo(self.codeButn.mas_left).offset(-13);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.codeImageView.mas_right).offset(14);
         make.top.equalTo(self.lineLabel1.mas_bottom).offset(22);
         make.right.equalTo(self.lineLabel21.mas_left).offset(10);
     }];
    
    
    
    [self.passImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(57.5);
           make.top.equalTo(self.lineLabel2.mas_bottom).offset(25);
           make.width.mas_equalTo(12.5);
           make.height.mas_equalTo(15.5);
       }];
       
   [self.passTF mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.passImageView.mas_right).offset(14);
          make.top.equalTo(self.lineLabel2.mas_bottom).offset(22);
          make.right.mas_equalTo(-58);
      }];
   
   [self.lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(58);
       make.top.equalTo(self.passTF.mas_bottom).offset(10);
       make.right.mas_equalTo(-58);
       make.height.mas_equalTo(0.5);
   }];
    
    
    [self.inviterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(57.5);
           make.top.equalTo(self.lineLabel3.mas_bottom).offset(25);
           make.width.mas_equalTo(12.5);
           make.height.mas_equalTo(15.5);
       }];
       
   [self.inviterTF mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.inviterImageView.mas_right).offset(14);
       make.top.equalTo(self.lineLabel3.mas_bottom).offset(22);
       make.right.mas_equalTo(-58);
      }];
   
   [self.lineLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(58);
       make.top.equalTo(self.inviterTF.mas_bottom).offset(10);
       make.right.mas_equalTo(-58);
       make.height.mas_equalTo(0.5);
   }];
    
    [self.treatyButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(58);
        make.top.equalTo(self.lineLabel4.mas_bottom).offset(15);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    [self.treatyButn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.treatyButn.mas_right).offset(1);
        make.top.equalTo(self.lineLabel4.mas_bottom).offset(15);
        make.width.mas_equalTo(128);
        make.height.mas_equalTo(20);
    }];
    
    
    [self.registerButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(66);
        make.top.equalTo(self.lineLabel4.mas_bottom).offset(85);
        make.right.mas_equalTo(-66);
        make.height.mas_equalTo(40.5);
    }];
    
    
   
    
    
    [self.registerButn addTarget:self action:@selector(registerButn:) forControlEvents:UIControlEventTouchUpInside];
    [self.codeButn addTarget:self action:@selector(codeButn:) forControlEvents:UIControlEventTouchUpInside];
    [self.treatyButn addTarget:self action:@selector(treatyButn:) forControlEvents:UIControlEventTouchUpInside];
    [self.treatyButn1 addTarget:self action:@selector(treatyButn1:) forControlEvents:UIControlEventTouchUpInside];

        [self.phoneTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        self.passTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inviterTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;

        
}

-(void)treatyButn:(UIButton *)butn{
    butn.selected =! butn.selected;
    if (butn.selected) {
        [self.treatyButn setImage:CCImage(@"yuankuang") forState:UIControlStateNormal];
    }else{
        [self.treatyButn setImage:CCImage(@"yuankuang1") forState:UIControlStateNormal];
    }
}
-(void)treatyButn1:(UIButton *)butn{
   
    [self CreatMySubscriptivePopView];
    
    
}

-(void)CreatMySubscriptivePopView{
    NibView *bgView = [NibView instance];
       bgView.layer.masksToBounds = YES;
       bgView.layer.cornerRadius = 10;
       
       // Nib形式请设置UIViewAutoresizingNone
       bgView.autoresizingMask = UIViewAutoresizingNone;
       QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
       
       modalViewController.contentView = bgView;
       modalViewController.onlyRespondsToKeyboardEventFromDescendantViews = YES;
       //强制绑定 不能退出
        modalViewController.dimmingView.userInteractionEnabled = NO;
       modalViewController.animationStyle = 1;
       [modalViewController showWithAnimated:YES completion:nil];
    MJWeakSelf;
       bgView.block = ^{
           [modalViewController hideWithAnimated:YES completion:nil];
           [weakSelf.treatyButn setImage:CCImage(@"yuankuang1") forState:UIControlStateNormal];

       };
       
    

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

-(void)registerButn:(UIButton *)butn{
        
    if ([self cheackStrISEmpty]) {
        [NetWorkConnection postURL:@"api/user/app_reg" param:@{@"phone":[self.phoneTF.text qmui_trimAllWhiteSpace],@"invite_code":self.inviterTF.text,@"code":self.codeTF.text,@"password":self.passTF.text} success:^(id responseObject, BOOL success) {
            if (responseSuccess) {
                ShowHUD(@"注册成功");
                [self login];
//                [[self viewController].navigationController dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                ShowErrorHUD(responseMessage);
            }
            
        } fail:^(NSError *error) {
            ShowErrorHUD(@"注册失败，请重试");
        }];
    }
        
}

-(void)login{
    
        [NetWorkConnection postURL:@"api/user/app_login" param:@{@"phone":[self.phoneTF.text qmui_trimAllWhiteSpace],@"type":@"1",@"password":self.passTF.text} success:^(id responseObject, BOOL success) {
            if (responseSuccess) {
               
                [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"token"] forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:nil];

//                if ([responseObject[@"data"][@"is_need_authen"] intValue] ==1) {
//                    VerifiedVC * vc = [[VerifiedVC alloc]init];
//                    vc.type = @"0";
//                    vc.block = ^{
//                    };
//                    [[[self viewController] navigationController] pushViewController:vc animated:YES];
                
                
//
//
//                }else{
                    TabBarViewVC *tabBarViewController = [[TabBarViewVC alloc] init];
                    self.window.rootViewController = tabBarViewController;
                    self.window.backgroundColor = [UIColor whiteColor];
                    
//
//                }
                
         
            }else{
                ShowErrorHUD(responseMessage);
            }
            
        } fail:^(NSError *error) {
            
        }];
}


-(BOOL)cheackStrISEmpty{
    if ( [[self.phoneTF.text qmui_trimAllWhiteSpace]length] == 0) {
        ShowErrorHUD(@"请输入手机号");
        return NO;
    }if ([[self.phoneTF.text qmui_trimAllWhiteSpace] length] != 11) {
        ShowErrorHUD(@"请输入正确的手机号");
        return NO;
    }
    if (self.codeTF.text.length == 0) {
        ShowErrorHUD(@"请输入验证码");
        return NO;
    }
    if (self.passTF.text.length == 0) {
        ShowErrorHUD(@"请输入密码");
        return NO;
    }
    if (self.inviterTF.text.length == 0) {
        ShowErrorHUD(@"请输入邀请码");

        return NO;
    }
    return YES;
    
}

-(void)codeButn:(UIButton *)butn{
    if ([[self.phoneTF.text qmui_trimAllWhiteSpace]length] == 0) {
           [QMUITips showError:@"请输入手机号"];
           return;
       }
       if ([[self.phoneTF.text qmui_trimAllWhiteSpace]length] < 11) {
           [QMUITips showError:@"手机号格式不正确"];
           return;
       }
       if (![self.phoneTF.text hasPrefix:@"1"]) {
           [QMUITips showError:@"手机号格式不正确"];
           return;
       }
       NSLog(@"注册号码=====%@",[self.phoneTF.text qmui_trimAllWhiteSpace]);
       [NetWorkConnection postURL:@"api/user/sendSmsCode" param:@{@"mobile":[self.phoneTF.text qmui_trimAllWhiteSpace],@"type":@"register"} success:^(id responseObject, BOOL success) {
           if (responseDataSuccess) {
               ShowHUD(responseMessage);
               [self getcode];
           }else{
               [QMUITips showInfo:responseMessage];
           }

       } fail:^(NSError *error) {
       }];
    
}

-(void)getcode{
    self.codeButn.userInteractionEnabled = NO;

    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeButn setTitle:@"点击获取" forState:UIControlStateNormal];
                self.codeButn.userInteractionEnabled = YES;
                
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.codeButn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //To do
                [UIView commitAnimations];
                self.codeButn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



@end
