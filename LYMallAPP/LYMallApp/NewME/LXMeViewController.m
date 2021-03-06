//
//  LXMeViewController.m
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXMeViewController.h"

#import "LXMeHeaderView.h"
#import "LXMeOneCell.h"

#import "LXMeTwoTableViewCell.h"
#import "LXTaskHallVC.h"
#import "CouponVC.h"
#import "MyTeamVC.h"
#import "MemberCenterVC.h"
#import "LXSheqingDailiViewController.h"
#import "WebInfoViewController.h"
#import "AgentManagerVC.h"
#import "LXHZViewController.h"
@interface LXMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) LXMeHeaderView * headerView;

@property(nonatomic, strong) NSDictionary  * dataDic;


@end

@implementation LXMeViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LXMeOneCell" bundle:nil] forCellReuseIdentifier:@"LXMeOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXMeTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"LXMeTwoTableViewCell"];
    
    self.headerView = [[NSBundle mainBundle]loadNibNamed:@"LXMeHeaderView" owner:self options:nil].lastObject;
    self.tableView.tableHeaderView = self.headerView;
//    [self loadData];
}



- (void)loadData{
    [NetWorkConnection postURL:@"api/user/my_detail_info" param:nil success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            NSLog(@"我的页面=====%@",responseJSONString);
            NSDictionary * dic = responseObject[@"data"];
            self.dataDic = dic;
            [self.headerView.imgV sd_setImageWithURL:[NSURL URLWithString:dic[@"avatarUrl"]] placeholderImage:[UIImage imageNamed:@"yuanxingzhanweitu"]];
            self.headerView.nameLabel.text = dic[@"nickName"];
            self.headerView.idLabel.text =[NSString stringWithFormat:@"ID：%@",dic[@"invite_code"]];
            self.headerView.labelnum2.text = dic[@"gold"];
            self.headerView.labelnum1.text = dic[@"sliver"];
            [self.headerView.vipBtn setTitle:dic[@"grade_name"] forState:UIControlStateNormal];
            
            [self.tableView reloadData];
        }else{
            ShowErrorHUD(responseMessage);
        }
        [self hideEmptyView];
        [self.tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [self hideEmptyView];
        [self.tableView.mj_header endRefreshing];
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1||section == 2) {
        return 2;
    }else{
        return 1;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ) {
        LXMeOneCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"LXMeOneCell"];
        
        [cell.oneBtn setTitle:@"卡券中心" forState:UIControlStateNormal];
        [cell.fiveBtn setTitle:@"申请代理" forState:UIControlStateNormal];
        [cell.threeBtn setTitle:@"粉丝团队" forState:UIControlStateNormal];
        [cell.fourBtn setTitle:@"会员特权" forState:UIControlStateNormal];
        
        [cell.oneBtn setImage:[UIImage imageNamed:@"me_oneSection_one"] forState:UIControlStateNormal];
        [cell.fiveBtn setImage:[UIImage imageNamed:@"me_twoSection_three"] forState:UIControlStateNormal];
        [cell.threeBtn setImage:[UIImage imageNamed:@"me_oneSection_three"] forState:UIControlStateNormal];
        [cell.fourBtn setImage:[UIImage imageNamed:@"me_oneSection_four"] forState:UIControlStateNormal];
        
        cell.oneClickBtn = ^{
            CouponVC * vc = [CouponVC new];
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.threeClickBtn = ^{
            MyTeamVC * vc = [MyTeamVC new];
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.fourClickBtn = ^{
            MemberCenterVC * vc = [MemberCenterVC new];
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        cell.fiveClickBtn = ^{
            
            if ([self.dataDic[@"is_agency"] intValue] == 2) {
                [NetWorkConnection postURL:@"/api/agency.apply/apply_info" param:nil success:^(id responseObject, BOOL success) {
                    if (responseSuccess) {
                        LXSheqingDailiViewController * vc = [LXSheqingDailiViewController new];
                        vc.content = responseObject[@"data"][@"content"];
                        vc.title = @"申请代理";
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                } fail:^(NSError *error) {
                }];
            }else if ([self.dataDic[@"is_agency"] intValue] == 1) {
                [QMUITips showInfo:@"您已经是代理了！"];
//                AgentManagerVC * vc = [[AgentManagerVC alloc]init];
//                [self.navigationController pushViewController:vc animated:YES];
            }else if ([self.dataDic[@"is_agency"] intValue] == 3) {
                [QMUITips showInfo:@"正在审核，请耐心等待"];
            }
            
            
            
            
        };
        
        return cell;
    } else{
        LXMeTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXMeTwoTableViewCell"];
         if(indexPath.section == 1){
            if (indexPath.row == 0) {
                cell.titleLable.text = @"用户协议";
                cell.imgV.image = [UIImage imageNamed:@"me_xieyi"];
                cell.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner|QMUILayerMaxXMinYCorner;
                cell.layer.cornerRadius = 10;
            }else{
                cell.titleLable.text = @"隐私协议";
                cell.imgV.image = [UIImage imageNamed:@"me_yinsi"];
                cell.layer.qmui_maskedCorners = QMUILayerMinXMaxYCorner|QMUILayerMaxXMaxYCorner;
                cell.layer.cornerRadius = 10;
            }
        }else if (indexPath.section == 2){
            if (indexPath.row == 0) {
                cell.titleLable.text = @"推广规则";
                cell.imgV.image = [UIImage imageNamed:@"me_tuiguang"];
                cell.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner|QMUILayerMaxXMinYCorner;
                cell.layer.cornerRadius = 10;
            }else{
                cell.titleLable.text = @"商务合作";
                cell.imgV.image = [UIImage imageNamed:@"me_hezuo"];
                cell.layer.qmui_maskedCorners = QMUILayerMinXMaxYCorner|QMUILayerMaxXMaxYCorner;
                cell.layer.cornerRadius = 10;
            }
        }
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        WebInfoViewController * vc = [WebInfoViewController new];
        if (indexPath.row == 0) {
            vc.title = @"用户协议";
            
            [NetWorkConnection postURL:@"api/test/rules" param:nil success:^(id responseObject, BOOL success) {
                NSLog(@"%@",responseJSONString);
               NSString * content = responseObject[@"data"][@"register_rule"];
                vc.content = content;
                [self.navigationController pushViewController:vc animated:YES];
            } fail:^(NSError *error) {
                
            }];
            
            
            vc.content = [NSString stringWithFormat:@"%@api/test/rules",BaseUrl];
        }else{
            vc.title = @"隐私协议";
            [NetWorkConnection postURL:@"api/test/rules" param:nil success:^(id responseObject, BOOL success) {
                NSLog(@"%@",responseJSONString);
               NSString * content = responseObject[@"data"][@"info"];
                vc.content = content;
                [self.navigationController pushViewController:vc animated:YES];
            } fail:^(NSError *error) {
                
            }];
        }
    }
    if (indexPath.section == 2) {
       
        if (indexPath.row == 0) {
            WebInfoViewController * vc = [WebInfoViewController new];
            vc.title = @"推广规则";
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            LXHZViewController * vc = [LXHZViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
       
    }
    
}




- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -StatusBarHeight, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}




@end
