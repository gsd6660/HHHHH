

//
//  ActivateMemberTwoVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ActivateMemberTwoVC.h"

@interface ActivateMemberTwoVC ()
@property (weak, nonatomic) IBOutlet UITextField *memberNumTF;
@property (weak, nonatomic) IBOutlet UITextField *shengyujifenTF;
@property (weak, nonatomic) IBOutlet UITextField *xaiofeiTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *xuyaoTF;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet QMUIFillButton *commitButn;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITextField *countTF;

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSDictionary * dataDic;

@end

@implementation ActivateMemberTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"激活会员";
    [self getData];
    [self hideSomeView:YES];
    [self.countTF addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
}


-(void)getData{
    [NetWorkConnection postURL:@"api/user/my_wallet" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"获取用户积分及编号===%@",responseJSONString);
        if (responseSuccess) {
            self.memberNumTF.text = responseObject[@"data"][@"nickName"];
            self.shengyujifenTF.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"regist_points"]];

        }
    } fail:^(NSError *error) {
        
    }];
}


-(void)hideSomeView:(BOOL)boolValue{
    self.view1.hidden = boolValue;
    self.view2.hidden = boolValue;
    self.view3.hidden = boolValue;
    self.commitButn.hidden = boolValue;
    
}

- (IBAction)searchButn:(UIButton *)sender {
    [self searchData:self.xaiofeiTF.text];
}


-(void)searchData:(NSString *)searchText{
    [NetWorkConnection postURL:@"api/user/selectUserInfo" param:@{@"code":searchText} success:^(id responseObject, BOOL success) {
        NSLog(@"搜索结果====%@",responseJSONString);
        if (responseDataSuccess) {
            NSDictionary *dic  = responseObject[@"data"];
            self.nameTF.text = dic[@"name"];
            self.phoneTF.text = dic[@"phone"];

            [self hideSomeView:NO];

        }else{
            ShowErrorHUD(responseMessage);
        }
        
    } fail:^(NSError *error) {
        
    }];
}

- (IBAction)commitButn:(UIButton *)sender {
    MJWeakSelf;
    if ([self.phoneTF.text qmui_trimAllWhiteSpace].length == 0) {
        ShowErrorHUD(@"请输入被激活用户的手机号");
        return;
    }
    if ([self.countTF.text qmui_trimAllWhiteSpace].length == 0) {
        ShowErrorHUD(@"请输入激活积分数量");
        return;
    }
    [NetWorkConnection postURL:@"api/user/activatesUser" param:@{@"points_num":self.countTF.text,@"phone":self.phoneTF.text} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            ShowHUD(responseObject);
            [weakSelf.navigationController popViewControllerAnimated:YES];

        }else{
            ShowErrorHUD(responseMessage);
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    
}

-(void)textDidChange:(UITextField *)tf{
    if ([tf.text intValue] > 0) {
    [self getNumRetuan:[tf.text qmui_trimAllWhiteSpace]];
    }else{
        ShowErrorHUD(@"请输入大于0的数字");
        self.countTF.text = @"";
    }
}


-(void)getNumRetuan:(NSString *)num{
    [NetWorkConnection postURL:@"api/user/getNumRetuan" param:@{@"num":num} success:^(id responseObject, BOOL success) {
        NSLog(@"激活积分的计算以及文字====%@",responseJSONString);
        if (responseSuccess) {
            NSDictionary *dic = responseObject;
            self.countLabel.text = dic[@"data"];
        }
    } fail:^(NSError *error) {
        
    }];
}


@end
