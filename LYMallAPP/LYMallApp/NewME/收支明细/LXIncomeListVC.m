//
//  LXIncomeListVC.m
//  LYMallApp
//
//  Created by guxiang on 2020/11/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXIncomeListVC.h"
#import "LXIncomeCell.h"
@interface LXIncomeListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;




@end

@implementation LXIncomeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LXIncomeCell" bundle:nil] forCellReuseIdentifier:@"LXIncomeCell"];
    
    if (self.type == LXSilver) {
        self.title = @"银豆记录";
    }else{
        self.title = @"金豆记录";
    }
    
    page = 1;
    [self loadData];
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        page = 1;
        [weakSelf loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [weakSelf loadData];
    }];
}

- (void)loadData{
    
//    api/task.wallet/log 收益记录
    
    
    if (self.type == LXSilver) {
        [NetWorkConnection postURL:@"api/task.wallet/sliverLog" param:@{@"page":@(page)} success:^(id responseObject, BOOL success) {
            NSLog(@"%@",responseJSONString);
            if (responseSuccess) {
                if (page == 1) {
                    [self.dataArray removeAllObjects];
                }
                NSArray * arr = responseObject[@"data"][@"list"][@"data"];
                [self.dataArray addObjectsFromArray:arr];

                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
            }
        } fail:^(NSError *error) {

        }];
    }else{
        [NetWorkConnection postURL:@"api/task.wallet/goldLog" param:@{@"page":@(page)} success:^(id responseObject, BOOL success) {
            NSLog(@"%@",responseJSONString);
            if (responseSuccess) {
                if (page == 1) {
                    [self.dataArray removeAllObjects];
                }
                NSArray * arr = responseObject[@"data"][@"list"][@"data"];
                [self.dataArray addObjectsFromArray:arr];
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
            }
        } fail:^(NSError *error) {
            
        }];
    }
    
  
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LXIncomeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXIncomeCell"];
    
    if (self.dataArray.count>0) {
        NSDictionary * dic = self.dataArray[indexPath.row];
        
        if (self.type == LXSilver) {
            cell.titleLabel.text = dic[@"type_name"];
            if ([dic[@"method"] intValue] == 2) {
                cell.descLabel.text = [NSString stringWithFormat:@"%@",dic[@"value"]];
            }else{
                cell.descLabel.text = [NSString stringWithFormat:@"%@",dic[@"value"]];
            }
        }else{
            cell.titleLabel.text = dic[@"type_name"];
            if ([dic[@"method"] intValue] == 2) {
                cell.descLabel.text = [NSString stringWithFormat:@"%@",dic[@"value"]];
            }else{
                cell.descLabel.text = [NSString stringWithFormat:@"%@",dic[@"value"]];
            }
        }
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001f;
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
