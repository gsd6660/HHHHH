//
//  LXTaskListViewController.m
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXTaskListViewController.h"
#import "LXTaskListTableViewCell.h"
#import "LXTaskDetalViewController.h"
@interface LXTaskListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LXTaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务列表";
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
    [NetWorkConnection postURL:@"/api/task.task/lists" param:@{@"page":@(page),@"type":self.type} success:^(id responseObject, BOOL success) {
        NSArray * array = responseObject[@"data"][@"list"][@"data"];
        NSLog(@"%@",responseJSONString);
        if (page == 1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray: array];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
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
        NSDictionary * imageDic = dic[@"image"];
        if ([imageDic isKindOfClass:[NSDictionary class]]) {
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:imageDic[@"file_path"]] placeholderImage:[UIImage imageNamed:@"coll_sub_one"]];
        }else{
            cell.imgV.image = [UIImage imageNamed:@"coll_sub_one"];
        }
        
    }
    cell.ClickBtn = ^{
        NSDictionary * dic = self.dataArray[indexPath.section];
        NSLog(@"%@",dic);
        [QMUITips showLoadingInView:self.view];
        [NetWorkConnection postURL:@"api/task.task/accept" param:@{@"task_id":dic[@"id"]} success:^(id responseObject, BOOL success) {
            [QMUITips hideAllTipsInView:self.view];
            if (responseSuccess) {
                ShowHUD(responseMessage);
            }else{
                ShowErrorHUD(responseMessage);
            }
            
        } fail:^(NSError *error) {
            ShowErrorHUD(@"失败");
        }];
        
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary * dic = self.dataArray[indexPath.section];

//    LXTaskDetalViewController * vc = [LXTaskDetalViewController new];
//    vc.content = dic[@"article_content"];
//    vc.orderID = dic[@"id"];
//    [self.navigationController pushViewController:vc animated:YES];
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
