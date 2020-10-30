//
//  LXVIPViewController.m
//  LYMallApp
//
//  Created by guxiang on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXVIPViewController.h"
#import "LXVipHeaderView.h"
#import "LXVipOneCell.h"
#import "LXVipTwoCell.h"
@interface LXVIPViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary * dataDic;
}
@property(nonatomic, strong) UITableView * tableView;
@property(nonatomic, strong)  LXVipHeaderView * headerView;

@end

@implementation LXVIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.headerView = [[NSBundle mainBundle]loadNibNamed:@"LXVipHeaderView" owner:self options:nil].lastObject;
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView registerNib:[UINib nibWithNibName:@"LXVipOneCell" bundle:nil] forCellReuseIdentifier:@"LXVipOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXVipTwoCell" bundle:nil] forCellReuseIdentifier:@"LXVipTwoCell"];
    [self.view addSubview:self.tableView];
    
  
    
    [self loadData];
}


- (void)loadData{
  [NetWorkConnection postURL:@"/api/user.viprule/index" param:@{@"vip_info":@"1",@"vip_rights":@"1",@"viprule":@"1"} success:^(id responseObject, BOOL success) {
        NSDictionary * dic = responseObject[@"data"][@"vip_info"];
        [self.headerView.headerView sd_setImageWithURL:[NSURL URLWithString:dic[@"avatarUrl"]] placeholderImage:[UIImage imageNamed:@"yuanxingzhanweitu"]];
        self.headerView.nameLabel.text = dic[@"nickName"];
        self.headerView.tipLabel.text = dic[@"next_expend_money"];
      dataDic = responseObject[@"data"];
      [self.tableView reloadData];
      
    } fail:^(NSError *error) {
        [self.tableView reloadData];
    
    }];
  
}

 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSLog(@"%@",dataDic[@"viprule"]);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LXVipOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXVipOneCell"];
        return cell;
    }else {
        LXVipTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXVipTwoCell"];
        if (dataDic) {
            NSDictionary * dic = dataDic[@"vip_rights"][0];
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]]];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 230;
    }else{
        return 100;
    }
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
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}



@end
