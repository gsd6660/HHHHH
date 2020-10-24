//
//  CouponOneVC.m
//  LYMallApp
//
//  Created by CC on 2020/3/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CouponOneVC.h"
#import "CouponOneCell.h"
#import "CouponModel.h"
@interface CouponOneVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tabeleView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)NSInteger page;

@end
static NSString *cellID = @"CouponOneCell";
@implementation CouponOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self.view addSubview:self.tabeleView];

    MJWeakSelf;
      self.tabeleView.mj_header =  [YMRefreshHeader headerWithRefreshingBlock:^{
          weakSelf.page = 1;
          [weakSelf getListData];
      }];
    self.tabeleView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf getListData];
    }];
    [self getListData];
}


-(void)getListData{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/user.coupon/lists" param:@{@"data_type":self.data_type,@"page":@(self.page)} success:^(id responseObject, BOOL success) {
        NSLog(@"优惠券列表====%@",responseJSONString);
        NSArray * list = responseObject[@"data"][@"list"];

        if (responseSuccess) {
            [self.dataArray removeAllObjects];
            if (list.count > 0) {
              [self hideEmptyView];
                for (NSDictionary *dic in list) {
                    CouponModel * model = [CouponModel mj_objectWithKeyValues:dic];
                    [self.dataArray addObject:model];
                }
            }
            
            if (self.dataArray.count == 0) {
                [self showEmptyViewWithImage:CCImage(@"wushuju") text:@"暂无数据" detailText:@"没有数据或者加载失败" buttonTitle:@"点击重试" buttonAction:@selector(getListData) ];
            }

            [self.tabeleView reloadData];
            [self.tabeleView.mj_header endRefreshing];
            [self.tabeleView.mj_footer endRefreshing];
            if (list.count == 0) {
                [self.tabeleView.mj_footer endRefreshingWithNoMoreData];
            }

        }
    } fail:^(NSError *error) {
//        [self hideEmptyView];

        [self showEmptyViewWithImage:CCImage(@"wushuju") text:@"暂无数据" detailText:@"没有数据或者加载失败" buttonTitle:@"点击重试" buttonAction:@selector(getListData) ];
    }];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc]init];
    head.backgroundColor = kUIColorFromRGB(0xf9f9f9);
    return head;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponOneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CouponModel * model = self.dataArray[indexPath.section];
    cell.model = model;
    
    
    return cell;
}


-(UITableView *)tabeleView{
    if (_tabeleView == nil) {
        _tabeleView = [[UITableView alloc]initWithFrame:CGRectInset(CGRectMake(0, 0, ScreenWidth, ScreenHeight - kBottomSafeHeight - SafeAreaTopHeight), 10, 0) style:UITableViewStylePlain];
        _tabeleView.delegate = self;
        _tabeleView.dataSource =self;
        _tabeleView.backgroundColor = [UIColor clearColor];
        _tabeleView.showsVerticalScrollIndicator = NO;
        _tabeleView.estimatedSectionHeaderHeight = 10;
        _tabeleView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tabeleView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
        _tabeleView.tableFooterView = [UIView new];
    }
    return _tabeleView;
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
