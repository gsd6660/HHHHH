//
//  LXGoldShopViewController.m
//  LYMallApp
//
//  Created by guxiang on 2020/11/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXGoldShopViewController.h"
#import "LXGoldShopCell.h"
#import "LXGoldPopView.h"
#import <UIView+TYAlertView.h>
@interface LXGoldShopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UILabel *goldLabel;

@property (weak, nonatomic) IBOutlet UIButton *sellBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation LXGoldShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"金豆集市";
    YBDViewBorderRadius(self.sellBtn, 10);
    YBDViewBorderRadius(self.topView, 10);
    YBDViewBorderRadius(self.goldLabel, 10);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LXGoldShopCell" bundle:nil] forCellReuseIdentifier:@"LXGoldShopCell"];
    [self loadData];
}

-(void)getData{//api/user/my_wallet
    [NetWorkConnection postURL:@"api/task.wallet/info" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"我的钱包=====%@",responseJSONString);
        if (responseSuccess) {
            NSDictionary *data = responseObject[@"data"];
            self.goldLabel.text = [NSString stringWithFormat:@"%@",data[@"gold"]];
        }
    } fail:^(NSError *error) {
        
    }];
   
}


- (void)loadData{
    [NetWorkConnection postURL:@"api/task.market/lists" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"%@",responseJSONString);
        if (responseSuccess) {
            NSArray * array = responseObject[@"data"][@"list"][@"data"];
            [self.dataArray addObjectsFromArray:array];
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
            
    }];
}

- (IBAction)sellBtnClick:(id)sender {
    
    LXGoldPopView * popView = [LXGoldPopView createViewFromNib];
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:popView preferredStyle:TYAlertControllerStyleAlert];
    popView.cofirmBlock = ^(NSString * str){
        [self sellGlod:str];
    };
    popView.cancelBlock = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)sellGlod:(NSString*)num{
    [NetWorkConnection postURL:@"api/task.market/sell" param:@{@"gold":num} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            ShowHUD(responseMessage);
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
}

- (void)buyGlodwithUser_id:(NSString*)user_id{
    [NetWorkConnection postURL:@"api/task.market/buy" param:@{@"deal_id":user_id} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            ShowHUD(responseMessage);
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LXGoldShopCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LXGoldShopCell"];
    
    NSDictionary * dic = self.dataArray[indexPath.row];
    cell.dic = dic;

    cell.buyClick = ^{
    
//        LXGoldPopView * popView = [LXGoldPopView createViewFromNib];
//        popView.titleLabel.text = @"买入金豆";
//        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:popView preferredStyle:TYAlertControllerStyleAlert];
//        popView.cofirmBlock = ^(NSString * str){
            [self buyGlodwithUser_id:dic[@"buy_user_id"]];
//        };
//        popView.cancelBlock = ^{
//            [self dismissViewControllerAnimated:YES completion:nil];
//        };
//
//        [self presentViewController:alertController animated:YES completion:nil];
    };
    
    
    return cell;
}  



- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



 

@end
