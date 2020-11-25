//
//  LXTaskOrderListVC.m
//  LYMallApp
//
//  Created by guxiang on 2020/11/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXTaskOrderListVC.h"

#import "LXTaskListTableViewCell.h"
#import "LXTaskDetalViewController.h"

@interface LXTaskOrderListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LXTaskOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务订单";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXTaskListTableViewCell" bundle:nil] forCellReuseIdentifier:@"LXTaskListTableViewCell"];

    page = 1;
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [weakSelf loadData];
    }];
    [self loadData];
}



- (void)loadData{
    [NetWorkConnection postURL:@"/api/task.task/order" param:@{@"page":@(page)} success:^(id responseObject, BOOL success) {
        NSArray * array = responseObject[@"data"][@"data"];
        NSLog(@"%@",array);
        if (page == 1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray: array];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        if (self.dataArray.count == 0) {
            [self showEmptyViewWithImage:CCImage(@"wushuju") text:@"暂无数据" detailText:@"" buttonTitle:@"点击重试" buttonAction:@selector(loadData)];
        }
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LXTaskListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXTaskListTableViewCell"];
    if (self.dataArray.count>0) {
        NSDictionary * dic = self.dataArray[indexPath.section];
        cell.titleLabel.text = dic[@"title"];
        cell.descLabel.text = dic[@"subtitle"];
        cell.numberLabel.text = [NSString stringWithFormat:@"扣除%@银豆",dic[@"sliver"]];
        [cell.rightBtn setTitle:@"去完成" forState:UIControlStateNormal];
    }
    cell.ClickBtn = ^{
        NSDictionary * dic = self.dataArray[indexPath.section];
        NSLog(@"%@",dic[@"article_content"]);
        
        LXTaskDetalViewController * vc = [LXTaskDetalViewController new];
        vc.content =  dic[@"article_content"];
        vc.orderID = dic[@"id"];
        [self.navigationController pushViewController:vc animated:YES];
        
    };
   
    
    return cell;

}
 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
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



- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;

}
 

@end
