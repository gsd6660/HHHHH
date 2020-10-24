//
//  CancelOrderView.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CancelOrderView.h"

@interface CancelOrderView()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSArray * _dataSource;
    UIView * bgView;
    NSIndexPath * selectIndexPath;
}
@property(nonatomic,strong)UITableView * tableView;

@end

@implementation CancelOrderView

- (instancetype)initWithFrame:(CGRect)frame withDataSource:(nonnull NSArray *)dataSource{
    self = [super initWithFrame:frame];
    if (self) {
        _dataSource = dataSource;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight/2, ScreenWidth, ScreenHeight/2)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, ScreenWidth - 100, 20)];
    titleLabel.text = @"取消订单";
    titleLabel.font = FONTSIZE(16);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kUIColorFromRGB(0x333333);
    [bgView addSubview:titleLabel];
    
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"jft_icon_close"] forState:0];
    closeBtn.frame = CGRectMake(ScreenWidth - 30, 10, 20, 20);
    [closeBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [self disMiss];
    }];
    [bgView addSubview:closeBtn];

    UILabel * tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, ScreenWidth - 20, 30)];
    tipLabel.backgroundColor = kUIColorFromRGB(0xF9F9F9);
    tipLabel.text = @"取消后无法恢复，优惠券，红包，积分可退回";
    tipLabel.font = FONTSIZE(13);
    tipLabel.textColor = kUIColorFromRGB(0x333333);
    [bgView addSubview:tipLabel];
    
    UIView * tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    UILabel * tableViewHeaderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, ScreenWidth, 20)];
    tableViewHeaderLabel.text = @"请选择取消订单的原因：";
    tableViewHeaderLabel.font = FONTSIZE(15);
    [tableHeaderView addSubview:tableViewHeaderLabel];
    self.tableView.tableHeaderView = tableHeaderView;
    
    UIButton * bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setTitle:@"确定" forState:0];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:0];
    [bottomBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (selectIndexPath!=nil) {
            self.selectClick(selectIndexPath);
        }
        [self disMiss];
    }];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    bottomBtn.backgroundColor = kUIColorFromRGB(0x3ACD7B);
    bottomBtn.layer.cornerRadius = 17.5;
    bottomBtn.frame = CGRectMake(10, ScreenHeight/2 - kBottomSafeHeight - 45, ScreenWidth - 20, 35);
    [bgView addSubview:bottomBtn];
    
    bgView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight/2);
    [UIView animateWithDuration:0.3 animations:^{
        bgView.frame = CGRectMake(0, ScreenHeight/2, ScreenWidth, ScreenHeight/2);
        self.backgroundColor = [kUIColorFromRGB(0x000000)colorWithAlphaComponent:0.3];
    }];
    [bgView addSubview:self.tableView];
}

- (void)disMiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [kUIColorFromRGB(0x000000)colorWithAlphaComponent:0];
            bgView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight/2);
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cells"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_dataSource) {
        NSDictionary * dic = _dataSource[indexPath.row];
        cell.textLabel.text = dic[@"text"];
    }
    if (selectIndexPath == indexPath) {
           cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jft_but_selected"]];
       }else{
           cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jft_but_Unselected"]];
       }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = _dataSource[indexPath.row];
    NSLog(@"%@",dic[@"value"]);
     selectIndexPath = indexPath;
    [tableView reloadData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, ScreenWidth, ScreenHeight/2 - 140 - kBottomSafeHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
