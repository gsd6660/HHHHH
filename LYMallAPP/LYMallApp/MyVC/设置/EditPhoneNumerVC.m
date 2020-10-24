//
//  EditPhoneNumerVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "EditPhoneNumerVC.h"

@interface EditPhoneNumerVC ()
@property (weak, nonatomic) IBOutlet UITextField *oldPhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *oldCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UIButton *oldCodeButn;

@property (weak, nonatomic) IBOutlet UIButton *codeButn;


@end

@implementation EditPhoneNumerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改手机号码";
   // 设置CGRectZero从导航栏下开始计算
         if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
             self.edgesForExtendedLayout = UIRectEdgeNone;
         }
         //必要的设置, 如果没有设置可能导致内容显示不正常
         self.automaticallyAdjustsScrollViewInsets = NO;
}





- (IBAction)sureButn:(QMUIFillButton *)sender {
    
    
    [NetWorkConnection postURL:@"api/user/invite_friends" param:nil success:^(id responseObject, BOOL success) {
        
    } fail:^(NSError *error) {
        
    }];
    
}


@end
