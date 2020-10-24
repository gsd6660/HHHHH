
//
//  CommissionManagerVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CommissionManagerVC.h"
#import "CommissionManagerCell.h"
#import "CommissionManagerHeadView.h"
#import "CommissionManagerTwoCell.h"
#import "TeamDetailView.h"
#import "CommissionModel.h"
@interface CommissionManagerVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)CommissionManagerHeadView *headView;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * recordArray;

@end
static NSString * cellOneID = @"CommissionManagerCell";
static NSString * cellTwoID = @"CommissionManagerTwoCell";

@implementation CommissionManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = 0;
    [self.view addSubview:self.tableView];
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"CommissionManagerHeadView" owner:self options:nil] lastObject];
    self.tableView.tableHeaderView = self.headView;
    
    [self.headView.incomeButn addTarget:self action:@selector(incomeButn:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.recordButn addTarget:self action:@selector(recordButn:) forControlEvents:UIControlEventTouchUpInside];
    [self getData:@"1"];
    
}

-(void)getData:(NSString *)dataType{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/signed.order/commission_statistic" param:@{@"dataType":dataType,@"page":@"1"} success:^(id responseObject, BOOL success) {
        NSLog(@"分销管理佣金信息=====%@",responseJSONString);
        if (responseSuccess) {
            NSDictionary * aggregate = responseObject[@"data"][@"aggregate"];
            [self.headView getDataDic:aggregate];
            if ([dataType intValue] == 1) {
                NSArray * data = responseObject[@"data"][@"order_list"][@"data"];
                [self.dataArray removeAllObjects];
                for (NSDictionary *dic in data) {
                    NSDictionary *dic1 = dic[@"info"];
                    CommissionModel * model = [CommissionModel mj_objectWithKeyValues:dic1];
                    [self.dataArray addObject:model];
                }
                if (self.dataArray.count == 0) {
                    ShowErrorHUD(@"暂无数据");
                }
                [self.tableView reloadData];
                
                
            }else{
                NSArray * data = responseObject[@"data"][@"order_list"][@"data"];
                [self.recordArray removeAllObjects];
                for (NSDictionary *dic in data) {
                    NSDictionary *dic1 = dic[@"info"];
                    CommissionModel * model = [CommissionModel mj_objectWithKeyValues:dic1];
                    [self.recordArray addObject:model];
                }if (self.recordArray.count == 0) {
                    ShowErrorHUD(@"暂无数据");
                }
                [self.tableView reloadData];
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




-(void)incomeButn:(UIButton *)butn{
    self.type = 0;
    self.headView.rightlineView.hidden = YES;
    self.headView.leftlineView.hidden = NO;
    [self getData:@"1"];

}

-(void)recordButn:(UIButton *)butn{
    self.type = 1;
    [self getData:@"2"];

    self.headView.leftlineView.hidden = YES;
    self.headView.rightlineView.hidden = NO;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type == 0) {
        return self.dataArray.count;
    }
    return self.recordArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
        if (self.type == 0) {
            CommissionManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellOneID];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            CommissionModel * model = self.dataArray[indexPath.row];
            cell.model = model;
            return cell;
        }
        CommissionManagerTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTwoID];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CommissionModel * model = self.recordArray[indexPath.row];
        cell.model = model;
        return cell;
        
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 0) {
        return 116;
    }
        return 185;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 0) {
        
        CommissionModel * model = self.dataArray[indexPath.row];
        [NetWorkConnection postURL:@"api/signed.order/commission_detail" param:@{@"order_id":model.order_id} success:^(id responseObject, BOOL success) {
            NSLog(@"佣金详情=====%@",responseJSONString);
            
            if (responseSuccess) {
                NSDictionary *dic = responseObject[@"data"];
                if ([CheackNullOjb cc_isNullOrNilWithObject:dic] == NO) {
                    [self showPopView:dic];
                }else{
                    ShowErrorHUD(@"网络请求错误");
                }

            }
            
        } fail:^(NSError *error) {
            
        }];
        
        
        
       }
    
}


-(void)showPopView:(NSDictionary *)dic{
    TeamDetailView * popView = [[[NSBundle mainBundle]loadNibNamed:@"TeamDetailView" owner:nil options:nil]lastObject];
    [popView getDataDic:dic];
    QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
    modalViewController.contentView = popView;
    modalViewController.animationStyle = 2;
    modalViewController.modal = YES;
    [modalViewController showWithAnimated:YES completion:nil];
    
    [popView.closeButn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [modalViewController hideWithAnimated:YES completion:nil];
       
    }];
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kTabBarHeight ) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:cellOneID bundle:nil] forCellReuseIdentifier:cellOneID];
        [_tableView registerNib:[UINib nibWithNibName:cellTwoID bundle:nil] forCellReuseIdentifier:cellTwoID];

    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(NSMutableArray *)recordArray{
    if (_recordArray == nil) {
        _recordArray = [[NSMutableArray alloc]init];
    }
    return _recordArray;
}



@end
