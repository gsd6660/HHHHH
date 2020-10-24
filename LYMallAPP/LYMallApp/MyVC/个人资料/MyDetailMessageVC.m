//
//  MyDetailMessageVC.m
//  LYMallApp
//
//  Created by Mac on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MyDetailMessageVC.h"
#import "MyAddressListVC.h"
#import "EditUserNameVC.h"

#import "HomeVC.h"
@interface MyDetailMessageVC ()
{
    NSMutableDictionary * _dataDic;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UIImageView * userImageView;
@property(nonatomic,strong)NSMutableDictionary * parDic;
@end

@implementation MyDetailMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataDic = [NSMutableDictionary dictionary];
    self.title = @"个人资料";
    self.userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.userImageView.layer.cornerRadius = 5;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.image = CCImage(@"all");
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    footView.backgroundColor = kUIColorFromRGB(0xf9f9f9);

    UIButton * butn = [UIButton buttonWithType:UIButtonTypeCustom];
    butn.frame = CGRectMake(0, 10, ScreenWidth, 50);
    butn.backgroundColor = [UIColor whiteColor];
    [butn setTitle:@"退出当前账户" forState:UIControlStateNormal];
    [butn setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [butn addTarget:self action:@selector(exitLogin:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:butn];
    self.tableView.tableFooterView = footView;
    
    [self loadData];
}

- (void)loadData{
    [NetWorkConnection postURL:@"api/user/get_user_info" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"%@",responseObject);
        if (responseSuccess) {
            [self->_dataDic addEntriesFromDictionary:responseObject[@"data"]];
            [self.tableView reloadData];
        }
        
    } fail:^(NSError *error) {
        
    }];
}


- (void)updateAccount:(NSMutableDictionary*)parm{
    [NetWorkConnection postURL:@"api/user/edit_user_info" param:parm success:^(id responseObject, BOOL success) {
        NSLog(@"%@",responseObject);
        if (responseSuccess) {
            ShowHUD(@"修改成功");
            NSInteger  type = [parm[@"type"]integerValue];
            switch (type) {
                case 3:{
                    NSString * gender;
                    if ([parm[@"content"]isEqualToString:@"1"]) {
                        gender = @"男";
                    }else{
                        gender = @"女";
                    }
                    [self->_dataDic setValue:gender forKey:@"gender"];
                }
                    break;
                case 4:{
                    [self->_dataDic setValue:parm[@"content"] forKey:@"date_birth"];
                }
                    break;
                default:
                    break;
            }
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * heaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    heaView.backgroundColor = kUIColorFromRGB(0xF9F9F9);
    return heaView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellid";
    QMUITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[QMUITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0) {
        if (_dataDic) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"头像";
                [self.userImageView sd_setImageWithURL:[NSURL URLWithString:_dataDic[@"avatarUrl"]]];
                cell.accessoryView = self.userImageView;
                
                break;
             case 1:
                cell.textLabel.text = @"昵称";
                cell.detailTextLabel.text = _dataDic[@"name"];

                break;
                case 2:
                cell.textLabel.text = @"性别";
                cell.detailTextLabel.text = _dataDic[@"gender"];
                break;
                case 3:
                cell.textLabel.text = @"出生日期";
                cell.detailTextLabel.text = _dataDic[@"date_birth"];
                break;
            default:
                break;
        }
        
        }
        
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = @"收货地址";
        if ([_dataDic[@"address"] count] > 0) {
            NSDictionary * dic = _dataDic[@"address"][@"region"];
            NSString * addString = [NSString stringWithFormat:@"%@%@%@",dic[@"province"],dic[@"city"],dic[@"region"]];
            cell.detailTextLabel.text = addString;
        }else{
                cell.textLabel.text = @"收货地址";
        }
    }
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QMUITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 1) {
        MyAddressListVC * vc = [[MyAddressListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MJWeakSelf;
            [self showPicker:YES completion:^(UIImage *image) {
                weakSelf.userImageView.image = image;
                [weakSelf updateImage:image];

               }];
        }
        if (indexPath.row == 1) {
            MJWeakSelf;
            EditUserNameVC * vc = [[EditUserNameVC alloc]init];
            vc.TF.text = _dataDic[@"name"];
            vc.changeName = ^{
                [weakSelf loadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.row == 2) {
            [self selectSex:cell];
        }
        if (indexPath.row == 3) {
            [self selectTime:cell];
        }
    }
    
}



-(void)exitLogin:(UIButton *)butn{
    [NetWorkConnection postURL:@"api/user/log_out" param:nil success:^(id responseObject, BOOL success) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController popViewControllerAnimated:YES];        
        ShowHUD(@"退出成功");
    } fail:^(NSError *error) {
        
    }];
}



-(void)selectTime:(QMUITableViewCell*)cell{
    // 出生时刻
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]initWithPickerMode:BRDatePickerModeYMD];
    datePickerView.title = @"出生日期";
    datePickerView.isAutoSelect = YES;
    datePickerView.resultBlock = ^(NSString *selectValue) {
        cell.detailTextLabel.text = selectValue;
        [self.parDic setValue:@"4" forKey:@"type"];
        [self.parDic setValue:selectValue forKey:@"content"];
        [self updateAccount:self.parDic];
    };
    [datePickerView show];
}

-(void)selectSex:(QMUITableViewCell*)cell{
    /// 1.单列字符串选择器（传字符串数组）
    BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]initWithPickerMode:BRStringPickerComponentSingle];
    stringPickerView.title = @"性别";
    stringPickerView.dataSourceArr = @[@"男", @"女"];
    stringPickerView.selectIndex = 2;
    stringPickerView.resultModelBlock = ^(BRResultModel *resultModel) {
        NSLog(@"选择的值：%@", resultModel.selectValue);
        cell.detailTextLabel.text = resultModel.selectValue;
        [self.parDic setValue:@"3" forKey:@"type"];
        [self.parDic setValue:[NSString stringWithFormat:@"%ld",resultModel.index + 1] forKey:@"content"];
        [self updateAccount:self.parDic];
    };

    [stringPickerView show];
}

- (NSMutableDictionary *)parDic{
    if (!_parDic) {
        _parDic = [NSMutableDictionary dictionary];
    }
    return _parDic;
}

- (void)extracted:(UIImage *)headImage iData:(NSData *)iData {
    MJWeakSelf;
    [NetWorkConnection uploadPost:@"api/upload/image"  parameters:@{@"iFile":iData} name:@"iFile" UploadImage:headImage success:^(id responseObject, BOOL success) {
        NSLog(@"图片====%@",responseObject);
        if(responseDataSuccess){
            [weakSelf commitImageUrl:responseObject[@"data"][@"file_path"]];
        }else{
            [QMUITips showError:responseMessage];
            
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)commitImageUrl:(NSString *)ulr{
//    api/member/modifyAvatarNickName
    MJWeakSelf;
    [NetWorkConnection postURL:@"api/user/edit_user_info" param:@{@"content":ulr,@"type":@"2"} success:^(id responseObject, BOOL success) {
        if (responseDataSuccess) {
            [QMUITips showSucceed:@"修改成功"];
            [_dataDic setValue:ulr forKey:@"avatarUrl"];
        }else{
            [QMUITips showError:responseMessage];

        }
    } fail:^(NSError *error) {
        
    }];
}

-(void)updateImage:(UIImage *)headImage{
    
    NSData *iData = UIImageJPEGRepresentation(headImage, 0.5);
    [self extracted:headImage iData:iData];
    
}


@end
