//
//  MyOrderRefundVC.m
//  TSYCAPP
//
//  Created by Mac on 2019/8/15.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "MyOrderRefundVC.h"
#import "MyOrderOneCell.h"
#import "OrderDetailVC.h"
#import "OrderHeadView.h"
#import "OrderFootView.h"
#import "AfterOrderDetailVC.h"
#import "AfterorderTwoVC.h"
@interface MyOrderRefundVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)UITableView * tableView;


@end
static NSString * cellID111 = @"MyOrderOneCell";
@implementation MyOrderRefundVC


- (void)viewDidLoad{
     [super viewDidLoad];
    self.title = @"售后管理";
    [self.view addSubview:self.tableView];
    self.tableView.separatorColor = kUIColorFromRGB(0xF1F4F8);
    self.tableView.backgroundColor = kUIColorFromRGB(0xF1F4F8);
    [self.tableView registerNib:[UINib nibWithNibName:cellID111 bundle:nil] forCellReuseIdentifier:cellID111];
    
    if (ScreenHeight>=812) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, - 20, 0);
    }
//    [self getData];
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
    [NetWorkConnection postURL:@"api/user.refund/lists" param:@{@"page":[NSString stringWithFormat:@"%ld",(long)self.page]} success:^(id responseObject, BOOL success) {
        if (responseDataSuccess) {
            if (self.dataArray.count > 0 && self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            NSLog(@"售后订单数据====%@",responseJSONString);
            NSDictionary * dic = responseObject[@"data"][@"list"];
            NSArray * data = dic[@"data"];
            for (NSDictionary *dic in data) {
                [self.dataArray addObject:dic];
            }
            
            if (self.dataArray.count == 0) {
                [self showEmptyViewWithLoading:NO image:CCImage(@"wushuju") text:@"暂无数据" detailText:@"你还没有订单哦~" buttonTitle:@"点击重试" buttonAction:@selector(getData)];
            }else{
                [self hideEmptyView];
                
            }
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } fail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self showEmptyViewWithLoading:NO image:CCImage(@"wuwangluo") text:@"加载失败" detailText:@"请检查网络是否异常" buttonTitle:@"点击重试" buttonAction:@selector(getData)];
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * datas = self.dataArray[section][@"order_goods"];
    return datas.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSDictionary * dic = self.dataArray[section];
    return 90;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     static NSString *viewIdentfier = @"headView";
       OrderHeadView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
       if(!sectionHeadView){
           sectionHeadView = [[OrderHeadView alloc] initWithReuseIdentifier:viewIdentfier];
       }
       NSDictionary * stateDic = self.dataArray[section][@"state_text"];
    NSDictionary * noDic = self.dataArray[section][@"order_master"];
       sectionHeadView.stateLable.text = stateDic[@"text"];
       sectionHeadView.orderNumLable.text = [NSString stringWithFormat:@"订单编号:%@",noDic[@"order_no"]];
       
       return sectionHeadView;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSDictionary * payDic = self.dataArray[section][@"order_master"];
   static NSString *viewIdentfier = @"footView";
    OrderFootView *sectionFootView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    if(!sectionFootView){
        sectionFootView = [[OrderFootView alloc] initWithReuseIdentifier:viewIdentfier];
        sectionFootView.backgroundColor = [UIColor blueColor];
    }
    NSString * priceString = payDic[@"pay_price"];
    NSArray *datas = self.dataArray[section][@"order_goods"];
    NSInteger sum = 0;
    for (NSDictionary * dic  in datas) {
        sum += [dic[@"total_num"]integerValue];
    }
    sectionFootView.priceLable.text = [NSString stringWithFormat:@"共%ld件商品 实付款￥%@",(long)sum,priceString];
    sectionFootView.rightButn.hidden = NO;
    sectionFootView.rightTitle = @"查看详情";
    sectionFootView.centerButn.hidden = YES;
    sectionFootView.leftButn.hidden = YES;
    sectionFootView.rightBtnClick = ^(UIButton * _Nonnull btn) {

        NSDictionary *dic = self.dataArray[section];
        NSInteger value = [dic[@"state_text"][@"value"]integerValue];
        if (value == 4 | value == 5 | value == 6) {
              AfterorderTwoVC * vc = [[AfterorderTwoVC alloc]init];
            vc.order_id = dic[@"order_refund_id"];
             vc.value = [dic[@"state_text"][@"value"]integerValue];
              [self.navigationController pushViewController:vc animated:YES];
          }else{
              AfterOrderDetailVC * vc = [[AfterOrderDetailVC alloc]init];
              vc.order_id = dic[@"order_refund_id"];
              vc.value = [dic[@"state_text"][@"value"]integerValue];
              [self.navigationController pushViewController:vc animated:YES];
          }
    };
    return sectionFootView;
}

#pragma mark  去发货
- (void)goShipments:(NSDictionary*)dic{
//    FillInformationVC * vc = [FillInformationVC new];
//    vc.order_id = [NSString stringWithFormat:@"%@",dic[@"order_id"]];
//    vc.is_Refund = YES;
//    vc.block = ^{
//        [self getData];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MyOrderOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID111];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *datas = self.dataArray[indexPath.section][@"order_goods"];
    
    if (datas.count > 0) {
        cell.dicData = datas[indexPath.row];
    }
    cell.index = indexPath.row;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 99;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.dataArray[indexPath.section];
    NSInteger value = [dic[@"state_text"][@"value"]integerValue];
    if (value == 4 | value == 5 | value == 6) {
        AfterorderTwoVC * vc = [[AfterorderTwoVC alloc]init];
        vc.order_id = dic[@"order_refund_id"];
         vc.value = [dic[@"state_text"][@"value"]integerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        AfterOrderDetailVC * vc = [[AfterOrderDetailVC alloc]init];
        vc.order_id = dic[@"order_refund_id"];
        vc.value = [dic[@"state_text"][@"value"]integerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
//    OrderDetailVC * vc = [[OrderDetailVC alloc]init];
//    vc.order_id = dic[@"order_id"];
//    [self.navigationController pushViewController:vc animated:YES];
//    OrderRefundDetailVC * vc = [[OrderRefundDetailVC alloc]init];
//    vc.orderID = dic[@"order_id"];
//    vc.blockUpData = ^{
//        [self getData];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
}





-(NSMutableArray *)dataArray{
    if (_dataArray ==nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        if (self.is_SegmentViewH) {
            _tableView = [[UITableView alloc]initWithFrame:CGRectInset(CGRectMake(0, 0, ScreenWidth , ScreenHeight - SafeAreaTopHeight - 45 ), 10, 0) style:UITableViewStyleGrouped];
        }else{
            _tableView = [[UITableView alloc]initWithFrame:
                          CGRectInset(CGRectMake(0, 0, ScreenWidth , ScreenHeight), 10, 0)  style:UITableViewStyleGrouped];
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
