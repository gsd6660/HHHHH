

//
//  SureOrderVC.m
//  LYMallApp
//
//  Created by Mac on 2020/3/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "SureOrderVC.h"
#import "SureOrderGoodsCell.h"
#import "MyAddressListCell.h"
#import "SureOrderSectionHeadView.h"
#import "SureOrderSectionFootView.h"
//
#import "MyAddressListVC.h"
#import "AddMyAddressListVC.h"
#import "SureOrderTwoCell.h"
#import "OrderPayViewController.h"
#import "BuynowOneCell.h"
//

#import "AddressModel.h"
#import "LYGoodsModel.h"
#import "SelectCouponsView.h"
@interface SureOrderVC ()<UITableViewDelegate,UITableViewDataSource,QMUITextViewDelegate>
{
    NSArray * _titArray;
    NSArray * _numArray;
    NSDictionary * _dataDic;
    BOOL exist_address;//是否有收获地址
    BOOL is_allow_points;//是否开启积分抵扣
    BOOL cellBtnSelect;
    NSDictionary * couopnsDic;//优惠券所传来的数据
}
@property(nonatomic,strong)UITableView * tabeleView;
@property(nonatomic,strong)UIView * bottomView;
@property(nonatomic,strong)UILabel * numLabel;
@property(nonatomic,strong)UIButton * payBtn;
@property(nonatomic,strong)NSMutableArray * goods_listArray;
@property(nonatomic,strong)NSMutableArray * coupon_listArray;
@property(nonatomic,strong)NSDictionary * addressDic;

@property(nonatomic,strong)NSMutableArray * contentArray;
@property(nonatomic,strong)NSMutableArray * titleArray;

@property(nonatomic,strong)NSMutableDictionary * sureParamDic;
@property(nonatomic,strong)NSMutableDictionary * cardsDic;

@end
static NSString * cellID = @"SureOrderGoodsCell";
static NSString * cellAddressID = @"MyAddressListCell";
static NSString * cellTwoID = @"SureOrderTwoCell";
static NSString * cellIDB = @"BuynowOneCell";
@implementation SureOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.view.backgroundColor = kUIColorFromRGB(0xf9f9f9);
    
    [self.view addSubview:self.tabeleView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.numLabel];
    [self.bottomView addSubview:self.payBtn];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(ScreenWidth/2);
    }];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView.mas_right).offset(-20);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(35);
    }];
    _titArray = @[@"优惠券",@"会员折扣",@"银豆抵扣",@"运费",@"实付金额"];
    _numArray = @[@"暂无可用",@"-￥0.0",@"￥0.09",@"",@"￥0.0"];
    if (self.type == DetailPush) {//正常商品
        [self loadDataWithUrl:@"api/order/buyNow"];
    }else if(self.type == SharpDetailPush){//限时购买商品
        [self loadDataWithUrl:@"api/sharp.order/buyNow"];
    }else{
        [self.cardsDic setValue:self.cart_ids forKey:@"cart_ids"];
        [self getData];
    }
    self.tabeleView.tableFooterView = [self setTableViewFootView];
}

- (UIView*)setTableViewFootView{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 20, 100)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 40, 20)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = @"留言:";
    titleLabel.textColor = kUIColorFromRGB(0x333333);
    [bgView addSubview:titleLabel];
    QMUITextView * textView = [[QMUITextView alloc]initWithFrame:CGRectMake(50, 5, ScreenWidth - 90, 80)];
    textView.placeholder = @"给卖家留言";
    textView.font = [UIFont systemFontOfSize:14];
    textView.delegate = self;
    textView.returnKeyType = UIReturnKeyDone;
    [bgView addSubview:textView];
    return bgView;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"我=======%@",textView.text);
    [self.sureParamDic setValue:textView.text forKey:@""];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAddressClick:) name:@"changeAddress" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeAddress" object:nil];
}
#pragma mark 更改地址
- (void)changeAddressClick:(NSNotification*)notif{
    NSLog(@"更改地址====%@",notif.userInfo[@"model"]);
    self.addressDic = notif.userInfo[@"model"];
    [self.sureParamDic setValue:self.addressDic[@"address_id"] forKey:@"address_id"];
    [self.tabeleView reloadData];
}

