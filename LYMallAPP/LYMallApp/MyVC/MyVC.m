//
//  MyVC.m
//  LYMallApp
//
//  Created by Mac on 2020/3/10.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MyVC.h"
#import "MyHeadView.h"
#import "MyOneCell.h"
#import "MyTwoCell.h"
#import "MyThreeCell.h"
#import "MyFourCell.h"
#import "MyDetailMessageVC.h"

#import "MyOrderVC.h"
#import "MyAddressListVC.h"
#import "SureOrderVC.h"
#import "OrderDetailVC.h"

#import "LoginVC.h"
#import "RegisterVC.h"
#import "RegisterVC.h"
#import "MemberCenterVC.h"
#import "CommissionManageVC.h"
#import "WithdrawDepositVC.h"
#import "AppleyAgentVC.h"
#import "CouponModel.h"
#import "AgentManagerVC.h"
#import "ExclusiveView.h"
#import "CouponVC.h"
@interface MyVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tabeleView;
@property(nonatomic,strong)MyHeadView * headView;
@property(nonatomic,strong)ExclusiveView * exclusiveView;

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSDictionary * dataDic;
@property(nonatomic,strong)NSString * grade_name;

@end

static NSString * cellAID = @"MyOneCell";
static NSString * cellBID = @"MyTwoCell";
static NSString * cellCID = @"MyThreeCell";
static NSString * cellDID = @"MyFourCell";

@implementation MyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tabeleView];

    self.headView = [[MyHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 317)];
    self.tabeleView.tableHeaderView = self.headView;
    [self loadData];
    MJWeakSelf;
    [self.headView.duplicateButn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        UIPasteboard * pb = [UIPasteboard generalPasteboard];
        [pb setString:weakSelf.dataDic[@"invite_code"]];
        ShowHUD(@"复制成功");
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfor:) name:@"updateUserInfo" object:nil];
    self.tabeleView.mj_header =  [YMRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf loadData];
    }];
    [self getCoupon];

}

-(void)updateUserInfor:(NSNotification *)noti{
    NSLog(@"转发通知的线程%@", [NSThread currentThread]);
    [self loadData];
}



- (void)loadData{
    [self showEmptyViewWithLoading];

    [NetWorkConnection postURL:@"api/user/my_detail_info" param:nil success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            NSLog(@"我的页面=====%@",responseJSONString);
            NSDictionary * dic = responseObject[@"data"];
            self.dataDic = dic;
            [self.headView.userImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"avatarUrl"]] placeholderImage:[UIImage imageNamed:@"yuanxingzhanweitu"]];
            self.headView.userNameLabel.text = dic[@"nickName"];
            self.headView.inviteCodeLabel.text =[NSString stringWithFormat:@"邀请码：%@",dic[@"invite_code"]];
            self.headView.balanceLabel.text = dic[@"balance"];
            self.headView.integralLabel.text = [NSString stringWithFormat:@"%@",dic[@"points"]];
            self.headView.cumulativeCommissionLabel.text = [NSString stringWithFormat:@"%@", dic[@"bonus_money"]];
            self.headView.withdrawalCommissionLabel.text = [NSString stringWithFormat:@"%@",dic[@"income_money"]];
            if ([dic[@"grade_image"]length] > 0) {
                [self.headView.vipImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"grade_image"]] placeholderImage:nil];
            }else{
                self.headView.vipImageView.hidden = YES;
            }
            self.grade_name = dic[@"grade_name"];
            
            if ([CheackNullOjb cc_isNullOrNilWithObject:dic[@"invite_code"]] == NO) {
                self.headView.duplicateButn.hidden = NO;
            }else{
                self.headView.duplicateButn.hidden = YES;
            }
            
            [self.tabeleView reloadData];
        }else{
            ShowErrorHUD(responseMessage);
        }
        [self hideEmptyView];
        [self.tabeleView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [self hideEmptyView];
        [self.tabeleView.mj_header endRefreshing];

    }];
}


