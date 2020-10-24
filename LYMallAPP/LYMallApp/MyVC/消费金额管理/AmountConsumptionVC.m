//
//  AmountConsumptionVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AmountConsumptionVC.h"
#import "MyOrderOneCell.h"
#import "OrderHeadView.h"
#import "AmountConsumptionHeadView.h"
#import "AmountConsumptionFootView.h"
@interface AmountConsumptionVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end
static NSString * cellID = @"MyOrderOneCell";
static NSString *viewIdentfier = @"AmountConsumptionFootView";

@implementation AmountConsumptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    [self.tableView registerNib:[UINib nibWithNibName:viewIdentfier bundle:nil] forHeaderFooterViewReuseIdentifier:viewIdentfier];
    [self getData];

    MJWeakSelf;
       self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           weakSelf.page = 1;
           [weakSelf getData];
       }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf getData];
    }];
    
}
-(void)getData{
        [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/user/all_withdraw_log" param:@{@"type":@"1",@"page":[NSString stringWithFormat:@"%ld",(long)self.page]} success:^(id responseObject, BOOL success) {
        if (responseDataSuccess) {
            if (self.dataArray.count > 0 && self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            
            NSLog(@"余额消费====%@",responseJSONString);
            NSArray * data = responseObject[@"data"][@"data"];
            for (NSDictionary *dic in data) {
                [self.dataArray addObject:dic[@"info"]];
            }
            if (self.dataArray.count == 0) {
                [self showEmptyViewWithLoading:NO image:CCImage(@"wushuju") text:@"暂无数据" detailText:@"你还没有订单哦~" buttonTitle:@"点击重试" buttonAction:@selector(getData)];
            }else{
                [self hideEmptyView];
                
            }
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
        
    } fail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self showEmptyViewWithLoading:NO image:CCImage(@"wuwangluo") text:@"加载失败" detailText:@"请检查网络是否异常" buttonTitle:@"点击重试" buttonAction:@selector(getData)];
        [self hideEmptyView];
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * datas = self.dataArray[section][@"goods_list"];
    return datas.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MyOrderOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *datas = self.dataArray[indexPath.section][@"goods_list"];
    
    if (datas.count > 0) {
        cell.consumeData = datas[indexPath.row];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //    NSString * str = self.dataArray[section];
    static NSString *viewIdentfier = @"headView";
    AmountConsumptionHeadView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    if(!sectionHeadView){
        sectionHeadView = [[AmountConsumptionHeadView alloc] initWithReuseIdentifier:viewIdentfier];
    }

    NSDictionary * stateDic = self.dataArray[section];
    sectionHeadView.stateLable.text = stateDic[@"order_source"];
    sectionHeadView.orderNumLable.text = [NSString stringWithFormat:@"订单编号:%@",self.dataArray[section][@"order_no"]];
    return sectionHeadView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   MJWeakSelf;
    NSDictionary * stateDic = self.dataArray[section];
    AmountConsumptionFootView *sectionFootView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    sectionFootView.contentView.backgroundColor = [UIColor whiteColor];
    
    sectionFootView.moneyLable.text = stateDic[@"order_price"];
    sectionFootView.timeLable.text = stateDic[@"pay_time"];

    
    return sectionFootView;

    
}
    


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 107;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}


-(NSMutableArray *)dataArray{
    if (_dataArray ==nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectInset(CGRectMake(0, 0, ScreenWidth , ScreenHeight ), 0, 0) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionFooterHeight = 90;
        _tableView.estimatedSectionHeaderHeight = 39;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}
@end
