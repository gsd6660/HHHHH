//
//  CommissionOne.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/1.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CommissionOne.h"
#import "CommissionOneCell.h"
@interface CommissionOne ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _page;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

static NSString * commissionCellID = @"CommissionOneCell";

@implementation CommissionOne

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
    [NetWorkConnection postURL:@"api/user.dealer.order/brokerage" param:@{@"type":@"1",@"page":@(_page)} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            NSLog(@"%@",responseObject);
            if (_page == 1 && weakSelf.dataArray.count > 0) {
                [weakSelf.dataArray removeAllObjects];
            }
            weakSelf.dataArray = responseObject[@"data"][@"data"];
            if (responseObject[@"data"][@"user"] != nil) {
                if (self.block) {
                    self.block(responseObject[@"data"][@"user"]);
                }
            }
        if (weakSelf.dataArray.count == 0) {
            [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"wushuju"] text:@"暂无记录" detailText:@"暂无收入记录" buttonTitle:@"再试一次" buttonAction:@selector(loadData)];
            }
        }else{
            ShowErrorHUD(responseMessage);
            [weakSelf showEmptyViewWithImage:[UIImage imageNamed:@"wushuju"] text:@"请求错误" detailText:@"网络错误" buttonTitle:@"再试一次" buttonAction:@selector(loadData)];
        }
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } fail:^(NSError *error) {
        ShowErrorHUD(@"请求失败");
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommissionOneCell * cell = [tableView dequeueReusableCellWithIdentifier:commissionCellID];
    if (self.dataArray.count>0) {
        NSDictionary * dic = self.dataArray[indexPath.row];
        cell.createTimeLabel.text = [NSString stringWithFormat:@"创建时间：%@",dic[@"create_time"]];
        cell.accountTimeLabel.text = [NSString stringWithFormat:@"入账时间：%@",dic[@"settle_time"]];
        cell.typeLabel.text = [NSString stringWithFormat:@"入账类型：%@",dic[@"entry_type"]];
        cell.priceLabel.text = [NSString stringWithFormat:@"入账金额：%@",dic[@"entry_money"]];
    }
    
    return cell;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
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
