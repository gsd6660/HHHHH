//
//  MyAddressListVC.m
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "MyAddressListVC.h"
#import "MyAddressListCell.h"
#import "AddMyAddressListVC.h"
#import "AddressModel.h"

@interface MyAddressListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_rowArray;
    
    NSArray *_sectionArray;
}
@property(nonatomic,strong)NSString * default_idStr;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView * bottomView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic , strong) NSMutableArray *selectedArray;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;


@end
static NSString * cellID = @"MyAddressListCell";

@implementation MyAddressListVC

-  (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收货地址";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self getData];
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getData];
    }];
    
    _selectedArray = [NSMutableArray new];
    _rowArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    _sectionArray = [NSArray arrayWithObjects:@"1", nil];
    
    for (int i = 0 ; i < _rowArray.count; i ++) {
        if (i == 0) {
            [self.selectedArray setObject:@"1" atIndexedSubscript:0];
        }else{
            [self.selectedArray setObject:@"0" atIndexedSubscript:i];
        }
    }
}


- (BOOL)layoutEmptyView{
    self.emptyView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49 - kBottomSafeHeight);
    return YES;
}

-(void)getData{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/address/lists" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"收货地址列表======%@",responseJSONString);
        if (responseDataSuccess) {
            [self.dataArray removeAllObjects];
            NSArray * data = responseObject[@"data"][@"list"];
            for (NSDictionary *dic in data) {
                AddressModel * model = [AddressModel mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        }
        if (self.dataArray.count == 0) {
            [self showEmptyViewWithImage:CCImage(@"wuwangluo") text:@"暂无数据" detailText:@"你还未没有收货地址" buttonTitle:@"去添加" buttonAction:@selector(goAdd) ];
        }else{
            [self hideEmptyView];
        }
        [self.tableView.mj_header endRefreshing];
        
    } fail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self showEmptyViewWithImage:CCImage(@"wuwangluo") text:@"请求数据失败" detailText:@"没有数据或者加载失败" buttonTitle:@"点击重试" buttonAction:@selector(getData) ];
        
    }];
}

-(void)goAdd{
    MJWeakSelf;
    AddMyAddressListVC * vc = [[AddMyAddressListVC alloc]init];
    vc.block = ^{
        [weakSelf getData];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)addButn:(UIButton *)butn{
    [self goAdd];
}

-(void)goAddRess:(AddressModel *)model{
    MJWeakSelf;
    AddMyAddressListVC * vc = [[AddMyAddressListVC alloc]init];
    vc.block = ^{
        [weakSelf getData];
        
    };
    vc.address_id = [NSString stringWithFormat:@"%@",model.address_id];
    vc.is_edit = @"编辑";
    [self.navigationController pushViewController:vc animated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.editButn addTarget:self action:@selector(editButnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.editButn.tag = indexPath.row + 500;
    cell.radioButn.tag = indexPath.row + 400;
    if ([self.selectedIndexPath isEqual:indexPath]){
        cell.radioButn.selected = YES;
    }else{
        cell.radioButn.selected = NO;
    }
    if (self.dataArray.count > 0) {
        AddressModel * model = self.dataArray[indexPath.row];
        cell.model = model;
        if ([self.address_id isEqualToNumber:model.address_id]) {
            cell.radioButn.selected = YES;
            self.selectedIndexPath = indexPath;
        }else{
            cell.radioButn.selected = NO;
        }
    }
    [cell.editButn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        AddressModel *model = self.dataArray[indexPath.row];
        AddMyAddressListVC * vc = [[AddMyAddressListVC alloc]init];
        vc.is_edit = @"YES";
        vc.address_id = model.address_id.stringValue ;
        vc.block = ^{
            [self getData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    AddressModel *model =self.dataArray[indexPath.row];
    if (self.selectedIndexPath) {
        MyAddressListCell *cell  = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.radioButn.selected = NO;
    }
    MyAddressListCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    cell.radioButn.selected = YES;
    self.selectedIndexPath = indexPath;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeAddress" object:nil userInfo:@{@"model":[model mj_keyValues]}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了删除");
        [self deleteAddressList:indexPath];
        
        
    }];
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"设置默认" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了设置默认");
        [self defaultAddressList:indexPath];
    }];
    editAction.backgroundColor = [UIColor grayColor];
    return @[deleteAction, editAction];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}


- (void)defaultAddressList:(NSIndexPath *)indexPath{
    AddressModel *model = self.dataArray[indexPath.row];
    [NetWorkConnection postURL:@"api/address/setDefault" param:@{@"address_id":[NSString stringWithFormat:@"%@",model.address_id]} success:^(id responseObject, BOOL success) {
        if (responseDataSuccess) {
            //确定 即为删除 用数据源_dataArray移除掉对应的数据
            [self getData];
        }
    } fail:^(NSError *error) {
    }];
}

-(void)deleteAddressList:(NSIndexPath *)indexPath{
    
    AddressModel *model = self.dataArray[indexPath.row];
    [NetWorkConnection postURL:@"api/address/delete" param:@{@"address_id":[NSString stringWithFormat:@"%@",model.address_id]} success:^(id responseObject, BOOL success) {
        if (responseDataSuccess) {
            //确定 即为删除 用数据源_dataArray移除掉对应的数据
            [_dataArray removeObjectAtIndex:indexPath.row];
            //移除后在将tableView对应的行删除刷新
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self getData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteAddress" object:nil];
                
            });
            
        }
    } fail:^(NSError *error) {
        
    }];
}


- (void)radioBtnAction:(UIButton *)sender{
    
    self.selectedArray = [NSMutableArray new];
    
    for (int i = 0 ; i < _rowArray.count; i ++) {
        
        NSLog(@"选中按钮的tag＝%ld\n%d" , sender.tag , i );
        
        if (i == sender.tag - 400) {
            
            [self.selectedArray setObject:@"1" atIndexedSubscript:sender.tag - 400];
        }else{
            
            [self.selectedArray setObject:@"0" atIndexedSubscript:i];
        }
    }
    
    [self.tableView reloadData];
    
    NSLog(@"选中");
    
}

-(void)editButnAction:(UIButton *)butn{
    NSInteger i = butn.tag - 500;
    NSLog(@"点击编辑了第%ld个",i);
    
    //         AddressModel *model = self.dataArray[i];
    //           [self goAddRess:model];
    
}

-(UIView *)bottomView{
    if (_bottomView == nil) {
        CGFloat w = 59;
        //        if (IS_IPHONE_X) {
        //            w = 99;
        //        }
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - w - kBottomSafeHeight, ScreenWidth, w + kBottomSafeHeight)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.shadowColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:0.75].CGColor;
        _bottomView.layer.shadowOffset = CGSizeMake(0,1);
        _bottomView.layer.shadowOpacity = 1;
        _bottomView.layer.shadowRadius = 11;
        
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = kUIColorFromRGB(0x3ACD7B);
        btn.layer.cornerRadius = 17.5;
        btn.titleLabel.font = FONTSIZE(15);
        [btn setTitle:@"+ 新建收货地址" forState:UIControlStateNormal];
        [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [self goAdd];
        }];
        [self.bottomView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.centerX.equalTo(_bottomView.mas_centerX);
            make.width.mas_equalTo(187);
            make.height.mas_equalTo(35);
        }];
        
        
    }
    return _bottomView;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49 - kBottomSafeHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = kUIColorFromRGB(0xF9F9F9);
        _tableView.separatorColor = kUIColorFromRGB(0xF1F4F5);
        [_tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}


-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


@end
