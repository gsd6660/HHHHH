//
//  VerifiedVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "VerifiedVC.h"

@interface VerifiedVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *idCardTF;
@property (weak, nonatomic) IBOutlet UITextField *bankNameTF;
@property (weak, nonatomic) IBOutlet UITextField *cardNumTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong)NSMutableArray * bankList;
@property (weak, nonatomic) IBOutlet UILabel *desLable;
@property (weak, nonatomic) IBOutlet QMUIFillButton *commitButn;

@end

@implementation VerifiedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    [self getBankList];
    [self getData];
    self.desLable.adjustsFontSizeToFitWidth = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    [self.bgView addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem qmui_backItemWithTarget:self action:@selector(leftButn:)];
}


-(void)getData{
    [NetWorkConnection postURL:@"api/user/authen_info" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"详情===%@",responseJSONString);
        if (responseSuccess) {
            NSDictionary *dic = responseObject[@"data"];
            if ([dic[@"authen_phone"]length] > 1) {
                self.nameTF.text = dic[@"authen_realname"];
                self.idCardTF.text = dic[@"authen_idcard"];
                self.bankNameTF.text = dic[@"authen_bankcard_type"];
                self.cardNumTF.text = dic[@"authen_bankcard"];
                self.phoneTF.text = dic[@"authen_phone"];
                self.nameTF.userInteractionEnabled = NO;
                self.idCardTF.userInteractionEnabled = NO;
                self.bankNameTF.userInteractionEnabled = NO;
                self.cardNumTF.userInteractionEnabled = NO;
                self.commitButn.userInteractionEnabled = NO;
                self.phoneTF.userInteractionEnabled = NO;
                self.bgView.userInteractionEnabled = NO;
            }
        }
    } fail:^(NSError *error) {
        
    }];
}


-(void)leftButn:(UIBarButtonItem *)butn{
    if ([self.type intValue] == 0) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"token"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)tap:(UITapGestureRecognizer *)tap{
//    [[UIApplication sharedApplication].keyWindow ]
    MJWeakSelf;
    [BRStringPickerView showStringPickerWithTitle:@"选择银行卡" dataSource:self.bankList defaultSelValue:nil resultBlock:^(id selectValue) {
                   NSLog(@"%@",selectValue);
                   weakSelf.bankNameTF.text = selectValue;
               }];
}


- (IBAction)commitButn:(UIButton *)sender {
    if ([[self.nameTF.text qmui_trimAllWhiteSpace] length] == 0) {
        ShowErrorHUD(@"请输入您的真实姓名");
        return;
    }
    if ([[self.idCardTF.text qmui_trimAllWhiteSpace] length] == 0) {
        ShowErrorHUD(@"请输入您的身份证号");
        return;
    }if ([[self.bankNameTF.text qmui_trimAllWhiteSpace] length] == 0) {
        ShowErrorHUD(@"请选择银行");
        return;
    }if ([[self.cardNumTF.text qmui_trimAllWhiteSpace] length] == 0) {
        ShowErrorHUD(@"请输入银行卡号");
        return;
    }if ([[self.phoneTF.text qmui_trimAllWhiteSpace] length] == 0) {
        ShowErrorHUD(@"请输入预留手机号");
        return;
    }
    
    [QMUITips showLoading:@"提交中" inView:self.view];
    
    [NetWorkConnection postURL:@"api/user/user_authentication" param:@{@"authen_realname":self.nameTF.text,@"authen_idcard":self.idCardTF.text,@"authen_bankcard_type":self.bankNameTF.text,@"authen_phone":self.phoneTF.text,@"authen_bankcard":self.cardNumTF.text} success:^(id responseObject, BOOL success) {
        NSLog(@"认证提交=====%@",responseJSONString);
        if (responseSuccess) {
            if (self.block) {
                self.block();
            }
            ShowHUD(responseMessage);
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)getBankList{
    [NetWorkConnection postURL:@"api/user/authen_bank" param:nil success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            NSArray * data = responseObject[@"data"];
            for (NSString *str in data) {
                [self.bankList addObject:str];
            }
        }
    } fail:^(NSError *error) {
        ShowErrorHUD(@"获取银行列表失败");
    }];
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    };
}




- (NSMutableArray *)bankList{
    if (!_bankList) {
        _bankList = [NSMutableArray array];
    }
    return _bankList;
}
@end
