//
//  MySubscriptiveTwoVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MySubscriptiveTwoVC.h"
#import "MySubscripOneCell.h"
@interface MySubscriptiveTwoVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

static NSString * cellID = @"MySubscripOneCell";

@implementation MySubscriptiveTwoVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self getData];
}

-(void)getData{
    
        [NetWorkConnection postURL:@"api/user.order/subscript_list" param:@{@"dataType":@"2"} success:^(id responseObject, BOOL success) {
            NSLog(@"订阅订单列表待收货==%@",responseJSONString);
            if (responseSuccess) {
            if ([responseObject[@"data"] count] == 0) {
                [self showEmptyViewWithImage:CCImage(@"wushuju") text:@"暂无数据" detailText:@"" buttonTitle:@"点击重试" buttonAction:@selector(getData)];

                return ;
            }
            NSArray * data = responseObject[@"data"][@"list"];
            [self.dataArray removeAllObjects];
            for (NSDictionary *dic in data) {
                [self.dataArray addObject:dic];
            }
            
            if (self.dataArray.count == 0) {
                        [self showEmptyViewWithImage:CCImage(@"wushuju") text:@"暂无数据" detailText:@"" buttonTitle:@"点击重试" buttonAction:@selector(getData)];
            }
            [self.tableView reloadData];
            }
        } fail:^(NSError *error) {
        }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MySubscripOneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count >0) {
        NSDictionary *dic = self.dataArray[indexPath.section];
        [cell getDataDic:dic];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 188;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}



-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectInset(CGRectMake(0, 0, ScreenWidth, ScreenHeight - 250 ), 10, 0) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedSectionFooterHeight = 0.01;
        _tableView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _tableView.estimatedSectionHeaderHeight = 10;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
        
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
