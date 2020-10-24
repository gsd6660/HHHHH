//
//  PopBottomView.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "PopBottomView.h"

@interface PopBottomView ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat _height;
    NSArray * _dataSource;
    NSIndexPath * selectIndexPath;
}
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation PopBottomView

- (instancetype)initWithFrame:(CGRect)frame withDataSource:(NSArray *)dataSource{
    self = [super initWithFrame:frame];
    if (self) {
        _dataSource = dataSource;
        _height = dataSource.count * 44;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.bgView  = [[UIView alloc]init];
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner|QMUILayerMaxXMinYCorner;
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    UIControl * control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - _height - 75)];
    [self addSubview:control];
    [control addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [self disMiss];
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(_height + 120);
        make.bottom.mas_equalTo(0);
    }];
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"退款原因";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kUIColorFromRGB(0x333333);
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.bgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(20);
    }];
    [self.bgView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(_height);
        make.bottom.equalTo(self.mas_bottom).offset(-kBottomSafeHeight - 45);
    }];
    
    UIButton * bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setTitle:@"确定" forState:0];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:0];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    bottomBtn.backgroundColor = kUIColorFromRGB(0x3ACD7B);
    bottomBtn.layer.cornerRadius = 17.5;
    [self.bgView addSubview:bottomBtn];
    
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom).offset(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
    }];
    [bottomBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        self.selectIndexClick(selectIndexPath);
        [self disMiss];
    }];
    
    self.bgView.frame = CGRectMake(0, ScreenHeight, ScreenWidth,_height + 120);
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.frame = CGRectMake(0, ScreenHeight/2, ScreenWidth, _height+120);
        self.backgroundColor = [kUIColorFromRGB(0x000000)colorWithAlphaComponent:0.3];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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

- (void)disMiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [kUIColorFromRGB(0x000000)colorWithAlphaComponent:0];
            self.bgView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, _height + 120);
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
