//
//  BankCardListVC.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/3.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BankCardListVC.h"
#import "BankCardListCell.h"
#import "BankCardLisModel.h"
#import "AddBankCardVC.h"
@interface BankCardListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray * dataArray;
@end
static NSString * cellOneID = @"BankCardListCell";

@implementation BankCardListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的银行卡";
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    [self.tableView registerNib:[UINib nibWithNibName:cellOneID bundle:nil] forCellReuseIdentifier:cellOneID];
    _page = 1;
    self.tableView.tableFooterView = [UIView new];
    MJWeakSelf;
    //    self.tableView.mj_footer = [MJRefreshHeader headerWithRefreshingBlock:^{
    //        [weakSelf requestData];
    //    }];
    
   
    [self requestData];
}


-(void)creatHead{
    MJWeakSelf;

    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
    footView.backgroundColor = [UIColor whiteColor];
    
    UIButton * addButn = [[UIButton alloc]initWithFrame:CGRectMake(9, 5, ScreenWidth - 18, 45)];
    addButn.backgroundColor = kUIColorFromRGB(0xF1F4F8);
    [addButn setTitle:@"+添加银行卡" forState:UIControlStateNormal];
    addButn.layer.cornerRadius = 5;
    [addButn setTitleColor:kUIColorFromRGB(0x7B8391) forState:UIControlStateNormal];
    [addButn addTarget:self action:@selector(addCard) forControlEvents:UIControlEventTouchUpInside];
//    [addButn addActionBlock:^(id sender) {
//        [weakSelf addCard];
//    } forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:addButn];
    
    self.tableView.tableFooterView = footView;
}

-(void)addCard{
    MJWeakSelf;
    AddBankCardVC * vc = [[AddBankCardVC alloc]init];
    vc.block = ^{
        [weakSelf requestData];
    };
    [weakSelf.navigationController pushViewController:vc animated:YES];
}

-(void)requestData{
    
    [NetWorkConnection postURL:@"api/user/bank_card_detail" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"银行卡信息====%@",responseJSONString);
        if (responseDataSuccess) {
            [self.dataArray removeAllObjects];
            NSDictionary * data = responseObject[@"data"];
            if (data.count > 0) {
                    BankCardLisModel * model = [BankCardLisModel mj_objectWithKeyValues:data];
                    [self.dataArray addObject:model];
            }
            
            [self.tableView reloadData];
            
            
        }if (self.dataArray.count == 0) {
            [self showEmptyViewWithImage:CCImage(@"wushuju") text:@"你还没有添加银行卡" detailText:@"" buttonTitle:@"点击添加" buttonAction:@selector(addCard)];
        }else{
//             [self creatHead];
            [self hideEmptyView];
        }
    } fail:^(NSError *error) {
         [self showEmptyViewWithImage:CCImage(@"wushuju") text:@"暂无数据" detailText:@"没有数据或者加载失败" buttonTitle:@"点击重试" buttonAction:@selector(requestData) ];
    }];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = kUIColorFromRGB(0xF0F2F4);
    return view;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BankCardListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellOneID];
    cell.bankNamelbale.font = FONTSIZE(15);
    cell.desLable.font = FONTSIZE(14);
    
    if (self.dataArray.count > 0) {
        BankCardLisModel * model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        BankCardLisModel * model = self.dataArray[indexPath.row];
       
        [NetWorkConnection postURL:@"api/user/delete_bank" param:@{@"bank_id":[NSString stringWithFormat:@"%@",model.ID]} success:^(id responseObject, BOOL success) {
            if (responseDataSuccess) {
                //确定 即为删除 用数据源_dataArray移除掉对应的数据
                [_dataArray removeObjectAtIndex:indexPath.row];
                //移除后在将tableView对应的行删除刷新
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self requestData];
                if (self.block) {
                    self.block();
                }
            }
        } fail:^(NSError *error) {
            
        }];
        
        
        
    }
}


-(void)deleteCardListData:(NSIndexPath *)indexPath{
    BankCardLisModel * model = self.dataArray[indexPath.row];

    NSInteger index = [self.dataArray indexOfObject:model];
    [self.dataArray removeObject:model];
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation: UITableViewRowAnimationTop];
    [self.tableView reloadData];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MJWeakSelf;

            AddBankCardVC * vc = [[AddBankCardVC alloc]init];
            vc.type = @"编辑";
            vc.block = ^{
                [weakSelf requestData];
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
