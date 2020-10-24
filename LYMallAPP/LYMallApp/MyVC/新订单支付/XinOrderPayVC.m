//
//  XinOrderPayVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/29.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "XinOrderPayVC.h"
#import "XinOrderPayOneCell.h"
#import "XinOrderPayTwoCell.h"
#import "XinOrderPayThreeCell.h"
#import "SelectPayTypeVC.h"
#import "PaySuccessVC.h"
#import "BuynowOneCell.h"
#import "MyAddressListVC.h"
#import "AddMyAddressListVC.h"
#import "AddressModel.h""
@interface XinOrderPayVC ()<NumberCalculateDelegate,SelectPayTypeDelegate>
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *payButn;
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)NSString *payType;
@property(nonatomic,strong)NSString *number;
@property(nonatomic,strong)NSString * order_id;//订单ID
@property(nonatomic,strong)NSMutableDictionary * sureParamDic;
@property(nonatomic,strong)NSMutableDictionary * addressDataDic;
@property(nonatomic,strong)NSMutableDictionary * addressDic;

@end

static NSString * cellID = @"XinOrderPayOneCell";
static NSString * cellTwoID = @"XinOrderPayTwoCell";
static NSString * cellThreeID = @"XinOrderPayThreeCell";
static NSString * cellIDB = @"BuynowOneCell";


@implementation XinOrderPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单支付";
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    [self.tableView registerNib:[UINib nibWithNibName:cellTwoID bundle:nil] forCellReuseIdentifier:cellTwoID];
    [self.tableView registerNib:[UINib nibWithNibName:cellThreeID bundle:nil] forCellReuseIdentifier:cellThreeID];
    [self.tableView registerNib:[UINib nibWithNibName:cellIDB bundle:nil] forCellReuseIdentifier:cellIDB];

    self.tableView.tableFooterView = [UIView new];
    [self getData];
    self.number = @"1";

   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResult:) name:@"payResult" object:@"success"];

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
    NSDictionary *dic = notif.userInfo[@"model"];

    [self.addressDataDic setValue:dic[@"address_id"] forKey:@"address_id"];
    [self.addressDataDic setValue:dic[@"phone"] forKey:@"phone"];

    [self.addressDataDic setValue:dic[@"name"] forKey:@"name"];
    [self.addressDataDic setValue:[NSString stringWithFormat:@"%@%@%@",dic[@"region"][@"province"],dic[@"region"][@"city"],dic[@"region"][@"region"]] forKey:@"address"];

    self.addressDic = self.addressDataDic;
    [self.sureParamDic setValue:self.dataDic[@"address"][@"address_id"] forKey:@"address_id"];
    [self.tableView reloadData];
}

-(void)payResult:(NSNotification *)noti{
    [self goSuccessVC];
}

-(void)getData{
    [self showEmptyViewWithLoading];

    [NetWorkConnection postURL:@"api/gift/gift_pay" param:@{@"gift_goods_id":self.gift_goods_id} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            self.dataDic = responseObject[@"data"];
            if ([CheackNullOjb cc_isNullOrNilWithObject:responseObject[@"data"][@"address"]] == NO) {
                self.addressDic = responseObject[@"data"][@"address"];

            }
            NSLog(@"新订单支付====%@",responseJSONString);
        }else{
            ShowErrorHUD(responseMessage);
            [self.navigationController popViewControllerAnimated:YES];
        }
        [self hideEmptyView];

        [self.tableView reloadData];
    } fail:^(NSError *error) {
        [self hideEmptyView];

    }];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
       

        if ([CheackNullOjb cc_isNullOrNilWithObject:self.addressDic] == NO) {
            
            XinOrderPayOneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                   cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.addressLabel.text = self.addressDic[@"address"];
            cell.nameLable.text = [NSString stringWithFormat:@"%@  %@",self.addressDic[@"name"],self.addressDic[@"phone"]];
         return cell;
        }else{
            BuynowOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDB];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
       
    }
    
  else  if (indexPath.section == 1) {
        XinOrderPayTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellTwoID];
      cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
    XinOrderPayThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellThreeID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([CheackNullOjb cc_isNullOrNilWithObject:self.dataDic[@"gift"]] == NO) {
               NSDictionary * dic = self.dataDic[@"gift"];
               cell.nameLable.text = [NSString stringWithFormat:@"%@",dic[@"gift_name"]];
        cell.nameLable.text = [NSString stringWithFormat:@"%@",dic[@"gift_name"]];
        cell.priceLbale.text = [NSString stringWithFormat:@"%@",dic[@"seckill_price"]];
        [cell.goodsImageView yy_setImageWithURL:[NSURL URLWithString:dic[@"image_url"]] placeholder:nil];
        cell.numLabel.baseNum = @"1";
        self.priceLable.text = [NSString stringWithFormat:@"合计：¥%.2f",[dic[@"seckill_price"]floatValue] * [self.num intValue]];

           }
    cell.numLabel.delegate = self;
    
    return cell;
    
    
    
}

