//
//  LXCollegeListVC.m
//  LYMallApp
//
//  Created by gds on 2020/10/23.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXCollegeListVC.h"
#import "LXCollegeThreeCell.h"
#import "WebInfoViewController.h"
@interface LXCollegeListVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView * tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
 

@end

@implementation LXCollegeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"新手课堂";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LXCollegeThreeCell" bundle:nil] forCellReuseIdentifier:@"LXCollegeThreeCell"];

    [NetWorkConnection postURL:@"/api/article/lists" param:@{@"category_id":@"0"} success:^(id responseObject, BOOL success) {
        NSLog(@"%@",responseObject);
        self.dataArray = responseObject[@"data"][@"list"][@"data"];
        [self.tableView reloadData];
     } fail:^(NSError *error) {
     }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   LXCollegeThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXCollegeThreeCell"];
    if (self.dataArray.count>0) {
        NSDictionary * dic = self.dataArray[indexPath.section];
        NSDictionary * imageDic = dic[@"image"];
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:imageDic[@"file_path"]]];
        cell.titleLabel.text = dic[@"article_title"];
        cell.timeLabel.text = dic[@"view_time"];
        [cell.zanLabel setTitle:dic[@"1111"] forState:UIControlStateNormal];
        [cell.zhuanfaLabel setTitle:dic[@"2222"] forState:UIControlStateNormal];
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count>0) {
        NSDictionary * dic = self.dataArray[indexPath.section];
        NSLog(@"%@",dic);
        
        [NetWorkConnection postURL:@"api/article/detail" param:@{@"article_id":dic[@"article_id"]} success:^(id responseObject, BOOL success) {
            NSLog(@"%@",responseJSONString);
            NSDictionary * dataDic = responseObject[@"data"][@"detail"];
            WebInfoViewController * vc = [WebInfoViewController new];
            vc.content = dataDic[@"article_content"];
            vc.title = dataDic[@"article_title"];
            [self.navigationController pushViewController:vc animated:YES];
        } fail:^(NSError *error) {
            ShowErrorHUD(@"请求失败");
        }];
    }
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
