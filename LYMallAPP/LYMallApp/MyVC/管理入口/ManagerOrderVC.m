//
//  ManagerOrderVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ManagerOrderVC.h"
#import "ManagerOrderCell.h"
#import "ManagerOrderHeadView.h"
#import "ManagerOrderModel.h"
@interface ManagerOrderVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property(nonatomic,strong)ManagerOrderHeadView *headView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end
static NSString * cellOneID = @"ManagerOrderCell";
@implementation ManagerOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"ManagerOrderHeadView" owner:self options:nil] lastObject];
    self.tableView.tableHeaderView = self.headView;
    [self.tableView registerNib:[UINib nibWithNibName:cellOneID bundle:nil] forCellReuseIdentifier:cellOneID];
    [self getData:@"1"];

    MJWeakSelf;
    self.headView.block = ^(NSInteger type) {
        NSLog(@"点击====%ld",(long)type);
        [weakSelf getData:[NSString stringWithFormat:@"%ld",type]];

    };
        
}

-(void)getData:(NSString *)type{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/signed.order/commission_team_order" param:@{@"page":@"1",@"dataType":type} success:^(id responseObject, BOOL success) {
        NSLog(@"分销管理订单统计====%@",responseJSONString);
         if (responseSuccess) {
              NSDictionary * aggregate = responseObject[@"data"][@"info"];
              [self.headView getDataDic:aggregate];
           NSArray * data = responseObject[@"data"][@"list"][@"data"];
            [self.dataArray removeAllObjects];
           for (NSDictionary *dic in data) {
               NSDictionary *dic1 = dic[@"info"];
               ManagerOrderModel * model = [ManagerOrderModel mj_objectWithKeyValues:dic1];
               [self.dataArray addObject:model];
           }
            [self.tableView reloadData];
            
        
        if (self.dataArray.count == 0) {
            [QMUITips showInfo:@"暂无数据"];
            }

        }else{
            ShowErrorHUD(responseMessage);
           
        }
               [self.tableView reloadData];
        [self hideEmptyView];
    } fail:^(NSError *error) {
        [self hideEmptyView];

    }];
}
-(void)getDataRefresh{
    [self getData:@"1"];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ManagerOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellOneID];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ManagerOrderModel * model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 159;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kTabBarHeight ) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:cellOneID bundle:nil] forCellReuseIdentifier:cellOneID];

    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
