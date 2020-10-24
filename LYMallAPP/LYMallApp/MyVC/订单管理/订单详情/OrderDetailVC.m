//
//  OrderDetailVC.m
//  LYMallApp
//
//  Created by CC on 2020/3/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "OrderDetailVC.h"
#import "OrderDetailHeadView.h"
#import "MyOrderOneCell.h"
#import "MyAddressListCell.h"
#import "ExpressinformationCell.h"
#import "OrderDetailBottomView.h"
#import "OrderDetailfootView.h"
#import "OrderPayViewController.h"
#import "RefundRequestVC.h"
#import "CancelOrderView.h"
#import "PopBottomView.h"
#import "AftermarketVC.h"
#import "CommentVC.h"
#import "NCLookLogisticsVC.h"
@interface OrderDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * _titleArray;
    //test
    NSArray * _numArray;
    NSArray *cancelOrderArray;
}
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)OrderDetailHeadView * headView;
@property(nonatomic,strong)OrderDetailBottomView * bottomView;
@property(nonatomic,strong)OrderDetailfootView * footView;
@property(nonatomic,strong)NSMutableArray * footTitleArray;
@property(nonatomic,strong)NSDictionary * addressDic;
@property(nonatomic,strong)NSDictionary * dataDic;
@property(nonatomic,strong)NSArray * goodsArray;

@end
static NSString *cellOneID = @"MyAddressListCell";
static NSString *cellTwoID = @"MyOrderOneCell";
static NSString *cellThreeID = @"ExpressinformationCell";
@implementation OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = kUIColorFromRGB(0xF5F5F5);
    
    _titleArray = @[@"商品总价",@"运费",@"订单折扣",@"订单总价",@"实付款"];
//    _numArray = @[@"￥39.8",@"￥0",@"-￥2.8",@"￥37.0",@"￥37.0"];
    [self.view addSubview:self.tableView];
    [self setUI];
    [self loadData];
    [self loadCancelOrderData];
}

