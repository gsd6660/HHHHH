//
//  SelectCouponsView.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/10.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "SelectCouponsView.h"
@interface SelectCouponsView()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary * dic;
}
@property(nonatomic,strong)UITableView * tableView;


@end
@implementation SelectCouponsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tableView];
        [self setTableViewFootView];
        self.tableView.tableFooterView = [UIView new];
    }
    return self;
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.tableView reloadData];
}


- (void)setTableViewFootView{
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, 30)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = @"选择优惠券";
    titleLabel.textColor = kUIColorFromRGB(0x333333);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确定" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.backgroundColor = [UIColor redColor];
    btn.layer.cornerRadius = 20;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:btn];
    btn.frame = CGRectMake(10, 230, ScreenWidth - 30, 40);
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        self.hideView(dic);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cells"];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    
    if (indexPath.row == self.dataArray.count) {
        cell.textLabel.text = @"不使用优惠券";
    }else{
        NSDictionary * dic = self.dataArray[indexPath.row];
        cell.textLabel.text = dic[@"name"];
    }
    if (self.selectIndexPath == indexPath) {
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jft_but_selected"]];
    }else{
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jft_but_Unselected"]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndexPath = indexPath;
    if (indexPath.row== self.dataArray.count) {
        dic = @{@"user_coupon_id":@"",@"reduced_price":@"选择优惠券",@"indexPath":indexPath};
    }else{
        NSDictionary * cuponDic = self.dataArray[indexPath.row];
        dic = @{@"user_coupon_id":cuponDic[@"user_coupon_id"],@"reduced_price":cuponDic[@"reduced_price"],@"indexPath":indexPath};
    }
    
    [tableView reloadData];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, self.height - 120)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}



@end
