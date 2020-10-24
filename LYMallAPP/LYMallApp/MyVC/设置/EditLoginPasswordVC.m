//
//  EditLoginPasswordVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "EditLoginPasswordVC.h"

@interface EditLoginPasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *originTF;
@property (weak, nonatomic) IBOutlet UITextField *nTF;
@property (weak, nonatomic) IBOutlet UITextField *sureTF;

@end

@implementation EditLoginPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改登录密码";
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (IBAction)sureButn:(QMUIFillButton *)sender {
    if (self.originTF.text.length < 6) {
        if (self.originTF.text == 0) {
            ShowErrorHUD(self.originTF.placeholder);
        }else{
            ShowErrorHUD(@"密码长度不能低于6位");
        }
        return;
    }
    if (self.nTF.text.length < 6) {
        if (self.nTF.text.length == 0) {
            ShowErrorHUD(self.nTF.placeholder);
        }else{
            ShowErrorHUD(@"新密码长度不能低于6位");
        }
        return;
    }
    if (self.sureTF.text.length < 6) {
        if (self.sureTF.text.length == 0) {
            ShowErrorHUD(self.sureTF.placeholder);
        }else{
            ShowErrorHUD(@"新密码长度不能低于6位");
        }
        return;
    }
    if (![self.sureTF.text isEqualToString:self.nTF.text]) {
           ShowErrorHUD(@"新密码两次输入不一致");
        return;
    }
    
    
    [NetWorkConnection postURL:@"api/user/changePassword" param:@{@"old_password":self.originTF.text,@"new_password":self.nTF.text} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            ShowHUD(@"修改成功");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