//总金额计算
- (void)resultNumber:(NSString *)number{
    NSString * seckill_price = self.dataDic[@"gift"][@"seckill_price"];
    CGFloat price  = [number intValue] * [seckill_price floatValue];
    self.priceLable.text = [NSString stringWithFormat:@"合计：¥%.2f",price];
    self.number = number;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return 92;
    }else if (indexPath.section == 1){
        return 45;
    }
    return 111;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MJWeakSelf;
        if ([CheackNullOjb cc_isNullOrNilWithObject:self.dataDic[@"address"]] == NO) {
           MyAddressListVC * vc = [[MyAddressListVC alloc]init];
                      vc.address_id = self.dataDic[@"address"][@"address_id"];
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
                [weakSelf getData];
            };
            [self.navigationController pushViewController:vc animated:YES];
    }
        
    }
        
    if (indexPath.section == 1) {
        SelectPayTypeVC * vc = [[SelectPayTypeVC alloc]init];
        vc.payDataArray = self.dataDic[@"pay_type"];
        vc.delegate =self;
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [nav setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        [self presentViewController:nav animated:NO completion:nil];
    }
        
}



-(void)getPayType:(NSString *)payType payName:(NSString *)name{
    self.payType = payType;
    XinOrderPayTwoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.payTypeLable.text = name;

}




- (IBAction)payButn:(UIButton *)sender {
    if ([CheackNullOjb cc_isNullOrNilWithObject:self.payType] == YES) {
        ShowErrorHUD(@"请选择支付方式");
        return;
    }
    [self showEmptyViewWithLoading];

    MJWeakSelf;
    [NetWorkConnection postURL:@"api/order/gift_pay" param:@{@"gift_id":self.gift_goods_id,@"pay_type":self.payType,@"number":self.number,@"address_id":self.addressDic[@"address_id"]} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            NSLog(@"下单========%@",responseJSONString);
        NSString * payContent = responseObject[@"data"][@"payment"];
        NSString * payType = responseObject[@"data"][@"pay_type"];
        [weakSelf goPay:payContent payType:payType];
        self.order_id = responseObject[@"data"][@"order_id"];
        [self hideEmptyView];
        }else{
            ShowErrorHUD(responseMessage);
            [self hideEmptyView];

        }
        
    } fail:^(NSError *error) {
        [self hideEmptyView];

    }];
            
    
}

-(void)goPay:(NSString *)payContent payType:(NSString *)paytype{
    
    if ([paytype isEqualToString:@"20"]) {
        [self weiChatPay:payContent];
    }else if ([paytype isEqualToString:@"30"]) {
        [self aliPay:payContent];
    }else if ([paytype isEqualToString:@"10"]) {
        ShowHUD(@"支付成功");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:nil];
        [self goSuccessVC];
    }
}

#pragma mark -----支付宝支付-------------
- (void)aliPay:(NSString *)objt{
    MJWeakSelf;
    NSString  *appScheme = @"LY"; //支付宝是通过这个白名单返回应用的
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:objt fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        if ([resultDic[@"resultStatus"] integerValue] == 9000){
            [QMUITips showSucceed:@"支付成功"];
            [self goSuccessVC];

        }else if ([resultDic[@"resultStatus"] integerValue] == 6001){
            [QMUITips showError:@"用户取消支付"];
        }else if ([resultDic[@"resultStatus"] integerValue] == 6002){
            [QMUITips showError:@"网络连接出错"];
        }else if ([resultDic[@"resultStatus"] integerValue] == 4000){
            [QMUITips showError:@"订单支付失败"];
        }
    }];
}

#pragma mark ------- 微信支付---------
- (void)weiChatPay:(NSString *)str{
    
    if([WXApi isWXAppInstalled] == NO)
    {
        [QMUITips showInfo:@"请安装微信APP"];
        return;
    }
    NSDictionary *dataDcit= [str mj_JSONObject];
    NSMutableString *stamp  = [dataDcit objectForKey:@"timestamp"];
    [WXApi registerApp:@"wx758120730fcc7401" universalLink:@"https://shui3v.jmlk.co/"];

    PayReq* request             = [[PayReq alloc] init];
    request.partnerId           = [dataDcit objectForKey:@"partnerid"];
    request.prepayId            = [dataDcit objectForKey:@"prepayid"];
    request.nonceStr            = [dataDcit objectForKey:@"noncestr"];
    request.timeStamp           = stamp.intValue;
    request.package             = [dataDcit objectForKey:@"package"];
    request.sign                = [dataDcit objectForKey:@"sign"];
    //调起微信客户端 支付
    [WXApi sendReq:request completion:^(BOOL success) {
        if (success == YES) {
            [self goSuccessVC];

        }
    }];
    
}


-(void)goSuccessVC{
    PaySuccessVC * vc = [[PaySuccessVC alloc]init];
    vc.order_id = self.order_id;
    [self.navigationController pushViewController:vc animated:YES];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
          [center postNotificationName:@"refreshCartData" object:nil];
}
- (NSMutableDictionary *)sureParamDic{
    if (!_sureParamDic) {
        _sureParamDic = [NSMutableDictionary dictionary];
    }
    return _sureParamDic;
}

- (NSMutableDictionary *)addressDataDic{
    if (!_addressDataDic) {
        _addressDataDic = [NSMutableDictionary dictionary];
    }
    return _addressDataDic;
}


@end
