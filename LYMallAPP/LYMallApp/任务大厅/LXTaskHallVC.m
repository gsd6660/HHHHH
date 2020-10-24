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

@end

@implementation LXTaskHallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;

    LXTaskHeaderView * hearderView = [[NSBundle mainBundle]loadNibNamed:@"LXTaskHeaderView" owner:self options:nil].lastObject;
    self.tableView.tableHeaderView = hearderView;
    [self.tableView registerNib:[UINib nibWithNibName:@"LXTaskTwoCell" bundle:nil] forCellReuseIdentifier:@"LXTaskTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXTaskThreeCell" bundle:nil] forCellReuseIdentifier:@"LXTaskThreeCell"];
    
    [self.view addSubview:self.tableView];
    [self loadData];
 }


- (void)loadData{
    [NetWorkConnection postURL:@"/api/task.adv/lists" param:@{@"position":@"1"} success:^(id responseObject, BOOL success) {
        NSLog(@"%@",responseObject);
        
        
        
    } fail:^(NSError *error) {
                
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

@end
