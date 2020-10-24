
//
//  bandZFBVC.m
//  GuaFenBaoAPP
//
//  Created by Mac on 2018/11/25.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "BandZFBVC.h"
//#import "UnBandZFBVC.h"
@interface BandZFBVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *sureButn;
@property (nonatomic,strong)NSString * phoneNumStr;
@end

@implementation BandZFBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付宝账户";
    
   if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
       self.edgesForExtendedLayout = UIRectEdgeNone;
    }
   //必要的设置, 如果没有设置可能导致内容显示不正常
   self.automaticallyAdjustsScrollViewInsets = NO;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 5;
    [self getZFbData];
}

-(void)jiebang:(UIBarButtonItem *)butn{
    MJWeakSelf;
//    UnBandZFBVC * vc = [[UnBandZFBVC alloc]init];
//    vc.phoneNumStr = self.phoneNumStr;
//    vc.block = ^{
//        weakSelf.block();
//    };
//    [self.navigationController pushViewController:vc animated:YES];
    
    
   
}

-(void)getZFbData{
    
    [NetWorkConnection postURL:@"api/user/get_zfb_info" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"支付宝数据===%@",[responseObject mj_JSONString]);
        if (responseDataSuccess) {
            NSDictionary *dic = responseObject[@"data"];
           
            if ([CheackNullOjb cc_isNullOrNilWithObject:dic] == NO) {
            if ([CheackNullOjb cc_isNullOrNilWithObject:dic[@"zfb_name"]] == NO) {
                self.nameTF.text = dic[@"zfb_name"];

            }
            if ([CheackNullOjb cc_isNullOrNilWithObject:dic[@"zfb_account"]] == NO) {
                self.accountTF.text = dic[@"zfb_account"];

            }
          }
        }
    } fail:^(NSError *error) {
        
    }];
}


- (IBAction)sureButn:(UIButton *)sender {
    
    if (self.nameTF.text.length == 0  ) {
        [QMUITips showError:self.nameTF.placeholder];
        return;
    }
    if (self.accountTF.text.length == 0  ) {
        [QMUITips showError:self.accountTF.placeholder];
        return;
    }
//    ShowLodding;
    [NetWorkConnection postURL:@"api/user/on_ali_account" param:@{@"ali_account":self.accountTF.text,@"zfb_name":self.nameTF.text} success:^(id responseObject, BOOL success) {
        if (responseDataSuccess) {
            [QMUITips showSucceed:@"绑定成功"];
            if (self.block) {
                self.block();
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:nil];

            });
        }else{
            ShowHUD(responseMessage);
        }
        
    } fail:^(NSError *error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
