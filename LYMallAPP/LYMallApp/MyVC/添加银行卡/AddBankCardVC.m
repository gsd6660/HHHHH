//
//  AddBankCardVC.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/2.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AddBankCardVC.h"
#import "AddBankCardCell.h"
@interface AddBankCardVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSArray * _titleArray;
    NSArray * _placeholderArray;
    UIButton * sendBtn;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableDictionary * parmDic;
@property (nonatomic,strong)NSMutableArray * bankList;
@property (nonatomic,strong)UITextField * nameTF;
@property (nonatomic,strong)UITextField * bankNameTF;
@property (nonatomic,strong)UITextField * cardNumTF;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * codeTF;

@end

static NSString * CellID = @"AddBankCardCell";

@implementation AddBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:CellID bundle:nil] forCellReuseIdentifier:CellID];
    _titleArray = @[@"持卡人",@"开户行",@"银行卡号",@"手机号",@"手机验证码"];
    _placeholderArray = @[@"请输入您的真实姓名",@"请选择银行",@"请输入银行卡号",@"请输入银行预留手机号码",@"请输入验证码"];
    self.tableView.tableFooterView = [UIView new];
    [self getBankList];
    [self requestData];
}
-(void)requestData{
    
    [NetWorkConnection postURL:@"api/user/bank_card_detail" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"银行卡信息====%@",responseJSONString);
        if (responseDataSuccess) {
            self.parmDic = responseObject[@"data"];;
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
         
    }];
}

- (void)getBankList{
    [NetWorkConnection postURL:@"api/user/often_bank" param:nil success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            NSArray * data = responseObject[@"data"];
            for (NSString *str in data) {
                [self.bankList addObject:str];
            }
        }
    } fail:^(NSError *error) {
        ShowErrorHUD(@"获取银行列表失败");
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    bgView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 20)];
    label.text = @"添加银行卡信息";
    label.textColor = kUIColorFromRGB(0x333333);
    label.font = [UIFont systemFontOfSize:13];
    [bgView addSubview:label];
    return bgView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    bgView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = kUIColorFromRGB(0x3ACD7B);
    [button setTitle:@"确认" forState:0];
    [button setTitleColor:[UIColor whiteColor] forState:0];
    button.frame = CGRectMake(45, 20, ScreenWidth - 90, 40);
    button.layer.cornerRadius = 20;
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [self updateBankInfo];
    }];
    [bgView addSubview:button];
    return bgView;
}

- (void)updateBankInfo{
    if ([self.nameTF.text length] == 0) {
        ShowErrorHUD(@"请输入您的真实姓名");
        return;
    }
    if ([self.cardNumTF.text length] == 0) {
        ShowErrorHUD(@"请输入银行卡号");
        return;
    }
    if ([self.phoneTF.text length] == 0) {
        ShowErrorHUD(@"请输入银行预留手机号码");
        return;
    }
    if (![LCRegExpTool lc_checkingMobile:self.phoneTF.text]) {
        ShowErrorHUD(@"请输入正确的手机号码");
        return;
    }
    if ([self.codeTF.text length] == 0) {
        ShowErrorHUD(@"请输入验证码");
        return;
    }
    
    [NetWorkConnection postURL:@"api/user/update_bank_card" param:@{@"card_type":self.bankNameTF.text,@"account_name":self.nameTF.text,@"id_card":self.cardNumTF.text,@"phone":self.phoneTF.text,@"code":self.codeTF.text} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            ShowHUD(@"添加成功");
            if (self.block) {
                self.block();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddBankCardCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.descTF.delegate = self;
    cell.descTF.tag = 1000+indexPath.row;
    cell.titleLabel.text = _titleArray[indexPath.row];
    cell.descTF.placeholder = _placeholderArray[indexPath.row];
    if (indexPath.row == 4) {
        cell.getCodeBtn.hidden = NO;
        self.codeTF = cell.descTF;
        sendBtn = cell.getCodeBtn;
        [cell.getCodeBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [self senderCode];
        }];
    }else{
        cell.getCodeBtn.hidden = YES;
    }
    if (indexPath.row == 0) {
        cell.descTF.text = self.parmDic[@"account_name"];
        self.nameTF = cell.descTF;
    }if (indexPath.row == 2) {
        cell.descTF.text = self.parmDic[@"id_card"];
        self.cardNumTF = cell.descTF;

    }if (indexPath.row == 3) {
        cell.descTF.text = self.parmDic[@"phone"];
        self.phoneTF = cell.descTF;

    }
    if (indexPath.row == 1) {
        cell.descTF.enabled = NO;
        self.bankNameTF = cell.descTF;

        cell.descTF.text = self.parmDic[@"card_type"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.descTF.enabled = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MJWeakSelf;
    if (indexPath.row == 1) {
        if (self.bankList.count==0) {
            [self getBankList];
        }else{
            [BRStringPickerView showStringPickerWithTitle:@"选择银行卡" dataSource:self.bankList defaultSelValue:nil resultBlock:^(id selectValue) {
                NSLog(@"%@",selectValue);
                weakSelf.bankNameTF.text = selectValue;
            }];
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1000:
            textField.keyboardType = UIKeyboardTypeDefault;
            break;
        case 1002:
        case 1003:
        case 1004:
            textField.keyboardType = UIKeyboardTypeNumberPad;
            break;
    }
}



- (void)senderCode{
    if (self.phoneTF.text.length == 0) {
        ShowHUD(@"请输入手机号");
        return;
    }
   if (![LCRegExpTool lc_checkingMobile:self.phoneTF.text]){
        ShowErrorHUD(@"请输入正确的手机号");
        return;
    }
    MJWeakSelf;
    [NetWorkConnection postURL:@"api/user/sendSmsCode" param:@{@"mobile":self.phoneTF.text,@"type":@"addcard"} success:^(id responseObject, BOOL success) {
        if(responseSuccess){
            NSLog(@"获取短信验证码====%@",responseJSONString);
            [weakSelf getcode];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
}


-(void)getcode{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                sendBtn.userInteractionEnabled = YES;
                
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [sendBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //To do
                [UIView commitAnimations];
                sendBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (NSMutableDictionary *)parmDic{
    if (!_parmDic) {
        _parmDic = [NSMutableDictionary dictionary];
    }
    return _parmDic;
}

- (NSMutableArray *)bankList{
    if (!_bankList) {
        _bankList = [NSMutableArray array];
    }
    return _bankList;
}

@end
