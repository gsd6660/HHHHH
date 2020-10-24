//
//  LXRuleListViewController.m
//  LYMallApp
//
//  Created by gds on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXRuleListViewController.h"
#import "LXRuleTableViewCell.h"

@interface LXRuleListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * titles;
    NSArray * images;
}
@property(nonatomic, strong) UITableView *tableView;


@end

@implementation LXRuleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务规则说明";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXRuleTableViewCell" bundle:nil] forCellReuseIdentifier:@"LXRuleTableViewCell"];
    titles = @[@"普通会员",@"VIP会员",@"钻石会员"];
    images = @[@"one_1",@"one_2",@"one_3"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LXRuleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXRuleTableViewCell"];
    
    cell.titleLabel.text = titles[indexPath.section];
    cell.imgV.image = [UIImage imageNamed:images[indexPath.section]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180;

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


@end
