//
//  XinWithdrawVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/29.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "XinWithdrawVC.h"
#import "OrderPayCell.h"
#import "WithdrawDepositSucceeVC.h"
#import "AddBankCardVC.h"
#import "BankCardListVC.h"
@interface XinWithdrawVC (){
    NSArray * _isShowArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *jiangjinLable;
@property (weak, nonatomic) IBOutlet UIButton *withdrawButn;
@property (strong, nonatomic) UILabel *service_chargeLable;

@property (weak, nonatomic) IBOutlet UITextField *glodTF;

@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)NSString * payType;
@property (nonatomic,strong)NSString * withdrawType;
@property (nonatomic,strong)NSString * isexist;//0不满足 1满足(没有填写银行卡或支付宝信息等)
@property (nonatomic,strong)NSString * money;
@property (nonatomic,strong)NSDictionary * dataDic;

@end
static NSString * orderPayCellID = @"OrderPayCell";

@implementation XinWithdrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
//    [self getData];
    [self setHeadandFootView];
    [self.tableView registerNib:[UINib nibWithNibName:orderPayCellID bundle:nil] forCellReuseIdentifier:orderPayCellID];

    [self requestData];
}


-(void)requestData{
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [self loadGoldInfo:^(BOOL isSuc) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self loadWallInfo:^(BOOL isSuc) {
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [self loadBankInfo:^(BOOL isSuc) {
        dispatch_group_leave(group);
    }];
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
        
}


- (void)loadWallInfo:(void(^)(BOOL isSuc))request{
    [NetWorkConnection postURL:@"/api/task.wallet/info" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"银行卡信息====%@",responseJSONString);
        if (responseDataSuccess) {
            NSDictionary * dic = responseObject[@"data"];
//            self.money = [NSString stringWithFormat:@"%@",dic[@"money"]];
            
            NSArray * method = dic[@"method"];
            for (NSDictionary *dic1 in method) {
                [self.dataArray addObject:dic1];
            }
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    }];
        
    request(YES);
}


- (void)loadGoldInfo:(void(^)(BOOL isSuc))request{
    
    [NetWorkConnection postURL:@"/api/withdraw/gold" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"银行卡信息====%@",responseJSONString);
        if (responseDataSuccess) {
            self.jiangjinLable.text = responseObject[@"data"][@"gold"];
        }
    } fail:^(NSError *error) {
        
    }];
    request(YES);
    
}


- (void)loadBankInfo:(void(^)(BOOL isSuc))request{
    [NetWorkConnection postURL:@"/api/user/bank_card_detail" param:nil success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            self.dataDic = responseObject[@"data"];
            [self.tableView reloadData];
        }else{
            ShowErrorHUD(responseObject[@"msg"]);
        }
    } fail:^(NSError *error) {
        
    }];
}


-(void)setHeadandFootView{
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    lable.text = @"  提现到";
    self.tableView.tableHeaderView = lable;
    
    
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    
       UILabel * lable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 15)];
       lable1.font = [UIFont systemFontOfSize:14];
    lable1.adjustsFontSizeToFitWidth = YES;
       lable1.textColor = [UIColor grayColor];
      self.service_chargeLable =lable1;
       [footView addSubview:lable1];

    
    
    QMUIFillButton * butn = [[QMUIFillButton alloc]initWithFrame:CGRectMake(32, 45, ScreenWidth - 64, 38)];
    [butn setTitle:@"确认提现" forState:UIControlStateNormal];
    [footView addSubview:butn];
    [butn addTarget:self action:@selector(commitButn:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = footView;
    
    
}


-(void)commitButn:(UIButton *)btn{
    
    if (self.payType.length == 0) {
        ShowErrorHUD(@"请选择提现到哪");
        return;
    }
    [NetWorkConnection postURL:@"/api/task.wallet/withdraw" param:@{@"pay_type":self.payType} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            WithdrawDepositSucceeVC * vc = [[WithdrawDepositSucceeVC alloc]init];
            switch ([self.payType intValue]) {
                    case 1:
                    vc.payType = @"余额";
                    break;
                case 10:
                    vc.payType = @"微信";
                    break;
                 case 20:
                    vc.payType = @"支付宝";
                    break;
                case 30:
                    vc.payType = @"银行卡";
                    break;
                default:
                    break;
            }
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
            
    }];
}



