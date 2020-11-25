//
//  LXTaskHallVC.m
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXTaskHallVC.h"

#import "LXTaskHeaderView.h"
#import "LXTaskOneCell.h"
#import "LXTaskTwoCell.h"
#import "LXTaskThreeCell.h"
#import "LXTaskListViewController.h"
@interface LXTaskHallVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong)  LXTaskHeaderView * hearderView;
@property(nonatomic, strong) NSMutableArray * bannerLists;
@property(nonatomic, strong) NSMutableArray * noticeList;

@end

@implementation LXTaskHallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;

    self.hearderView = [[NSBundle mainBundle]loadNibNamed:@"LXTaskHeaderView" owner:self options:nil].lastObject;
    self.tableView.tableHeaderView = self.hearderView;
    [self.tableView registerNib:[UINib nibWithNibName:@"LXTaskTwoCell" bundle:nil] forCellReuseIdentifier:@"LXTaskTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXTaskThreeCell" bundle:nil] forCellReuseIdentifier:@"LXTaskThreeCell"];
    
    [self.view addSubview:self.tableView];
    [self loadData];
 }


- (void)loadData{
    dispatch_group_t group = dispatch_group_create();
    
    //WS(weakSelf);
    dispatch_group_enter(group);
    [self loadOne:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [self loadNotice:^(BOOL isScu) {
        dispatch_group_leave(group);
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.hearderView.dataArray = self.bannerLists;
        [self.tableView reloadData];
        [self.tableView reloadData];
    });
}

- (void)loadOne:(void(^)(BOOL isScu))requestScu{
    [NetWorkConnection postURL:@"/api/task.adv/lists" param:@{@"position":@"1"} success:^(id responseObject, BOOL success) {
        NSLog(@"%@",responseJSONString);
        self.bannerLists = responseObject[@"data"][@"list"];
        requestScu(YES);
    } fail:^(NSError *error) {
        requestScu(YES);
    }];
    
   
    
}

- (void)loadNotice:(void(^)(BOOL isScu))requestScu{
    [NetWorkConnection postURL:@"/api/task.task/notice" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"%@",responseJSONString);
        if (responseSuccess) {
            self.noticeList = responseObject[@"data"][@"list"];
        }else{
            
        }
        requestScu(YES);
    } fail:^(NSError *error) {
        requestScu(YES);
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LXTaskOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXTaskOneCell"];
        if (!cell) {
            cell = [[LXTaskOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LXTaskOneCell"];
        }
        return cell;
    }
    if (indexPath.section == 1) {
        LXTaskTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXTaskTwoCell"];
        if (self.noticeList.count>0) {
            cell.jhtView.sourceArray = self.noticeList;
        }
        return cell;
    }else{
        LXTaskThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXTaskThreeCell"];
        
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 190;
    }
    if (indexPath.section == 1) {
        return 50;
    }else{
        return 130;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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


- (NSMutableArray *)bannerLists{
    if (!_bannerLists) {
        _bannerLists = [NSMutableArray array];
    }
    return _bannerLists;
}

@end