#pragma mark 请求取消订单原因接口
- (void)loadCancelOrderData{
    [NetWorkConnection postURL:@"api/user.order/getCancelReason" param:nil success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            cancelOrderArray = responseObject[@"data"];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
}

- (void)loadData{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/user.order/detail" param:@{@"order_id":self.order_id} success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        MJWeakSelf;
        if (responseSuccess) {
            NSLog(@"订单详情数据====%@",responseJSONString);
            self.dataDic = responseObject[@"data"][@"order"];
            self.goodsArray = self.dataDic[@"goods"];
            self.addressDic = self.dataDic[@"address"];
            self.headView.titleLabel.text = self.dataDic[@"state_text"][@"text"];
            self.headView.timeLabel.text = self.dataDic[@"state_text"][@"str"];
            _numArray = @[[NSString stringWithFormat:@"- ￥%@",self.dataDic[@"total_price"]],[NSString stringWithFormat:@"￥%@",self.dataDic[@"express_price"]],[NSString stringWithFormat:@"- ￥%@",self.dataDic[@"points_money"]],[NSString stringWithFormat:@"￥%@",self.dataDic[@"order_price"]],[NSString stringWithFormat:@"￥%@",self.dataDic[@"pay_price"]]];
            [self.footTitleArray addObject:[NSString stringWithFormat:@"订单编号：%@",self.dataDic[@"order_no"]]];
            [self.footTitleArray addObject:[NSString stringWithFormat:@"创建时间：%@",self.dataDic[@"create_time"]]];
            NSInteger status = [self.dataDic[@"state_text"][@"value"]integerValue];
            if (status == -10) {
                [self.footTitleArray addObject:[NSString stringWithFormat:@"取消时间：%@",self.dataDic[@"cancel_time"]]];
            }
            self.footView.titleArray = self.footTitleArray;
            NSInteger is_refund = [self.dataDic[@"is_refund"] integerValue];
            NSInteger state = [self.dataDic[@"state_text"][@"value"]integerValue];
            switch (state) {
                    case 0:{
                        self.bottomView.leftBtn.hidden = YES;
                        self.bottomView.centerBtn.hidden = YES;
                        self.bottomView.rightBtn.hidden = NO;
                        self.bottomView.rightTitle = @"删除订单";
                        [self.bottomView.rightBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                            ShowErrorHUD(@"订单正在审核不能删除");
                            NSLog(@"删除订单");
                        }];
                    }
                    break;
                case -10:{
                    self.bottomView.leftBtn.hidden = YES;
                    self.bottomView.centerBtn.hidden = YES;
                    self.bottomView.rightBtn.hidden = NO;
                    self.bottomView.rightTitle = @"删除订单";
                    [self.bottomView.rightBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                        NSLog(@"删除订单");
                        [weakSelf deleteOrder:weakSelf.order_id];
                    }];
                }
                    break;
                case -1:{
                   self.bottomView.leftBtn.hidden = YES;
                   self.bottomView.centerBtn.hidden = YES;
                   self.bottomView.rightBtn.hidden = NO;
                   self.bottomView.rightTitle = @"删除订单";
                   [self.bottomView.rightBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                       NSLog(@"删除订单");
                       [weakSelf deleteOrder:weakSelf.order_id];
                   }];
               }
                   break;
                case -2:{
                  self.bottomView.leftBtn.hidden = YES;
                  self.bottomView.centerBtn.hidden = YES;
                  self.bottomView.rightBtn.hidden = NO;
                  self.bottomView.rightTitle = @"删除订单";
                  [self.bottomView.rightBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                      NSLog(@"删除订单");
                      [weakSelf deleteOrder:weakSelf.order_id];
                  }];
              }
                  break;
                case 10:{
                    self.bottomView.rightBtn.hidden = NO;
                    self.bottomView.centerBtn.hidden = NO;
                    self.bottomView.leftBtn.hidden = YES;
                    self.bottomView.centerTitle = @"取消订单";
                    self.bottomView.rightTitle = @"去付款";
                    [self.bottomView.centerBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                        NSLog(@"取消订单");
                        [weakSelf cencleData:weakSelf.order_id];
                    }];
                    [self.bottomView.rightBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                        [weakSelf gopayData:weakSelf.order_id];
                    }];
                }
                    break;
                case 20:{
                    self.bottomView.leftBtn.hidden = YES;
                    self.bottomView.centerBtn.hidden = YES;
                    if (is_refund==1) {
                        self.bottomView.rightBtn.hidden = NO;
                        self.bottomView.rightTitle = @"申请退款";
                    }else{
                        self.bottomView.rightBtn.hidden = YES;
                    }
                    [self.bottomView.rightBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                        [weakSelf refundClick:weakSelf.order_id withStatus:1];
                    }];
                }
                    break;
                case 30:{
                    self.bottomView.centerBtn.hidden = NO;
                    self.bottomView.rightBtn.hidden = NO;
                    self.bottomView.centerTitle = @"查看物流";
                    self.bottomView.rightTitle = @"确认收货";
                    if (is_refund==1) {
                        self.bottomView.leftBtn.hidden = NO;
                        self.bottomView.leftTitle = @"申请退款";
                    }else{
                        self.bottomView.leftBtn.hidden = YES;
                    }
                    [self.bottomView.leftBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                        NSLog(@"申请退款");
                        [weakSelf aftermarketCilck:weakSelf.order_id];
                    }];
                    [self.bottomView.centerBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                        NSLog(@"查看物流");
                        [weakSelf lookExpress:weakSelf.order_id];
                    }];
                    [self.bottomView.rightBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                        NSLog(@"确认收货");
                        [weakSelf confirmGoods:weakSelf.order_id];
                    }];
                }
                    break;
                case 40:{
                    self.bottomView.leftBtn.hidden = YES;
                    self.bottomView.rightBtn.hidden = NO;
                    self.bottomView.rightTitle = @"立即评价";
                    if (is_refund==2) {
                        self.bottomView.centerTitle = @"申请售后";
                        self.bottomView.centerBtn.hidden = NO;
                    }else{
                        self.bottomView.centerBtn.hidden = YES;
                    }
                    [self.bottomView.centerBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                        NSLog(@"申请售后");
                        [weakSelf aftermarketCilck:weakSelf.order_id];
                    }];
                    [self.bottomView.rightBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                        NSLog(@"立即评价");
                        NSString *goods_type = [NSString stringWithFormat:@"%@",weakSelf. goodsArray[0][@"goods"][@"goods_type"]];
                        [weakSelf appraiseList:weakSelf.goodsArray[0][@"order_id"] goods_type:goods_type];
                    }];
                }
                    break;
                case 50:{
                    self.bottomView.leftBtn.hidden = YES;
                    self.bottomView.centerBtn.hidden = YES;
                    if (is_refund==2) {
                        self.bottomView.rightBtn.hidden = NO;
                        self.bottomView.rightTitle = @"申请售后";
                    }else{
                        self.bottomView.rightBtn.hidden = YES;
                    }
                    [self.bottomView.rightBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                        NSLog(@"申请售后");
                        [weakSelf aftermarketCilck:weakSelf.order_id];
                    }];
                }
                    break;
                default:
                    break;
            }
            
            [self.tableView reloadData];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        [self hideEmptyView];
        ShowErrorHUD(@"网络错误");
    }];
}

