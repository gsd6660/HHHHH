
//
//  MyOrderThreeVC.m
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "MyOrderThreeVC.h"
#import "MyOrderOneCell.h"
#import "OrderHeadView.h"
#import "OrderFootView.h"
#import "OrderDetailVC.h"
#import "AftermarketVC.h"
#import "PopBottomView.h"
#import "RefundRequestVC.h"
#import "NCLookLogisticsVC.h"
@interface MyOrderThreeVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)UITableView * tableView;

@end
static NSString * cellID = @"MyOrderOneCell";

@implementation MyOrderThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"待收货";
    [self.view addSubview:self.tableView];
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.backgroundColor = kUIColorFromRGB(0xF1F4F8);
    self.view.backgroundColor = kUIColorFromRGB(0xF1F4F8);
    
    //   self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = ScreenHeight >= 812.0 ? -34 : 0;
    if (ScreenHeight>=812) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, - 20, 0);
    }
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    
    
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.page = 1;
    [self getData];
}

-(void)getData{
        [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/user.order/lists" param:@{@"dataType":@"received",@"page":[NSString stringWithFormat:@"%ld",(long)self.page]} success:^(id responseObject, BOOL success) {
        if (responseDataSuccess) {
            if (self.dataArray.count > 0 && self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            
            NSLog(@"代付款订单====%@",responseJSONString);
            NSArray * data = responseObject[@"data"][@"data"];
            for (NSDictionary *dic in data) {
                [self.dataArray addObject:dic];
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
    NSArray * datas = self.dataArray[section][@"goods"];
    return datas.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MJWeakSelf;
    MyOrderOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *datas = self.dataArray[indexPath.section][@"goods"];
    if (datas.count > 0) {
        cell.dicData = datas[indexPath.row];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //    NSString * str = self.dataArray[section];
    static NSString *viewIdentfier = @"headView";
    OrderHeadView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    if(!sectionHeadView){
        sectionHeadView = [[OrderHeadView alloc] initWithReuseIdentifier:viewIdentfier];
    }
    NSDictionary * stateDic = self.dataArray[section][@"state_text"];
    sectionHeadView.stateLable.text = stateDic[@"text"];
    sectionHeadView.orderNumLable.text = [NSString stringWithFormat:@"订单编号:%@",self.dataArray[section][@"order_no"]];
    return sectionHeadView;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    MJWeakSelf;
    NSDictionary * stateDic = self.dataArray[section][@"state_text"];
    NSInteger is_refund_type = [self.dataArray[section][@"is_refund_type"]integerValue];
    NSString * str = stateDic[@"value"];
    static NSString *viewIdentfier = @"footView";
    OrderFootView *sectionFootView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    if(!sectionFootView){
        sectionFootView = [[OrderFootView alloc] initWithReuseIdentifier:viewIdentfier];
        sectionFootView.backgroundColor = [UIColor blueColor];
    }
    NSString * priceString = self.dataArray[section][@"pay_price"];
    NSArray *datas = self.dataArray[section][@"goods"];
    NSInteger sum = 0;
    for (NSDictionary * dic  in datas) {
        sum += [dic[@"total_num"]integerValue];
    }
    sectionFootView.priceLable.text = [NSString stringWithFormat:@"共%ld件商品 实付款￥%@",(long)sum,priceString];
    if ([str intValue] == 10) {
        sectionFootView.leftButn.hidden = YES;
        sectionFootView.centerButn.hidden = NO;
        sectionFootView.rightButn.hidden = NO;
        sectionFootView.centerTitle = @"取消订单";
        sectionFootView.rightTitle = @"去付款";
    }else if ([str intValue] == 20){
        sectionFootView.leftButn.hidden = YES;
        sectionFootView.centerButn.hidden = YES;
        sectionFootView.rightButn.hidden = NO;
        sectionFootView.rightTitle = @"申请退款";
    }else if ([str intValue] == 30){
        is_refund_type = [self.dataArray[section][@"is_refund_type"]integerValue];
          sectionFootView.leftButn.hidden = YES;
        if (is_refund_type == 0) {
            sectionFootView.leftButn.hidden = YES;
        }else if (is_refund_type == 1){
            sectionFootView.leftTitle = @"申请退款";
              sectionFootView.leftButn.hidden = NO;
        }else{
            sectionFootView.leftTitle = @"申请售后";
              sectionFootView.leftButn.hidden = NO;
        }
        sectionFootView.centerTitle = @"查看物流";
        sectionFootView.rightTitle = @"确认收货";
        sectionFootView.centerButn.hidden = NO;
        sectionFootView.rightButn.hidden = NO;
        
        sectionFootView.leftBtnClick = ^(UIButton * _Nonnull btn) {
            NSLog(@"申请退款");
            [self aftermarketCilck:[NSString stringWithFormat:@"%@",self.dataArray[section][@"order_id"]]];
        };
        sectionFootView.centerBtnClick = ^(UIButton * _Nonnull btn) {
            NSLog(@"查看物流");
            [weakSelf lookExpress:[NSString stringWithFormat:@"%@",self.dataArray[section][@"order_id"]]];
        };
        sectionFootView.rightBtnClick = ^(UIButton * _Nonnull btn) {
            NSLog(@"确认收货");
            [weakSelf confirmGoods:[NSString stringWithFormat:@"%@",self.dataArray[section][@"order_id"]]];
        };
    }
    
    return sectionFootView;
}


#pragma mark 查看物流

- (void)lookExpress:(NSString*)order_id{
    NCLookLogisticsVC * vc = [[NCLookLogisticsVC alloc]init];
    vc.order_id = order_id;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 申请退款
- (void)refundClick:(NSString*)order_id{
    RefundRequestVC * vc = [[RefundRequestVC alloc]init];
    vc.order_id = order_id;
    vc.status = OrderStatusNotArrive;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark 确定收货
- (void)confirmGoods:(NSString*)order_id{
    [NetWorkConnection postURL:@"api/user.order/receipt" param:@{@"order_id":order_id} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            ShowHUD(@"收货成功");
            [self.tableView.mj_header beginRefreshing];
        }else{
            ShowErrorHUD(responseMessage);
        }
        
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark 申请售后
- (void)aftermarketCilck:(NSString*)order_id{
    
    PopBottomView * cancelView = [[PopBottomView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withDataSource:@[@{@"text":@"已收到货",@"value":@"1"},@{@"text":@"未收到货",@"value":@"2"}]];
    [[UIApplication sharedApplication].keyWindow addSubview:cancelView];
    cancelView.selectIndexClick = ^(NSIndexPath * _Nonnull indexPath) {
        if (indexPath.row == 0) {
            AftermarketVC * vc = [[AftermarketVC alloc]init];
            vc.order_id = order_id;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            RefundRequestVC * vc = [[RefundRequestVC alloc]init];
            vc.order_id = order_id;
            vc.status = OrderStatusNotArrive;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 107;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MJWeakSelf;
    OrderDetailVC * vc = [[OrderDetailVC alloc]init];
    vc.order_id = self.dataArray[indexPath.section][@"order_id"];
    [self.navigationController pushViewController:vc animated:YES];
    //    MyOrderDetailVC * vc = [[MyOrderDetailVC alloc]init];
    //    NSDictionary *dic = self.dataArray[indexPath.section];
    //    vc.order_idStr = [NSString stringWithFormat:@"%@",dic[@"order_id"]];
    //    vc.blcok = ^{
    //        [weakSelf getData];
    //    };
    //    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableArray *)dataArray{
    if (_dataArray ==nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


- (UITableView *)tableView{
    if (!_tableView) {
        
        if (self.is_SegmentViewH) {
            _tableView = [[UITableView alloc]initWithFrame:CGRectInset(CGRectMake(0, 0, ScreenWidth , ScreenHeight - SafeAreaTopHeight - 45 ), 10, 0) style:UITableViewStyleGrouped];
        }else{
            _tableView = [[UITableView alloc]initWithFrame:CGRectInset(CGRectMake(0, 0, ScreenWidth , ScreenHeight), 10, 0) style:UITableViewStyleGrouped];
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionFooterHeight = 90;
        _tableView.estimatedSectionHeaderHeight = 39;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

@end