#pragma mark 商品详情进入时所请求的数据
- (void)loadDataWithUrl:(NSString*)url{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:url param:self.prmDic success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        if (responseSuccess) {
            [self.goods_listArray removeAllObjects];
            [self.titleArray removeAllObjects];
            [self.contentArray removeAllObjects];
            NSLog(@"立即购买数据==%@",responseJSONString);
            NSDictionary * dic = responseObject[@"data"];
            _dataDic = dic;
            NSArray * goods_list = dic[@"goods_list"];
            for (NSDictionary *dic in goods_list) {
                LYGoodsModel * model = [LYGoodsModel mj_objectWithKeyValues:dic];
                [self.goods_listArray addObject:model];
            }
            self.addressDic = dic[@"address"];
            self.coupon_listArray = dic[@"coupon_list"];
            exist_address = [dic[@"exist_address"]boolValue];
            is_allow_points = [dic[@"is_allow_points"]boolValue];
            [self.contentArray addObject: self.coupon_listArray.count > 0?@"选择优惠券":@"暂无可用"];
            if (![self.addressDic isKindOfClass:[NSNull class]]) {
                [self.sureParamDic setValue:self.addressDic[@"address_id"] forKey:@"address_id"];
            }
            [self.titleArray addObject:@"优惠券"];
            [self.contentArray addObject:[NSString stringWithFormat:@"-￥%@",dic[@"grade_money"]]];
            [self.titleArray addObject:@"会员折扣"];
            if (is_allow_points) {
                [self.contentArray addObject:[NSString stringWithFormat:@" ￥%@",dic[@"points_money"]]];
                [self.titleArray addObject:@"积分抵扣"];
            }
            [self.contentArray addObject:[NSString stringWithFormat:@"￥%@",dic[@"express_price"]]];
            [self.titleArray addObject:@"运费"];
            [self.contentArray addObject:[NSString stringWithFormat:@"￥%@",dic[@"order_pay_price"]]];
            [self.titleArray addObject:@"实付金额"];
            self.numLabel.text = [NSString stringWithFormat:@"共%@件,合计￥%@",_dataDic[@"order_total_num"],_dataDic[@"order_pay_price"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tabeleView reloadData];
            });
        }else{
            ShowErrorHUD(responseMessage);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark 购物车进入时所请求的数据
-(void)getData{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/order/cartBuyNow" param:self.cardsDic success:^(id responseObject, BOOL success) {
        NSLog(@"确认订单数据=====%@",responseJSONString);
        [self hideEmptyView];
        if (responseSuccess) {
            [self.goods_listArray removeAllObjects];
            [self.titleArray removeAllObjects];
            [self.contentArray removeAllObjects];
            NSDictionary * dic = responseObject[@"data"];
            _dataDic = dic;
            NSArray * goods_list = dic[@"goods_list"];
            for (NSDictionary *dic in goods_list) {
                LYGoodsModel * model = [LYGoodsModel mj_objectWithKeyValues:dic];
                [self.goods_listArray addObject:model];
            }
            self.addressDic = dic[@"address"];
            self.coupon_listArray = dic[@"coupon_list"];
            exist_address = [dic[@"exist_address"]boolValue];
            is_allow_points = [dic[@"is_allow_points"]boolValue];
            [self.contentArray addObject: self.coupon_listArray.count > 0?@"选择优惠券":@"暂无可用"];
            if (![self.addressDic isKindOfClass:[NSNull class]]) {
                [self.sureParamDic setValue:self.addressDic[@"address_id"] forKey:@"address_id"];
            }
            [self.titleArray addObject:@"优惠券"];
            [self.contentArray addObject:[NSString stringWithFormat:@"-￥%@",dic[@"grade_money"]]];
            [self.titleArray addObject:@"会员折扣"];
            if (is_allow_points) {
                [self.contentArray addObject:[NSString stringWithFormat:@" ￥%@",dic[@"points_money"]]];
                [self.titleArray addObject:@"积分抵扣"];
            }
            [self.contentArray addObject:[NSString stringWithFormat:@"￥%@",dic[@"express_price"]]];
            [self.titleArray addObject:@"运费"];
            [self.contentArray addObject:[NSString stringWithFormat:@"￥%@",dic[@"order_pay_price"]]];
            [self.titleArray addObject:@"实付金额"];
            self.numLabel.text = [NSString stringWithFormat:@"共%@件,合计￥%@",dic[@"order_total_num"],dic[@"order_pay_price"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tabeleView reloadData];
            });
        }
    } fail:^(NSError *error) {
        [self hideEmptyView];
    }];
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 87;
    }else if (indexPath.section == 1) {
        return 140;
    }
    
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (exist_address) {
            return 1;
        }else{
            return 1;
        }
    }else if (section == 2){
        return self.titleArray.count;
    }
    
    return self.goods_listArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MJWeakSelf;
        if (exist_address) {
            MyAddressListVC * vc = [[MyAddressListVC alloc]init];
            vc.address_id = self.addressDic[@"address_id"];
            vc.block = ^(AddressModel * _Nonnull model) {
                NSLog(@"窝巢啊===%@",model.address_id);
                [weakSelf.sureParamDic setValue:model.address_id forKey:@"address_id"];
            };
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [nav setModalPresentationStyle:UIModalPresentationOverCurrentContext];
            [self presentViewController:nav animated:YES completion:nil];
        }else{
            AddMyAddressListVC * vc = [[AddMyAddressListVC alloc]init];
            vc.block = ^{
                if (self.type == DetailPush) {//正常商品
                    [self loadDataWithUrl:@"api/order/buyNow"];
                }else if(self.type == SharpDetailPush){//限时购买商品
                    [self loadDataWithUrl:@"api/sharp.order/buyNow"];
                }else{
                    [self getData];
                }
                
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }
    
    //    if (indexPath.section == 2) {
    //        SureOrderTwoCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    //        if (indexPath.row) {
    //
    //        }
    //    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *viewIdentfier = @"headView";
    SureOrderSectionHeadView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    if(!sectionHeadView){
        sectionHeadView = [[SureOrderSectionHeadView alloc] initWithReuseIdentifier:viewIdentfier];
    }
    if (section == 1) {
        sectionHeadView.textStr = @"商品信息";
        
    }else if (section == 2){
        sectionHeadView.textStr = @"订单信息";
        
    }
    
    return sectionHeadView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString *viewIdentfier = @"footView";
    if (section == 0) {
        return nil;
    }
    SureOrderSectionFootView * sectionFootView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    if(!sectionFootView){
        sectionFootView = [[SureOrderSectionFootView alloc] initWithReuseIdentifier:viewIdentfier];
    }
    return sectionFootView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 10;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 38;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (exist_address) {
            MyAddressListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellAddressID];
                   [cell.radioButn setImage:CCImage(@"jft_icon_position") forState:UIControlStateNormal];
                   [cell.editButn setImage:CCImage(@"jft_icon_rightarrow") forState:UIControlStateNormal];
                   cell.selectionStyle = UITableViewCellSelectionStyleNone;
                   
                   if (self.addressDic != nil) {
                       AddressModel * model = [AddressModel mj_objectWithKeyValues:self.addressDic];
                       cell.model = model;
                   }
            return cell;
        }
        else{
            BuynowOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDB];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
    
    else if (indexPath.section == 1) {
        SureOrderGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWidth - 20 , 140) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(7, 7)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = CGRectMake(0, 0, ScreenWidth- 20 , 140);
            maskLayer.path = maskPath.CGPath;
            cell.layer.mask  = maskLayer;
        }
        LYGoodsModel * model = self.goods_listArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    MJWeakSelf;
    SureOrderTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellTwoID];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    [cell.descBtn setTitle:self.contentArray[indexPath.row] forState:UIControlStateNormal];
    if (indexPath.row == 0) {
        [cell.descBtn setImage:[UIImage imageNamed:@"jft_icon_rightarrow"] forState:0];
        if (couopnsDic) {
            if ([[NSString stringWithFormat:@"%@",couopnsDic[@"user_coupon_id"]] length] == 0) {
                [cell.descBtn setTitle:@"不使用优惠券" forState:0];
                cell.descBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - 3);
            }else{
                [cell.descBtn setTitle:[NSString stringWithFormat:@"-￥%@",couopnsDic[@"reduced_price"]] forState:0];
            }
        }
        cell.btnClick = ^(QMUIButton * _Nonnull btn) {
            if ([btn.titleLabel.text isEqualToString:@"暂无可用"]) {
                return ;
            }
            NSLog(@"选择优惠券");
            [self selectCoupons:btn];
        };
    }else if(indexPath.row == 2){
        if (is_allow_points) {
            cell.descBtn.selected = cellBtnSelect;
            [cell.descBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];
            [cell.descBtn setImage:[UIImage imageNamed:@"jft_but_selected"] forState:UIControlStateSelected];
            cell.btnClick = ^(QMUIButton * _Nonnull btn) {
                cellBtnSelect = !cell.descBtn.selected;
                [self.sureParamDic setValue:@(cellBtnSelect) forKey:@"is_use_points"];//是否使用积分抵扣
                [self.prmDic setValue:@(cellBtnSelect) forKey:@"is_use_points"];
                [self.cardsDic setValue:@(cellBtnSelect) forKey:@"is_use_points"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (weakSelf.type == DetailPush) {
                        [weakSelf loadDataWithUrl:@"api/order/buyNow"];
                    }else if(weakSelf.type == SharpDetailPush){
                        [weakSelf loadDataWithUrl:@"api/sharp.order/buyNow"];
                    }else{
                        [self getData];
                    }
                });
            };
        }else{
            cell.btnClick = ^(QMUIButton * _Nonnull btn) {};
        }
        
    }else{
        cell.btnClick = ^(QMUIButton * _Nonnull btn) {};
    }
    
    return cell;
}
//选择优惠券
- (void)selectCoupons:(UIButton *)butn{
    SelectCouponsView * contentView = [[SelectCouponsView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
    contentView.dataArray = self.coupon_listArray;
    if (couopnsDic) {
        contentView.selectIndexPath = couopnsDic[@"indexPath"];
    }
    QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
    modalViewController.contentView = contentView;
    modalViewController.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
        contentView.qmui_frameApplyTransform = CGRectSetXY(contentView.frame, CGFloatGetCenter(CGRectGetWidth(containerBounds), CGRectGetWidth(contentView.frame)), CGRectGetHeight(containerBounds) - CGRectGetHeight(contentView.frame));
    };
    modalViewController.showingAnimation = ^(UIView *dimmingView, CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewFrame, void(^completion)(BOOL finished)) {
        contentView.frame = CGRectSetY(contentView.frame, CGRectGetHeight(containerBounds));
        dimmingView.alpha = 0;
        [UIView animateWithDuration:.25 delay:0.0 options:QMUIViewAnimationOptionsCurveOut animations:^{
            dimmingView.alpha = 1;
            contentView.frame = contentViewFrame;
        } completion:^(BOOL finished) {
            // 记住一定要在适当的时机调用completion()
            if (completion) {
                completion(finished);
            }
        }];
    };
    modalViewController.hidingAnimation = ^(UIView *dimmingView, CGRect containerBounds, CGFloat keyboardHeight, void(^completion)(BOOL finished)) {
        [UIView animateWithDuration:.25 delay:0.0 options:QMUIViewAnimationOptionsCurveOut animations:^{
            dimmingView.alpha = 0.0;
            contentView.frame = CGRectSetY(contentView.frame, CGRectGetHeight(containerBounds));
        } completion:^(BOOL finished) {
            // 记住一定要在适当的时机调用completion()
            if (completion) {
                completion(finished);
            }
        }];
    };
    [modalViewController showWithAnimated:YES completion:nil];
    MJWeakSelf;
    contentView.hideView = ^(NSDictionary * _Nonnull dic) {
        couopnsDic = dic;
        [modalViewController hideWithAnimated:YES completion:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.prmDic setValue:couopnsDic[@"user_coupon_id"] forKey:@"coupon_id"];
            [self.sureParamDic setValue:couopnsDic[@"user_coupon_id"] forKey:@"coupon_id"];
            [self.cardsDic setValue:couopnsDic[@"user_coupon_id"] forKey:@"coupon_id"];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.type == DetailPush) {
                    [weakSelf loadDataWithUrl:@"api/order/buyNow"];
                }else if(weakSelf.type == SharpDetailPush){
                    [weakSelf loadDataWithUrl:@"api/sharp.order/buyNow"];
                }else{
                    
                    [self getData];
                }
            });
        });
    };
    
}