#pragma mark 查看物流
- (void)lookExpress:(NSString*)order_id{
    NCLookLogisticsVC * vc = [[NCLookLogisticsVC alloc]init];
    vc.order_id = order_id;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 删除订单
- (void)deleteOrder:(NSString*)order_id{
    [NetWorkConnection postURL:@"api/user.order/delete_order" param:@{@"order_id":order_id} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            ShowHUD(@"删除成功");
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
}



#pragma mark 立即评价
- (void)appraiseList:(NSString*)order_id goods_type:(NSString*)goods_type{
    CommentVC * vc = [CommentVC new];
    vc.order_id = order_id;
    vc.gift_order_type = goods_type;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 申请售后
- (void)aftermarketCilck:(NSString*)order_id{
    
    PopBottomView * cancelView = [[PopBottomView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withDataSource:@[@{@"text":@"已收到货",@"value":@"1"},@{@"text":@"未收到货",@"value":@"2"}]];
    [[UIApplication sharedApplication].keyWindow addSubview:cancelView];
    cancelView.selectIndexClick = ^(NSIndexPath * _Nonnull indexPath) {
        if (indexPath.row == 0) {
            AftermarketVC * vc = [[AftermarketVC alloc]init];
            vc.order_id = order_id;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            RefundRequestVC * vc = [[RefundRequestVC alloc]init];
            vc.order_id = order_id;
            vc.status = OrderStatusNotArrive;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    
}

- (void)refundClick:(NSString*)order_id withStatus:(NSInteger)status{
    RefundRequestVC * vc = [[RefundRequestVC alloc]init];
    vc.order_id = order_id;
    if (status ==1 ) {
        vc.status = OrderStatusNotSend;
    }else{
        vc.status = OrderStatusNotArrive;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 去付款
-(void)gopayData:(NSString *)order_id{
    
    OrderPayViewController * vc = [[OrderPayViewController alloc]init];
    vc.order_id = self.order_id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 取消订单
-(void)cencleData:(NSString *)order_id{
    
    CancelOrderView * cancelView = [[CancelOrderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withDataSource:cancelOrderArray];
    [[UIApplication sharedApplication].keyWindow addSubview:cancelView];
    cancelView.selectClick = ^(NSIndexPath * _Nonnull indexPath) {
       NSDictionary * dic = cancelOrderArray[indexPath.row];
        [NetWorkConnection postURL:@"api/user.order/cancel" param:@{@"order_id":order_id,@"reason_id":dic[@"value"]} success:^(id responseObject, BOOL success) {
            if (responseDataSuccess) {
                [QMUITips showSucceed:@"取消成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [QMUITips showError:responseMessage];
            }
        } fail:^(NSError *error) {
            
        }];
    };
    
}



#pragma mark 确定收货
- (void)confirmGoods:(NSString*)order_id{
    [NetWorkConnection postURL:@"api/user.order/receipt" param:@{@"order_id":self.order_id} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            ShowHUD(@"收货成功");
//            [self.tableView.mj_header beginRefreshing];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ShowErrorHUD(responseMessage);
        }
        
    } fail:^(NSError *error) {
        
    }];
}


-(void)setUI{
    self.headView = [[OrderDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 137)];
    [self.view addSubview:self.headView];
    
    self.bottomView = [[OrderDetailBottomView alloc]initWithFrame:CGRectMake(0, ScreenHeight - kBottomSafeHeight - 49, ScreenWidth, 49 + kBottomSafeHeight)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    
    self.footView = [[OrderDetailfootView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    self.tableView.tableFooterView = self.footView;
    
//    self.footTitleArray = (NSMutableArray*)@[@"订单编号：AB4254351351",@"创建时间：2020-03-18 10：10：10",@"支付方式：账户余额",@"付款时间：2020-03-18 10：13：10"];
//    self.footView.titleArray = self.footTitleArray;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 1;
    }
    if (section == 0) {
        if (![CheackNullOjb cc_isNullOrNilWithObject:self.dataDic[@"express"]]) {
            return 1;
        }else{
            return 0;
        }
    }
    if (section == 2) {
        return self.goodsArray.count;
    }
    return _titleArray.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 90;
    }
    if (indexPath.section == 1) {
        return 87;
    }
    if (indexPath.section == 2) {
        return 107;
    }
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return 0.001;
    }
    return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        ExpressinformationCell * cell = [tableView dequeueReusableCellWithIdentifier:cellThreeID];
        if (![CheackNullOjb cc_isNullOrNilWithObject:self.addressDic]) {
           [cell setDetailModel:self.dataDic];
        }
        
        return cell;
    }
    
    static NSString *cellThreeID = @"wwww";
    if (indexPath.section == 1) {
        MJWeakSelf;
        MyAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellOneID];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.editButn.hidden = YES;
        [cell.radioButn setImage:[UIImage imageNamed:@"jft_icon_position"] forState:0];
        cell.dataDic = self.addressDic;
        return cell;
    }
    
    if (indexPath.section == 2) {
        MJWeakSelf;
        MyOrderOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTwoID];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dicData = self.goodsArray[indexPath.row];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellThreeID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellThreeID];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    if (indexPath.row==4) {
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    cell.detailTextLabel.text = _numArray[indexPath.row];
    
    return cell;
}


-(NSMutableArray *)dataArray{
    if (_dataArray ==nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat H = ScreenHeight > 812 ? 137+ 24 : 137;
        _tableView = [[UITableView alloc]initWithFrame:CGRectInset(CGRectMake(0, H, ScreenWidth , ScreenHeight - H - 49 - kBottomSafeHeight ), 10, 0) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kUIColorFromRGB(0xF5F5F5);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedSectionFooterHeight = 1;
        _tableView.estimatedSectionHeaderHeight = 10;
        [_tableView registerNib:[UINib nibWithNibName:cellOneID bundle:nil] forCellReuseIdentifier:cellOneID];
        [_tableView registerNib:[UINib nibWithNibName:cellTwoID bundle:nil] forCellReuseIdentifier:cellTwoID];
        [_tableView registerNib:[UINib nibWithNibName:cellThreeID bundle:nil] forCellReuseIdentifier:cellThreeID];
    }
    return _tableView;
}

- (NSMutableArray *)footTitleArray{
    if (!_footTitleArray) {
        _footTitleArray = [NSMutableArray array];
    }
    return _footTitleArray;
}

@end
