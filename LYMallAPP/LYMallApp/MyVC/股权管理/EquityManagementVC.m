//
//  EquityManagementVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "EquityManagementVC.h"
#import "EquityManagementCell.h"
@interface EquityManagementVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSString * type;

@end
static NSString *cellID = @"EquityManagementCell";
@implementation EquityManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.title isEqualToString:@"余额管理"]) {
        self.typeLable1.text = @"账户余额";
        self.typeLabel2.text = @"余额明细";
        self.type = @"2";
    }else if ([self.title isEqualToString:@"股权管理"]) {
        self.typeLable1.text = @"股权总数";
        self.typeLabel2.text = @"股权明细";
        self.type = @"4";

    }else if ([self.title isEqualToString:@"积分管理"]) {
        self.typeLable1.text = @"积分累计";
        self.typeLabel2.text = @"积分明细";
        self.type = @"5";

    }
    
    
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    
    self.tableView.tableFooterView = [UIView new];
    [self getData];
}


-(void)getData{
    [NetWorkConnection postURL:@"api/user/all_withdraw_log" param:@{@"type":self.type,@"page":@"1"} success:^(id responseObject, BOOL success) {
        NSLog(@"明细==%@===%@",self.type,responseJSONString);
        if (responseSuccess) {
            NSArray * data = responseObject[@"data"][@"list"][@"data"];
NSDictionary * top = responseObject[@"data"][@"top"];
            self.countLable.text = [NSString stringWithFormat:@"%@",top[@"total_num"]];
            for (NSDictionary *dic in data) {
                [self.dataArray addObject:dic[@"info"]];
     
            }
        }
        
        if (self.dataArray.count == 0) {
            [self showEmptyViewWithLoading:NO image:CCImage(@"wushuju") text:@"暂无数据" detailText:@"此页面没有数据哦" buttonTitle:@"点击重试" buttonAction:@selector(getData)];
        }else{
            [self hideEmptyView];
            
        }
        
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 93;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EquityManagementCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (self.dataArray.count > 0) {
        NSDictionary *dic = self.dataArray[indexPath.row];
        cell.dataDic = dic;
         cell.typeLable.text = [NSString stringWithFormat:@"%@",dic[@"surplus_num"]];
        
        if ([self.title isEqualToString:@"余额管理"]) {
            cell.typeLable.text = @"余额";
           }else if ([self.title isEqualToString:@"股权管理"]) {
               cell.typeLable.text = @"股权总数";
           }else if ([self.title isEqualToString:@"积分管理"]) {
             cell.typeLable.text = @"积分总数";
           }
        
        
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
