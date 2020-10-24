//
//  TeamVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "TeamVC.h"
#import "TeamCell.h"
#import "TeamHeadView.h"
#import "TeamModel.h"
@interface TeamVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property(nonatomic,strong)TeamHeadView *headView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

static NSString * cellOneID = @"TeamCell";
@implementation TeamVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"TeamHeadView" owner:self options:nil] lastObject];
    self.tableView.tableHeaderView = self.headView;
    [self.tableView registerNib:[UINib nibWithNibName:cellOneID bundle:nil] forCellReuseIdentifier:cellOneID];

        [self getData];
}

-(void)getData{
    MJWeakSelf;
    [NetWorkConnection postURL:@"api/signed.order/brokerage" param:@{@"page":@"1"} success:^(id responseObject, BOOL success) {
        NSLog(@"我的团员页面信息=====%@",responseJSONString);
        if (responseSuccess) {
       NSDictionary * aggregate = responseObject[@"data"][@"aggregate"];
            if ([aggregate[@"add_type"] intValue] == 1) {
                [weakSelf.headView.addbutn setTitle:@"添加团队长" forState:UIControlStateNormal];
            }else if ([aggregate[@"add_type"] intValue] == 2){
                [weakSelf.headView.addbutn setTitle:@"添加团员" forState:UIControlStateNormal];
              //0没有添加权限1可添加团队长2可添加团员
            }else{
                weakSelf.headView.addbutn.hidden = YES;
            }
       [self.headView getDataDic:aggregate];
       NSArray * data = responseObject[@"data"][@"user_list"][@"data"];
            for (NSDictionary *dic in data) {
                NSDictionary *dic1 = dic[@"info"];
                TeamModel *model = [TeamModel mj_objectWithKeyValues:dic1];
                [self.dataArray addObject:model];
            }
            
            if (self.dataArray.count == 0) {
                [QMUITips showInfo:@"暂无数据"];
            }else{
                self.headView.countLabel.text = [NSString stringWithFormat:@"团员明细 共有%lu人",(unsigned long)self.dataArray.count];
            }
            
        }else{
            ShowErrorHUD(responseMessage);
           
        }
       
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TeamCell *cell = [tableView dequeueReusableCellWithIdentifier:cellOneID];
    TeamModel *model = self.dataArray[indexPath.section];
    cell.model = model;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}





-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kTabBarHeight ) style:UITableViewStylePlain];
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
