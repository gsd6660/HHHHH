

//
//  SelectPayTypeVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "SelectPayTypeVC.h"
#import "OrderPayCell.h"
@interface SelectPayTypeVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行

@end

@implementation SelectPayTypeVC
static NSString * orderPayCellID = @"OrderPayCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:orderPayCellID bundle:nil] forCellReuseIdentifier:orderPayCellID];
    self.view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];

    [self.view addSubview:self.tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderPayCell * cell = [tableView dequeueReusableCellWithIdentifier:orderPayCellID];
        NSDictionary * dic = self.payDataArray[indexPath.row];
        [cell.imgView yy_setImageWithURL:[NSURL URLWithString:dic[@"icon"]] placeholder:nil];
        cell.titleLabel.text = dic[@"name"];
        cell.balanceLabel.hidden = YES;
        
        if (_selIndex == indexPath) {
            [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_selected"] forState:UIControlStateNormal];
        }else{
            [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];
            
        }
            if (indexPath.row==0) {//指定第一行为选中状态
                [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_selected"] forState:UIControlStateNormal];
                _selIndex = indexPath;
            }else{
                [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];
            }
         
        
        return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.payDataArray.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        //之前选中的，取消选择
        OrderPayCell *celled = [tableView cellForRowAtIndexPath:_selIndex];
        [celled.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];

        //记录当前选中的位置索引
        _selIndex = indexPath;
        //当前选择的打勾
        OrderPayCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.selectBtn setImage: [UIImage imageNamed:@"jft_but_selected"] forState:UIControlStateNormal];
//        self.payType = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"pay_type"]];
        NSLog(@"选择====%@",[NSString stringWithFormat:@"%@",self.payDataArray[indexPath.row][@"type"]]);
    if (self.delegate && [self.delegate respondsToSelector:@selector(getPayType:payName:)]) {
        [self.delegate getPayType:self.payDataArray[indexPath.row][@"type"] payName:self.payDataArray[indexPath.row][@"name"]];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(0, ScreenHeight - 250, ScreenWidth, 250);

    } completion:^(BOOL finished) {

    }];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.5 animations:^{
           self.tableView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 250);

       } completion:^(BOOL finished) {
           self.view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0];
       }];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 300) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = kUIColorFromRGB(0xf9f9f9);
        _tableView.tableFooterView = [UIView new];

    }
    return _tableView;
}


@end
