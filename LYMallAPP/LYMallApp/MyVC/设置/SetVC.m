//
//  SetVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/9.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "SetVC.h"
#import "EditPhoneNumerVC.h"
#import "EditLoginPasswordVC.h"
#import "BankCardListVC.h"
#import "BandZFBVC.h"
#import "VerifiedVC.h"
@interface SetVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSDictionary *dataDic;
@end

@implementation SetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"安全设置";

    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [UIView new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinLogin:) name:@"weixinBand" object:nil];
    [self getData];

}
-(void)getData{
    [NetWorkConnection postURL:@"api/user/safety_setting" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"q安全设置=====%@",responseJSONString);
        if (responseSuccess) {
            self.dataDic = responseObject[@"data"];
            
        }
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellINFO = @"celllll2";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellINFO] ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellINFO];
        cell.textLabel.textColor = kUIColorFromRGB(0x333333);
        cell.textLabel.font = FONTSIZE(15);
        cell.detailTextLabel.textColor = kUIColorFromRGB(0x999999);
        cell.detailTextLabel.font = FONTSIZE(15);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"修改手机号码";

    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"修改登录密码";
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"支付宝账户设置";
        if ([self.dataDic[@"zfb_account"] length] >0) {
            cell.detailTextLabel.text = @"已设置";
        }else{
            cell.detailTextLabel.text = @"未设置";
        }

    }else if (indexPath.row == 3) {
        cell.textLabel.text = @"微信账户设置";
        if ([self.dataDic[@"is_wx"] boolValue] == true) {
           cell.detailTextLabel.text = @"已设置";
       }else{
           cell.detailTextLabel.text = @"未设置";
       }

    }else if (indexPath.row == 4) {
           cell.textLabel.text = @"提现银行卡设置";
       if ([self.dataDic[@"is_bank"] boolValue] == true) {
            cell.detailTextLabel.text = @"已设置";
        }else{
            cell.detailTextLabel.text = @"未设置";
        }
    }else if (indexPath.row == 5) {
           cell.textLabel.text = @"实名认证";
       if ([self.dataDic[@"is_bank"] boolValue] == true) {
            cell.detailTextLabel.text = @"已认证";
        }else{
            cell.detailTextLabel.text = @"未认证";
        }
    }
    
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        EditPhoneNumerVC * vc = [[EditPhoneNumerVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
           EditLoginPasswordVC * vc = [[EditLoginPasswordVC alloc]init];
           [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        BandZFBVC * vc = [[BandZFBVC alloc]init];

        if ([self.dataDic[@"zfb_account"] length] >0) {
            vc.phone = self.dataDic[@"zfb_account"];
            vc.name = self.dataDic[@"zfb_name"];
        }
        
           [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 3) {
            [self getAuthWithUserInfoFromWechat];
       }

    if (indexPath.row == 4) {
        BankCardListVC * vc = [[BankCardListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 5) {
        VerifiedVC * vc = [[VerifiedVC alloc]init];
        vc.type = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)weixinLogin:(NSNotification *)noti{
    NSLog(@"微信绑定返回======%@",noti.userInfo);
    NSDictionary *dic = noti.userInfo;
    MJWeakSelf;
    [NetWorkConnection postURL:@"api/user/bindWxinfo" param:@{@"code":dic[@"code"]}
                       success:^(id responseObject, BOOL success) {
                           if (responseDataSuccess) {
                               [QMUITips showSucceed:@"绑定成功"];
                               [weakSelf getData];
                           }else{
                               [QMUITips showError:responseMessage];
                           }
                       } fail:^(NSError *error) {
                           
                       }];
    
    
    
}
#import <UMShare/UMShare.h>

- (void)getAuthWithUserInfoFromWechat
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"band";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
    
}
@end

