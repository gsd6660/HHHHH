//
//  BonusManagementVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BonusManagementVC.h"
#import "EquityManagementCell.h"
#import "XinWithdrawVC.h"
@interface BonusManagementVC ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLable1;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable2;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable3;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable4;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSDictionary * dataDic;

@end
static NSString *cellID = @"EquityManagementCell";

@implementation BonusManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emptyView = [[QMUIEmptyView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, ScreenHeight - 200)];

    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.tableFooterView = [UIView new];
    if ([self.title isEqualToString:@"奖金管理"]) {
       
        self.type = @"3";
    }else if ([self.title isEqualToString:@"收益管理"]) {
        self.type = @"6";

    }
    
        
    [self getData];
}

-(void)showEmptyView{
    self.emptyView.center = self.tableView.center;
    [self.view addSubview:self.emptyView];

}


-(void)getData{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/user/all_withdraw_log" param:@{@"type":self.type,@"page":@"1"} success:^(id responseObject, BOOL success) {
        NSLog(@"明细==%@===%@",self.type,responseJSONString);
        if (responseSuccess) {
            NSArray * data = responseObject[@"data"][@"list"][@"data"];
            self.dataDic = responseObject[@"data"][@"top"];
            [self setValueUI:self.dataDic];
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

- (IBAction)withdrawButn:(UIButton *)sender {
    if ([self.dataDic[@"is_withdraw"] boolValue] == YES) {
        XinWithdrawVC * vc = [XinWithdrawVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ShowErrorHUD(@"你当前还不能提现");
    }
    
}



-(void)setValueUI:(NSDictionary *)dic{
    self.lable1.text = [NSString stringWithFormat:@"%@",dic[@"total_str"]];
    self.moneyLable1.text = [NSString stringWithFormat:@"%@",dic[@"total_num"]];

    self.lable2.text = [NSString stringWithFormat:@"%@",dic[@"list"][0][@"str"]];
    self.lable3.text = [NSString stringWithFormat:@"%@",dic[@"list"][1][@"str"]];
    self.lable4.text = [NSString stringWithFormat:@"%@",dic[@"list"][2][@"str"]];
    self.lable5.text = [NSString stringWithFormat:@"%@",dic[@"type_name"]];
    
    self.moneyLable2.text = [NSString stringWithFormat:@"%@",dic[@"list"][0][@"money"]];
    self.moneyLable3.text = [NSString stringWithFormat:@"%@",dic[@"list"][1][@"money"]];
    self.moneyLable4.text = [NSString stringWithFormat:@"%@",dic[@"list"][2][@"money"]];

    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 93;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EquityManagementCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (self.dataArray.count > 0) {
        NSDictionary *dic = self.dataArray[indexPath.section];
        cell.dataDic = dic;
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
