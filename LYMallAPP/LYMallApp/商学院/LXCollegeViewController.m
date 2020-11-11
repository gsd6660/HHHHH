//
//  LXCollegeViewController.m
//  LYMallApp
//
//  Created by guxiang on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXCollegeViewController.h"
#import "LXCollegeHeaderView.h"
#import "LXCollegeOneCell.h"
#import "LXCollegeTwoCell.h"
#import "LXCollegeThreeCell.h"
#import "LXCollegeSectionHeaderView.h"
#import "WebInfoViewController.h"

@interface LXCollegeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView * tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) NSMutableArray *listArray;

@property(nonatomic, strong) NSMutableArray *adArray;


@end

@implementation LXCollegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商学院";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXCollegeOneCell" bundle:nil] forCellReuseIdentifier:@"LXCollegeOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXCollegeTwoCell" bundle:nil] forCellReuseIdentifier:@"LXCollegeTwoCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"LXCollegeThreeCell" bundle:nil] forCellReuseIdentifier:@"LXCollegeThreeCell"];
    
    LXCollegeHeaderView * headerView = [[NSBundle mainBundle]loadNibNamed:@"LXCollegeHeaderView" owner:self options:nil].lastObject;
    self.tableView.tableHeaderView = headerView;
    
    [self loadData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
}

- (void)loadData{
    dispatch_group_t group = dispatch_group_create();
    
    //WS(weakSelf);
    dispatch_group_enter(group);
    [self loadOne:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [self loadTwo:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self loadThree:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    });
}

- (void)loadOne:(void(^)(BOOL isScu))requestScu{
    [NetWorkConnection postURL:@"/api/article/lists" param:@{@"category_id":@"2"} success:^(id responseObject, BOOL success) {
           NSLog(@"%@",responseObject);
           self.dataArray = responseObject[@"data"][@"list"][@"data"];
        requestScu(YES);
       } fail:^(NSError *error) {
        requestScu(YES);
       }];
}

- (void)loadTwo:(void(^)(BOOL isScu))requestScu{
    [NetWorkConnection postURL:@"/api/article/lists" param:@{@"category_id":@"0"} success:^(id responseObject, BOOL success) {
           NSLog(@"%@",responseObject);
           self.listArray = responseObject[@"data"][@"list"][@"data"];
        requestScu(YES);
       } fail:^(NSError *error) {
        requestScu(YES);
       }];
}

- (void)loadThree:(void(^)(BOOL isScu))requestScu{
    [NetWorkConnection postURL:@"/api/task.adv/lists" param:@{@"postion":@"3"} success:^(id responseObject, BOOL success) {
           NSLog(@"%@",responseObject);
           self.adArray = responseObject[@"data"][@"list"][@"data"];
        requestScu(YES);
       } fail:^(NSError *error) {
        requestScu(YES);
       }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return self.listArray.count;
    }
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LXCollegeOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXCollegeOneCell"];
        
        return cell;
    }
    if (indexPath.section == 1) {
        LXCollegeTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXCollegeTwoCell"];
        if (self.dataArray.count>0) {
            cell.dataArray = self.dataArray;
        }
        return cell;
    }else{
        LXCollegeThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXCollegeThreeCell"];
        if (self.listArray.count>0) {
            NSDictionary * dic = self.listArray[indexPath.row];
            NSDictionary * imageDic = dic[@"image"];
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:imageDic[@"file_path"]]];
            cell.titleLabel.text = dic[@"article_title"];
            cell.timeLabel.text = dic[@"view_time"];
            [cell.zanLabel setTitle:dic[@"1111"] forState:UIControlStateNormal];
            [cell.zhuanfaLabel setTitle:dic[@"2222"] forState:UIControlStateNormal];
        }
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = self.listArray[indexPath.row];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100;
    }
    if (indexPath.section == 1) {
        return 160;
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==2 ) {
        return 50;
    }
    if (section == 0) {
        return 0.1f;
    }
    return 10;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UIView * bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        bg.backgroundColor = UIColor.clearColor;
        LXCollegeSectionHeaderView * headerView = [[NSBundle mainBundle]loadNibNamed:@"LXCollegeSectionHeaderView" owner:self options:nil].lastObject;
        headerView.frame = CGRectMake(10, 0, ScreenWidth - 20, 50);
        [bg addSubview:headerView];
        headerView.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner | QMUILayerMaxXMinYCorner;
        headerView.layer.cornerRadius = 10;
        return bg;
    }
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

- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (NSMutableArray *)adArray{
    if (!_adArray) {
        _adArray = [NSMutableArray array];
    }
    return _adArray;
}

@end