-(UITableView *)tabeleView{
    if (_tabeleView == nil) {
        _tabeleView = [[UITableView alloc]initWithFrame:CGRectInset(CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49 - kBottomSafeHeight), 10, 0) style:UITableViewStyleGrouped];
        _tabeleView.delegate = self;
        _tabeleView.dataSource =self;
        _tabeleView.separatorColor = kUIColorFromRGB(0xf5f5f5);
        _tabeleView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _tabeleView.estimatedSectionFooterHeight = 20;
        _tabeleView.estimatedSectionHeaderHeight = 38;
        _tabeleView.backgroundColor = [UIColor clearColor];
        _tabeleView.showsVerticalScrollIndicator = NO;
        [_tabeleView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
        [_tabeleView registerNib:[UINib nibWithNibName:cellAddressID bundle:nil] forCellReuseIdentifier:cellAddressID];
        [_tabeleView registerNib:[UINib nibWithNibName:cellTwoID bundle:nil] forCellReuseIdentifier:cellTwoID];
        [_tabeleView registerNib:[UINib nibWithNibName:cellIDB bundle:nil] forCellReuseIdentifier:cellIDB];

    }
    return _tabeleView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 49 - kBottomSafeHeight, ScreenWidth, 49+kBottomSafeHeight)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        line.backgroundColor = kUIColorFromRGB(0xF5F5F5);
        [_bottomView addSubview:line];
    }
    return _bottomView;
}


