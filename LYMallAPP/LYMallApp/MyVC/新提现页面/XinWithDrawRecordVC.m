//
//  XinWithDrawRecordVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/29.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "XinWithDrawRecordVC.h"
#import "XinWithDrawRecordCell.h"

@interface XinWithDrawRecordVC (){
    NSInteger _page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;

@end
static NSString * commissionCellID = @"XinWithDrawRecordCell";

@implementation XinWithDrawRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现记录";
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
    [NetWorkConnection postURL:@"api/withdraw/lists" param:@{@"page":@(_page)} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            NSLog(@"新提现记录=====%@",responseJSONString);
            if (_page == 1 && self.dataArray.count > 0) {
                [self.dataArray removeAllObjects];
            }
            NSArray *data = responseObject[@"data"][@"list"][@"data"];
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
    return 188;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XinWithDrawRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:commissionCellID];
    if (self.dataArray.count>0) {
        NSDictionary * dic = self.dataArray[indexPath.row];
        cell.real_moneyLabel.text = [NSString stringWithFormat:@"提现类型：%@",dic[@"type"]];

        cell.createTimeLabel.text = [NSString stringWithFormat:@"提现时间：%@",dic[@"create_time"]];
        cell.typeLabel.text = [NSString stringWithFormat:@"提现渠道：%@",dic[@"pay_type"]];
        cell.priceLabel.text = [NSString stringWithFormat:@"提现金额：%@",dic[@"money"]];
        cell.feeLabel.text = [NSString stringWithFormat:@"提现手续费：%@",dic[@"fee"]];
        cell.real_moneyLabel.text = [NSString stringWithFormat:@"实际到账：%@",dic[@"real_money"]];
        cell.accountTimeLabel.text = [NSString stringWithFormat:@"提现状态：%@",dic[@"apply_status"]];

    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _dataArray;
}

@end
