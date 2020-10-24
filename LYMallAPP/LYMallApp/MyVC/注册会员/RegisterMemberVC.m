//
//  RegisterMemberVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "RegisterMemberVC.h"
#import "RegisterMemberFootView.h"
#import "RegisterMemberCell.h"
#import "RegisterMemberTwoCell.h"
@interface RegisterMemberVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)RegisterMemberFootView * footView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSDictionary * dataDic;

@end

static NSString *cellID = @"RegisterMemberCell";
static NSString *cellTwoID = @"RegisterMemberTwoCell";

@implementation RegisterMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册会员";
    self.tableView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
    self.footView = [[[NSBundle mainBundle] loadNibNamed:@"RegisterMemberFootView" owner:self options:nil] lastObject];
    self.tableView.autoresizingMask =  UIViewAutoresizingNone;
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    [self.tableView registerNib:[UINib nibWithNibName:cellTwoID bundle:nil] forCellReuseIdentifier:cellTwoID];

    self.tableView.tableFooterView = self.footView;
    MJWeakSelf;
    self.footView.block = ^{
        [weakSelf commitData];
    };
    
}

-(void)commitData{
    if ([CheackNullOjb cc_isNullOrNilWithObject:self.dataDic[@"invite_code"]] == YES) {
        ShowErrorHUD(@"请输入推荐人账号或邀请码");
        return;
    }
    if ([self.footView.nameTF.text qmui_trimAllWhiteSpace].length == 0) {
        ShowErrorHUD(@"请输入用户名");
        return;
    }
    if ([self.footView.userNameTF.text qmui_trimAllWhiteSpace].length == 0) {
        ShowErrorHUD(@"请输入姓名");
        return;
    }
    if ([self.footView.passTF.text qmui_trimAllWhiteSpace].length == 0) {
        ShowErrorHUD(@"请输入密码");
        return;
    }
    if ([self.footView.phoneTF.text qmui_trimAllWhiteSpace].length == 0) {
        ShowErrorHUD(@"请输入手机号");
        return;
    }
    if ([self.footView.codeTF.text qmui_trimAllWhiteSpace].length == 0) {
        ShowErrorHUD(@"请输入验证码");
        return;
    }
    
    MJWeakSelf;
    [NetWorkConnection postURL:@"api/user/registUser" param:@{@"phone":weakSelf.footView.phoneTF.text,@"password":weakSelf.footView.passTF.text,@"nickName":weakSelf.footView.userNameTF.text,@"invite_code":weakSelf.dataDic[@"invite_code"],@"captcha":weakSelf.footView.codeTF.text} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            NSLog(@"注册会员%@",responseJSONString);
            ShowHUD(responseMessage);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            ShowErrorHUD(responseMessage);
        }
        
    } fail:^(NSError *error) {
        
    }];
}


-(void)searchData:(NSString *)searchText{
    [NetWorkConnection postURL:@"api/user/selectUserInfo" param:@{@"code":searchText} success:^(id responseObject, BOOL success) {
        NSLog(@"搜索结果====%@",responseJSONString);
        if (responseDataSuccess) {
            NSDictionary *dic  = responseObject[@"data"];
            self.dataDic = dic;
            [self.dataArray removeAllObjects];
            for (NSString *value in dic.allKeys) {
                if (![value isEqualToString:@"invite_code"]) {
                    [self.dataArray addObject:dic[value]];
                }
            }
            
        }else{
            ShowErrorHUD(responseMessage);
        }
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return  self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
    
    RegisterMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    MJWeakSelf;
    [cell.searchButn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        NSLog(@"输入====%@",cell.TF.text);
        if ([cell.TF.text qmui_trimAllWhiteSpace].length == 0) {
            ShowErrorHUD(@"请输入推荐人邀请码或手机号");
            return ;
        }
        [weakSelf searchData:cell.TF.text];
    }];
        return cell;
        
 }
    if (indexPath.section == 1) {
        RegisterMemberTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTwoID];

        if (indexPath.row == 0) {
            cell.typeLabel.text = @"姓名";
        }else{
            cell.typeLabel.text = @"手机号";

        }
        
           if (self.dataArray.count > 0) {
               if (indexPath.row == 0) {
                   cell.TF.text = self.dataArray[1];
               }else{
                   cell.TF.text = self.dataArray[0];
               }
           }
               
               

           return cell;
    }
        
   
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 57;
}







-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}














@end