-(void)getCoupon{
    [NetWorkConnection postURL:@"api/user/register_coupon" param:nil success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            
            BOOL isShow = responseObject[@"data"][@"is_show"];
            if (isShow == YES) {
                [self CreatMySubscriptivePopView];
            }
        }
    } fail:^(NSError *error) {
        
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    NSString * str = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if ([CheackNullOjb cc_isNullOrNilWithObject:str]) {
        [self.tabBarController setSelectedIndex:0];
    }
    GF_Check_Login
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MyOneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellAID];
        cell.dataArray = self.dataArray;
        if (self.grade_name.length > 0) {
        cell.vipTypeLabel.text = [NSString stringWithFormat:@"当前等级：%@",self.grade_name];
        }
        return cell;
    }
    if (indexPath.section == 1) {
        MyTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellBID];
        [cell.butn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            MyOrderVC * vc = [[MyOrderVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return cell;
    }
    if (indexPath.section == 2) {
        MyThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellCID];
        if (self.dataDic[@"agency_img"] !=nil) {
            [cell.imgBgView yy_setImageWithURL:[NSURL URLWithString:self.dataDic[@"agency_img"]] placeholder:CCImage(@"jft_img_applyforagent")];

        }
        return cell;
    }
    
    MyFourCell * cell = [tableView dequeueReusableCellWithIdentifier:cellDID];
    cell.is_periods = [_dataDic[@"is_periods"] boolValue];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.dataArray.count == 0) {
            return 42;
        }
        return 42;//120
    }else  if (indexPath.section == 1) {
         return 123;
    }else  if (indexPath.section == 2) {
        if ([self.dataDic[@"is_show_agency"] boolValue] == NO) {
            return 0;
        }
         return 101;
    }
    return 290;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MemberCenterVC * vc = [[MemberCenterVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 2) {
        if ([self.dataDic[@"is_agency"] intValue] == 2) {
            AppleyAgentVC * vc = [[AppleyAgentVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([self.dataDic[@"is_agency"] intValue] == 1) {
            AgentManagerVC * vc = [[AgentManagerVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([self.dataDic[@"is_agency"] intValue] == 3) {
            [QMUITips showInfo:@"正在审核，请耐心等待"];
        }
        
        
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 30;
    }
    return 0.01;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * heaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    heaView.backgroundColor = kUIColorFromRGB(0xF8F8F8);
    return heaView;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * fView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.01)];
    fView.backgroundColor = kUIColorFromRGB(0xF8F8F8);
    return fView;

}


-(void)CreatMySubscriptivePopView{
    self.exclusiveView = [[ExclusiveView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 330)];
    QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
    
    modalViewController.contentView = self.exclusiveView;
    modalViewController.onlyRespondsToKeyboardEventFromDescendantViews = YES;

    modalViewController.dimmingView.userInteractionEnabled = NO;
    
    modalViewController.animationStyle = 1;
    [modalViewController showWithAnimated:YES completion:nil];
    [self.exclusiveView.closeButn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [modalViewController hideWithAnimated:YES completion:nil];
    }];
    MJWeakSelf;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [modalViewController hideWithAnimated:YES completion:nil];
        CouponVC * vc = [[CouponVC alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self.exclusiveView.imgView addGestureRecognizer:tap];
    
    

}


-(UITableView *)tabeleView{
    if (_tabeleView == nil) {
        _tabeleView = [[UITableView alloc]initWithFrame:CGRectInset(CGRectMake(0, 0, ScreenWidth, ScreenHeight ), 0, 0) style:UITableViewStyleGrouped];
        _tabeleView.delegate = self;
        _tabeleView.dataSource =self;
        _tabeleView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _tabeleView.backgroundColor = kUIColorFromRGB(0xF8F8F8);
        _tabeleView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tabeleView.estimatedSectionHeaderHeight = 10;
        _tabeleView.backgroundColor = [UIColor clearColor];
        _tabeleView.showsVerticalScrollIndicator = NO;
        [_tabeleView registerNib:[UINib nibWithNibName:cellAID bundle:nil] forCellReuseIdentifier:cellAID];
        [_tabeleView registerNib:[UINib nibWithNibName:cellBID bundle:nil] forCellReuseIdentifier:cellBID];
        [_tabeleView registerNib:[UINib nibWithNibName:cellCID bundle:nil] forCellReuseIdentifier:cellCID];
        [_tabeleView registerNib:[UINib nibWithNibName:cellDID bundle:nil] forCellReuseIdentifier:cellDID];
        
    }
    return _tabeleView;
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil
        ) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
