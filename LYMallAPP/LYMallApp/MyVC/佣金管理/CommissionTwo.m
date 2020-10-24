//
//  CommissionTwo.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/1.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CommissionTwo.h"
#import "CommissionOneCell.h"
@interface CommissionTwo ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _page;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end
static NSString * commissionCellID = @"CommissionOneCell";
@implementation CommissionTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:commissionCellID bundle:nil] forCellReuseIdentifier:commissionCellID];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           _page = 1;
           [self loadData];
       }];
       self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           _page++;
           [self loadData];
       }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData{
    MJWeakSelf;
    [NetWorkConnection postURL:@"api/user.dealer.order/brokerage" param:@{@"type":@"2",@"page":@(_page)} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            NSLog(@"提现记录=====%@",responseJSONString);
            if (_page == 1 && self.dataArray.count > 0) {
                [self.dataArray removeAllObjects];
            }
            NSArray *data = responseObject[@"data"][@"data"];
            for (NSDictionary *dic in data) {
                [weakSelf.dataArray addObject:dic];
            }
            if (self.dataArray.count == 0) {
                [self showEmptyViewWithImage:CCImage(@"wushuju") text:@"暂无记录" detailText:@"暂无收入记录" buttonTitle:@"再试一次" buttonAction:@selector(loadData)];
            }
        }else{
            ShowErrorHUD(responseMessage);
            [self showEmptyViewWithImage:CCImage(@"wushuju") text:@"请求错误" detailText:@"网络错误" buttonTitle:@"再试一次" buttonAction:@selector(loadData)];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } fail:^(NSError *error) {
        ShowErrorHUD(@"请求失败");
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommissionOneCell * cell = [tableView dequeueReusableCellWithIdentifier:commissionCellID];
    if (self.dataArray.count>0) {
        NSDictionary * dic = self.dataArray[indexPath.row];
        cell.createTimeLabel.text = [NSString stringWithFormat:@"提现时间：%@",dic[@"create_time"]];
        cell.accountTimeLabel.text = [NSString stringWithFormat:@"到账时间：%@",dic[@"audit_time_type"]];
        cell.typeLabel.text = [NSString stringWithFormat:@"提现渠道：%@",dic[@"channel_type"]];
        cell.priceLabel.text = [NSString stringWithFormat:@"提现金额：%@",dic[@"money"]];
        cell.feeLabel.text = [NSString stringWithFormat:@"手续费：%@",dic[@"fee"]];
        cell.real_moneyLabel.text = [NSString stringWithFormat:@"实际到账：%@",dic[@"real_money"]];

    }
    return cell;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight  - 194 - SafeAreaTopHeight - 44)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