-(void)getData{
    [NetWorkConnection postURL:@"api/withdraw/submit_info" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"新提现页面数据===%@",responseJSONString);
        if (responseSuccess) {
                   NSDictionary * dic = responseObject[@"data"];
                   self.money = [NSString stringWithFormat:@"%@",dic[@"money"]];
            self.jiangjinLable.text = dic[@"bonus_money"];
            self.service_chargeLable.text = dic[@"withdrawal_service_charge"];

                   NSArray * method = dic[@"method"];
                   for (NSDictionary *dic1 in method) {
                       [self.dataArray addObject:dic1];
                   }
                   [self.tableView reloadData];
               }else{
                   ShowErrorHUD(responseMessage);
               }
        
        
        
    } fail:^(NSError *error) {
        
    }];
}


//- (IBAction)selectWithDrawButn:(UIButton *)sender {
//    /// 1.单列字符串选择器（传字符串数组）
//    MJWeakSelf;
//      BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]initWithPickerMode:BRStringPickerComponentSingle];
//      stringPickerView.title = @"提现类型";
//      stringPickerView.dataSourceArr = @[@"提现奖金", @"提现收益"];
//      stringPickerView.selectIndex = 0;
//      stringPickerView.resultModelBlock = ^(BRResultModel *resultModel) {
//          NSLog(@"选择的值：%@", resultModel.selectValue);
//
//          [self.withdrawButn setTitle:resultModel.selectValue forState:UIControlStateNormal];
//          [self.withdrawButn setTitle:resultModel.selectValue forState:UIControlStateSelected];
//
//      };
//
//      [stringPickerView show];
//
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MJWeakSelf;
    OrderPayCell * cell = [tableView dequeueReusableCellWithIdentifier:orderPayCellID];
    NSDictionary * dic = self.dataArray[indexPath.row];
    [cell.imgView yy_setImageWithURL:[NSURL URLWithString:dic[@"image"]] placeholder:nil];
    cell.titleLabel.text = dic[@"name"];
    if (_selIndex == indexPath) {
        [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_selected"] forState:UIControlStateNormal];
    }else{
        [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];
    }
    if (indexPath.row==0) {//指定第一行为选中状态
        [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_selected"] forState:UIControlStateNormal];
        _selIndex = indexPath;
        self.payType =[NSString stringWithFormat:@"%@",dic[@"pay_type"]];
    }else{
        [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];
    }
    if ([dic[@"name"] isEqualToString:@"银行卡"]) {
        cell.balanceLabel.hidden = NO;
        if ([CheackNullOjb cc_isNullOrNilWithObject:self.dataDic] == NO) {
            cell.balanceLabel.text = [NSString stringWithFormat:@"%@ %@",self.dataDic[@"card_type"],self.dataDic[@"id_card"]];
            
        }else{
            cell.balanceLabel.text = @"添加银行卡";
            [cell.selectBtn setImage:CCImage(@"jft_icon_rightarrow") forState:UIControlStateNormal];
            
            [cell.selectBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                
            }];
        }
        
            
    }else{
        cell.balanceLabel.hidden = YES;
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
     if (indexPath.row == self.dataArray.count){
        if ([CheackNullOjb cc_isNullOrNilWithObject:self.dataDic]) {
            MJWeakSelf;
            AddBankCardVC * vc = [AddBankCardVC new];
            vc.block = ^{
                [weakSelf requestData];

            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        //之前选中的，取消选择
        OrderPayCell *celled = [tableView cellForRowAtIndexPath:_selIndex];
        [celled.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];

        //记录当前选中的位置索引
        _selIndex = indexPath;
        //当前选择的打勾
        OrderPayCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.selectBtn setImage: [UIImage imageNamed:@"jft_but_selected"] forState:UIControlStateNormal];
        self.payType = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"pay_type"]];
        NSLog(@"选择====%@",self.payType);
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_isShowArray[indexPath.row]boolValue]) {
        return 0;
    }
    return 44;
}




-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}



@end