- (UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]init];
        _numLabel.text = @"共0件，合计￥0.0";
        _numLabel.font = [UIFont systemFontOfSize:15];
        _numLabel.textColor = kUIColorFromRGB(0x666666);
    }
    return _numLabel;
}

- (UIButton *)payBtn{
    if (!_payBtn) {
        MJWeakSelf;
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn setTitle:@"立即支付" forState:0];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_payBtn setBackgroundImage:[UIImage imageNamed:@"jft_but_purchase"] forState:0];
        [_payBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf payBtnClick];
        }];
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _payBtn;
}

#pragma mark 确认订单参数拼接 ---立即支付
- (void)payBtnClick{
    
    NSDictionary * goods = _dataDic[@"goods_list"][0];
    if (self.type == CartPush) {
        NSMutableArray * sku_idArr = [NSMutableArray array];
        NSMutableArray * goods_idArr = [NSMutableArray array];
        NSInteger sum = 0;
        for (LYGoodsModel * model in self.goods_listArray) {
            [sku_idArr addObject:model.goods_sku[@"spec_sku_id"]];
            sum += [model.goods_sales integerValue];
            [goods_idArr addObject:model.goods_id];
        }

        [self.sureParamDic setValue:self.cart_ids forKey:@"cart_ids"];
    }else if(self.type == DetailPush){
        [self.sureParamDic setValue:goods[@"total_num"] forKey:@"goods_num"];
        [self.sureParamDic setValue:goods[@"spec_sku_id"] forKey:@"spec_sku_id"];
        [self.sureParamDic setValue:goods[@"goods_id"] forKey:@"goods_id"];
    }else{
        [self.sureParamDic setValue:goods[@"total_num"] forKey:@"goods_num"];
        [self.sureParamDic setValue:goods[@"spec_sku_id"] forKey:@"spec_sku_id"];
        [self.sureParamDic setValue:goods[@"sharp_goods_id"] forKey:@"sharp_goods_id"];
    }
    NSString * URLString;
    switch (self.type) {
        case 0:
            URLString = @"api/order/cartCreateOrder";
            break;
        case 1:
            URLString = @"api/order/createOrder";
            break;
        case 2:
            URLString = @"api/sharp.order/createOrder";
            break;
    }
    [self loadDataURL:URLString];
    
}
#pragma mark 确认订单请求
- (void)loadDataURL:(NSString*)url{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:url param:self.sureParamDic success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        if (responseSuccess) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCartData" object:nil];
            NSLog(@"确认订单数据===%@",responseJSONString);
            OrderPayViewController * vc = [[OrderPayViewController alloc]init];
            vc.dataSource = responseObject;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:vc animated:YES];
            });
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        [self hideEmptyView];
        ShowErrorHUD(@"服务器错误");
    }];
}


-(NSMutableArray *)goods_listArray{
    if (_goods_listArray == nil) {
        _goods_listArray = [[NSMutableArray alloc] init];
    }
    return _goods_listArray;
}

- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableDictionary *)sureParamDic{
    if (!_sureParamDic) {
        _sureParamDic = [NSMutableDictionary dictionary];
    }
    return _sureParamDic;
}

- (NSMutableDictionary *)cardsDic{
    if (!_cardsDic) {
        _cardsDic = [NSMutableDictionary dictionary];
    }
    return _cardsDic;
}
@end
