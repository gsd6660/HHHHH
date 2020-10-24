//
//  LoginRegisterVC.m
//  LYMallApp
//
//  Created by Mac on 2020/3/31.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LoginRegisterVC.h"
#import "LoginVC.h"
#import "RegisterVC.h"
#import "LoginView.h"
#import "RegisterView.h"
        
@interface LoginRegisterVC ()
@property(nonatomic,strong)LoginView *loginView;
@property(nonatomic,strong)RegisterView *registerView;
@property(nonatomic,strong)UIButton *registerBtn;

@end

@implementation LoginRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(41, 105, 60, 28);
    loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:kUIColorFromRGB(0xCDCDCD) forState:UIControlStateSelected];
    [loginBtn setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [loginBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        self.loginView.hidden = NO;
        self.registerView.hidden = YES;
    [self.registerBtn setTitleColor:kUIColorFromRGB(0xCDCDCD) forState:UIControlStateNormal];
         [sender setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    }];
    [self.view addSubview:loginBtn];
    
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(loginBtn.right + 26, 105, 60, 28);
    registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:kUIColorFromRGB(0xCDCDCD) forState:UIControlStateNormal];
    
    [registerBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        self.registerView.hidden = NO;
        self.loginView.hidden = YES;
        [loginBtn setTitleColor:kUIColorFromRGB(0xCDCDCD) forState:UIControlStateNormal];
        [sender setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    }];
    self.registerBtn = registerBtn;
    [self.view addSubview:registerBtn];
    
    
    self.loginView = [[LoginView alloc]initWithFrame:CGRectMake(0, registerBtn.bottom + 80, ScreenWidth, ScreenHeight)];
    [self.view addSubview:self.loginView];
    self.registerView = [[RegisterView alloc]initWithFrame:CGRectMake(0, registerBtn.bottom + 80, ScreenWidth, ScreenHeight)];
    self.registerView.hidden = YES;
    [self.view addSubview:self.registerView];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem qmui_backItemWithTarget:self action:@selector(back:)];
    
}

-(void)back:(UIBarButtonItem *)butn{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
