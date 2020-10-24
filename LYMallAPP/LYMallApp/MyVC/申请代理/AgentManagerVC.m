//
//  AgentManagerVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/23.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AgentManagerVC.h"
#import "AgentManagerCell.h"
#import "AgentManagerTwoCell.h"
#import "AgentManagerThreeCell.h"
#import "AgentManagerFourCell.h"
#import "WithdrawDepositVC.h"
@interface AgentManagerVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSDictionary *dataDic;

@end
static NSString * cellOneID = @"AgentManagerCell";
static NSString * cellTwoID = @"AgentManagerTwoCell";
static NSString * cellThreeID = @"AgentManagerThreeCell";
static NSString * cellFourID = @"AgentManagerFourCell";

@implementation AgentManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"代理管理";
    [self.view addSubview:self.tableView];
    [self getData];
}
-(void)getData{
    [NetWorkConnection postURL:@"api/agency.user/index" param:nil success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            NSLog(@"代理管理页面数据====%@",responseJSONString);
            self.dataDic = responseObject[@"data"];
            [self.tableView reloadData];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 107;
    }else if (indexPath.section == 1) {
        return 162;
    }else if (indexPath.section == 2) {
        return 103;
    }
    return 127;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AgentManagerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellOneID];
        [cell.userImageView yy_setImageWithURL:[NSURL URLWithString:self.dataDic[@"user"][@"avatarUrl"]] placeholder:CCImage(@"yuanxingzhanweitu")];
        cell.levelLable.text = self.dataDic[@"user"][@"agency_area"];
        cell.timeLabel.text = [NSString stringWithFormat:@"生效时间：%@   结束时间：%@",self.dataDic[@"user"][@"start_time"],self.dataDic[@"user"][@"end_time"]];
        return cell;
    }
    if (indexPath.section == 1) {
        AgentManagerTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellTwoID];
        cell.last_monthOrderPriceLabel.text = [NSString stringWithFormat:@"%@",self.dataDic[@"commission"][@"last_month"][@"order_price"]];
        cell.last_monthCommissionLabel.text = [NSString stringWithFormat:@"%@",self.dataDic[@"commission"][@"last_month"][@"commission"]];
        
        cell.current_monthOrderPriceLable.text = [NSString stringWithFormat:@"%@",self.dataDic[@"commission"][@"current_month"][@"order_price"]];
        cell.current_monthCommissionLabel.text = [NSString stringWithFormat:@"%@",self.dataDic[@"commission"][@"current_month"][@"commission"]];
        
        return cell;
    }if (indexPath.section == 2) {
        AgentManagerThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellThreeID];
        cell.total_moneyLabel.text = [NSString stringWithFormat:@"累计提现：%@",self.dataDic[@"withdraw"][@"total_money"]];
        cell.moneyLabel.text = [NSString stringWithFormat:@"可提现收入：%@",self.dataDic[@"withdraw"][@"money"]];
        [cell.withdrawButn addTarget:self action:@selector(withdrawButn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
        AgentManagerFourCell * cell = [tableView dequeueReusableCellWithIdentifier:cellFourID];
    cell.memberLable.text = [NSString stringWithFormat:@"会员数量：%@",self.dataDic[@"statistics"][@"member"]];
    cell.order_amountLable.text = [NSString stringWithFormat:@"订单数量：%@",self.dataDic[@"statistics"][@"order_amount"]];
    cell.goods_salesLable.text = [NSString stringWithFormat:@"商品销量：%@",self.dataDic[@"statistics"][@"goods_sales"]];

        return cell;


}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bgView.backgroundColor = kUIColorFromRGB(0xf9f9f9);
    return bgView;
}

-(void)withdrawButn:(UIButton *)butn{
    
    WithdrawDepositVC * vc = [WithdrawDepositVC new];
    vc.urlStr = @"api/agency.withdraw/submit_info";
    vc.submitUrlStr = @"api/agency.withdraw/submit";
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectInset(CGRectMake(0, 0, ScreenWidth, ScreenHeight), 13, 0) style:UITableViewStylePlain];
        _tableView.backgroundColor = kUIColorFromRGB(0xf9f9f9);
        _tableView.delegate =self;
        _tableView.dataSource = self;
//        _tableView.estimatedSectionHeaderHeight = 10;
//        _tableView.estimatedSectionFooterHeight = 0.01;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:cellOneID bundle:nil] forCellReuseIdentifier:cellOneID];
        [_tableView registerNib:[UINib nibWithNibName:cellTwoID bundle:nil] forCellReuseIdentifier:cellTwoID];
        [_tableView registerNib:[UINib nibWithNibName:cellThreeID bundle:nil] forCellReuseIdentifier:cellThreeID];
        [_tableView registerNib:[UINib nibWithNibName:cellFourID bundle:nil] forCellReuseIdentifier:cellFourID];
    }
    return _tableView;
}


@end
