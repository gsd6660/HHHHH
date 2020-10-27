//
//  MyPurseVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MyPurseVC.h"
#import "BonusManagementVC.h"
#import "EquityManagementVC.h"
#import "AmountConsumptionVC.h"
@interface MyPurseVC ()

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;

@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;

@property (weak, nonatomic) IBOutlet UILabel *memberCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UILabel *bankCardBumLable;



@end

@implementation MyPurseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self addTap];
    [self getData];
}



-(void)getData{
    [NetWorkConnection postURL:@"api/user/my_wallet" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"我的钱包=====%@",responseJSONString);
        if (responseSuccess) {
            NSDictionary *data = responseObject[@"data"];
            
            [self getDataDic:data];
            
            
        }
    } fail:^(NSError *error) {
        
    }];
}

-(void)getDataDic:(NSDictionary *)dic{
    
    self.lable1.text = [NSString stringWithFormat:@"%@",dic[@"expend_money"]];
    self.label2.text = [NSString stringWithFormat:@"%@",dic[@"balance"]];
    self.label3.text = [NSString stringWithFormat:@"%@",dic[@"stock_num"]];
    self.label4.text = [NSString stringWithFormat:@"%@",dic[@"gift_points"]];
    self.label5.text = [NSString stringWithFormat:@"%@",dic[@"bonus_money"]];
    self.label6.text = [NSString stringWithFormat:@"%@",dic[@"income_money"]];
    
    self.memberCountLabel.text = [NSString stringWithFormat:@"%@",dic[@"member_account"]];
    self.nameLable.text = [NSString stringWithFormat:@"%@",dic[@"nickName"]];
    self.phoneLable.text = [NSString stringWithFormat:@"%@",dic[@"phone"]];
    self.bankCardBumLable.text = [NSString stringWithFormat:@"%@",dic[@"bank_info"]];

    
    

    
    
}



-(void)addTap{
    MJWeakSelf;
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        
        [weakSelf.navigationController setNavigationBarHidden:NO animated:YES];

        AmountConsumptionVC * vc = [[AmountConsumptionVC alloc]init];
        vc.title = @"消费金额";
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    [self.view1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf.navigationController setNavigationBarHidden:NO animated:YES];

        EquityManagementVC * vc = [[EquityManagementVC alloc]init];
       vc.title = @"余额管理";
       [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self.view2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf.navigationController setNavigationBarHidden:NO animated:YES];

        EquityManagementVC * vc = [[EquityManagementVC alloc]init];
        vc.title = @"股权管理";
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    [self.view3 addGestureRecognizer:tap3];
    
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf.navigationController setNavigationBarHidden:NO animated:YES];

        EquityManagementVC * vc = [[EquityManagementVC alloc]init];
        vc.title = @"积分管理";
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
        
    }];
    [self.view4 addGestureRecognizer:tap4];
    
    UITapGestureRecognizer * tap5 = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf.navigationController setNavigationBarHidden:NO animated:YES];

        BonusManagementVC * vc = [[BonusManagementVC alloc]init];
        
        vc.title = @"奖金管理";
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    [self.view5 addGestureRecognizer:tap5];
    
    UITapGestureRecognizer * tap6 = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf.navigationController setNavigationBarHidden:NO animated:YES];

        BonusManagementVC * vc = [[BonusManagementVC alloc]init];
        
        vc.title = @"收益管理";
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    [self.view6 addGestureRecognizer:tap6];
    
}

- (IBAction)commitButn:(UIButton *)sender {
    
}

- (IBAction)backButn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
