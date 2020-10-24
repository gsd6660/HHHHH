//
//  WithdrawDepositVC.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/1.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "WithdrawDepositVC.h"
#import "OrderPayCell.h"
#import "WithdrawDepositSucceeVC.h"
#import "AddBankCardVC.h"
#import "BankCardListVC.h"
@interface WithdrawDepositVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _isShowArray;
}
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)NSString * payType;
@property (nonatomic,strong)NSString * money;
@property (nonatomic,strong)NSString * isexist;
@property (strong, nonatomic) NSString *service_charge;

@end

static NSString * orderPayCellID = @"OrderPayCell";

@implementation WithdrawDepositVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.payType = @"1";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:orderPayCellID bundle:nil] forCellReuseIdentifier:orderPayCellID];
    self.tableView.tableFooterView = [UIView new];
    [self loadData];
}


- (IBAction)allbutn:(UIButton *)sender {
    self.numTF.text = self.money;
}



- (void)loadData{
    [NetWorkConnection postURL:self.urlStr param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"提现页面=====%@",responseJSONString);
        if (responseSuccess) {
            NSDictionary * dic = responseObject[@"data"];
            self.sumLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"money"]];
            self.money = [NSString stringWithFormat:@"%@",dic[@"money"]];
            self.numTF.text = self.money;
            self.service_charge = dic[@"service_charge"];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderPayCell * cell = [tableView dequeueReusableCellWithIdentifier:orderPayCellID];
    NSDictionary * dic = self.dataArray[indexPath.row];
    [cell.imgView yy_setImageWithURL:[NSURL URLWithString:dic[@"image"]] placeholder:nil];
    cell.titleLabel.text = dic[@"name"];
    cell.balanceLabel.hidden = YES;
    
    if (_selIndex == indexPath) {
        [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_selected"] forState:UIControlStateNormal];
    }else{
        [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];
        
    }
    cell.hidden = [_isShowArray[indexPath.row]boolValue];
        if (indexPath.row==0) {//指定第一行为选中状态
            [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_selected"] forState:UIControlStateNormal];
            _selIndex = indexPath;
            
        }else{
            [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];
        }
      if (indexPath.row == 3) {
          MJWeakSelf;
           self.isexist = [NSString stringWithFormat:@"%@",dic[@"is_exist"]];
          if ([self.isexist intValue] == 0) {
              [cell.selectBtn setTitle:@"添加新卡" forState:0];
              [cell.selectBtn setImage:[UIImage imageNamed:@"jft_icon_rightarrow"] forState:0];
              cell.selectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
              [cell.selectBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                  AddBankCardVC * vc = [AddBankCardVC new];
                  vc.block = ^{
                      [weakSelf loadData];

                  };
                  [self.navigationController pushViewController:vc animated:YES];
              }];
          }else{
              [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];

          }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 3) {
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
    }else{
        OrderPayCell *celled = [tableView cellForRowAtIndexPath:_selIndex];
        [celled.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];
        //记录当前选中的位置索引
        _selIndex = indexPath;
        //当前选择的打勾
        OrderPayCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.isexist = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"is_exist"]];
       
         self.payType = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"pay_type"]];
         
        if ([self.isexist intValue] == 0) {
             [cell.selectBtn setImage: [UIImage imageNamed:@"jft_icon_rightarrow"] forState:UIControlStateNormal];
            BankCardListVC * vc = [BankCardListVC new];
                   [self.navigationController pushViewController:vc animated:YES];
        }else{
            [cell.selectBtn setImage: [UIImage imageNamed:@"jft_but_selected"] forState:UIControlStateNormal];

        }
       
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_isShowArray[indexPath.row]boolValue]) {
        return 0;
    }
    return 44;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 30)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    label.text = @"提现到";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = kUIColorFromRGB(0x333333);
    [bgView addSubview:label];
    return bgView;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 15)];
    lable.text = self.service_charge;
    lable.font = [UIFont systemFontOfSize:14];
    lable.textColor = [UIColor grayColor];
    [bgView addSubview:lable];

    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = kUIColorFromRGB(0x3ACD7B);
    [btn setTitle:@"确认提现" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.layer.cornerRadius = 19;
    btn.layer.masksToBounds = YES;
    [bgView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.equalTo(bgView.mas_left).offset(45);
        make.right.equalTo(bgView.mas_right).offset(-45);
        make.height.offset(38);
    }];
    MJWeakSelf;
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf commitData];
    }];
    return bgView;
}



-(void)commitData{
    MJWeakSelf;
    [QMUITips showWithText:@"提交中..."];
    [NetWorkConnection postURL:self.submitUrlStr param:@{@"money":self.numTF.text,@"pay_type":self.payType} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {

            WithdrawDepositSucceeVC * vc = [[WithdrawDepositSucceeVC alloc]init];
            vc.money = self.numTF.text;
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
        [QMUITips hideAllTips];
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
