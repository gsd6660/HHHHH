//
//  EditUserNameVC.m
//  LYMallApp
//
//  Created by Mac on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "EditUserNameVC.h"

@interface EditUserNameVC ()

@end

@implementation EditUserNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    
}

- (IBAction)sureButn:(QMUIFillButton *)sender {
    if (self.TF.text.length==0) {
        [QMUITips showError:@"昵称不能为空"];
        return;
    }
    [NetWorkConnection postURL:@"api/user/edit_user_info" param:@{@"type":@"1",@"content":self.TF.text} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            ShowHUD(@"修改成功");
            self.changeName();
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfor" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ShowErrorHUD(@"修改失败,请重试");
        }
        
    } fail:^(NSError *error) {
        
    }];
}


@end
