//
//  NCLookLogisticsVC.m
//  ElleShop
//
//  Created by xiuchanghui on 2017/7/14.
//  Copyright © 2017年 BeautyFuture. All rights reserved.
//

#import "NCLookLogisticsVC.h"
#import "OKLogisticsView.h"
#import "OKLogisticModel.h"
#import "OKConfigFile.h"

@interface NCLookLogisticsVC ()

@property (nonatomic,strong) NSMutableArray * dataArry;

@end

@implementation NCLookLogisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:nckColor(0xececec)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"物流信息";
    [self getData];
}

-(void)getData{
    [self showEmptyViewWithLoading];
    NSString * url;
    NSDictionary * parmDic;
    if (self.is_refund == 1) {
        url = @"api/user.refund/express_info";
        parmDic = @{@"order_refund_id":self.order_id,@"type":self.typeString};
    }if (self.is_refund == 2) {
        url = @"api/user.cycle/express";
        parmDic = @{@"cycle_id":self.order_id};
    }
    else{
        url = @"api/user.order/express";
        parmDic = @{@"order_id":self.order_id};
    }
    [NetWorkConnection postURL:url param:parmDic success:^(id responseObject, BOOL success) {
        NSLog(@"我的快递信息=====%@",responseJSONString);
        NSDictionary * dataDic = responseObject[@"data"];
        if (responseDataSuccess) {
            NSArray * dataArray = dataDic[@"express"][@"list"];
            NSMutableArray * timeArr= [NSMutableArray array];
            NSMutableArray * contentArr = [NSMutableArray array];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [timeArr addObject:obj[@"time"]];
                [contentArr addObject:obj[@"context"]];
            }];
           for (NSInteger i = 0;i<timeArr.count ; i++) {
               OKLogisticModel * model = [[OKLogisticModel alloc]init];
               model.dsc = [contentArr objectAtIndex:i];
               model.date = [timeArr objectAtIndex:i];
               [self.dataArry addObject:model];
           }
            OKLogisticsView * logis = [[OKLogisticsView alloc]initWithDatas:self.dataArry];
            logis.number = dataDic[@"express"][@"express_no"];
            logis.company = dataDic[@"express"][@"express_name"];
            logis.frame = CGRectMake(0, 64, OKScreenWidth, OKScreenHeight-64);
            [self.view addSubview:logis];
        }else{
//            [QMUITips showInfo:responseMessage];
            [self showEmptyViewWithImage: [UIImage imageNamed:@"wushuju"]  text:@"暂无物流信息" detailText:@"没有发现物流信息" buttonTitle:@"再试一次" buttonAction:@selector(getData) ];
        }
        if (self.dataArry.count == 0) {
            [self showEmptyViewWithImage:[UIImage imageNamed:@"wushuju"]  text:@"暂无数据" detailText:@"没有发现物流信息" buttonTitle:@"再试一次" buttonAction:@selector(getData) ];
        }else{
            [self hideEmptyView];
        }
        
        
    } fail:^(NSError *error) {
         
        [self showEmptyViewWithImage:[UIImage imageNamed:@"wushuju"]  text:@"暂无数据" detailText:@"没有数据或者加载失败" buttonTitle:@"点击重试" buttonAction:@selector(getData) ];
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSMutableArray *)dataArry {
    if (!_dataArry) {
        _dataArry = [NSMutableArray array];
    }
    return _dataArry;
}

@end
