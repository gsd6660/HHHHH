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
@interface LXMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation LXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LXMeOneCell" bundle:nil] forCellReuseIdentifier:@"LXMeOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXMeTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"LXMeTwoTableViewCell"];
    
    LXMeHeaderView * headerView = [[NSBundle mainBundle]loadNibNamed:@"LXMeHeaderView" owner:self options:nil].lastObject;
    self.tableView.tableHeaderView = headerView;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2||section == 3) {
        return 2;
    }else{
        return 1;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ) {
        LXMeOneCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"LXMeOneCell"];
        
        [cell.oneBtn setTitle:@"卡券中心" forState:UIControlStateNormal];
//        [cell.twoBtn setTitle:@"粉丝订单" forState:UIControlStateNormal];
        [cell.threeBtn setTitle:@"粉丝团队" forState:UIControlStateNormal];
        [cell.fourBtn setTitle:@"会员特权" forState:UIControlStateNormal];
        
        [cell.oneBtn setImage:[UIImage imageNamed:@"me_oneSection_one"] forState:UIControlStateNormal];
//        [cell.twoBtn setImage:[UIImage imageNamed:@"me_oneSection_two"] forState:UIControlStateNormal];
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
        return cell;
    } else{
        LXMeTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXMeTwoTableViewCell"];
        if (indexPath.section == 1) {
            cell.titleLable.text = @"我的收藏";
            cell.imgV.image = [UIImage imageNamed:@"me_collect"];
            //            cell.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner
            YBDViewBorderRadius(cell, 10);
        }else if(indexPath.section == 2){
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
        }else if (indexPath.section == 3){
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
   
}




- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}




@end
