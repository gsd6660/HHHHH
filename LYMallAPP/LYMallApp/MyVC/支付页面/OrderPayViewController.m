//
//  OrderPayViewController.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/1.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "OrderPayViewController.h"
#import "OrderPayCell.h"
#import "AddBankCardVC.h"
#import "BankCardListVC.h"
#import "PaySuccessVC.h"
@interface OrderPayViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * balanceStr;
    NSString * URLString;
}
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oderNumLabel;
@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@property (nonatomic,strong)NSString * payType;
@property (nonatomic,strong)NSMutableArray * dataArray;

@property (nonatomic,strong)NSMutableDictionary * payDic;
@end

static NSString * orderPayCellID = @"OrderPayCell";

@implementation OrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付订单";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:orderPayCellID bundle:nil] forCellReuseIdentifier:orderPayCellID];
  
    self.tableView.tableFooterView = [UIView new];
    
    [self.payBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        NSLog(@"立即支付");
        [self payClick];
    }];
    
    if (self.dataSource) {
        NSDictionary *  orderDic = self.dataSource[@"data"][@"order"];
        self.oderNumLabel.text = [NSString stringWithFormat:@"订单编号:%@",orderDic[@"order_no"]];
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",orderDic[@"pay_price"]];
        balanceStr = self.dataSource[@"data"][@"balance"];
        [self.payDic setValue:orderDic[@"order_id"] forKey:@"order_id"];
        self.order_id = [NSString stringWithFormat:@"%@",orderDic[@"order_id"]];
         [self countDown:self.dataSource[@"data"][@"pay_time"]];
        [self.tableView reloadData];
    }else{
        [self loadData];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResult:) name:@"payResult" object:@"success"];

    
    [self getPayType];
    
}


-(void)getPayType{
    [NetWorkConnection postURL:@"api/order/getPayType" param:@{@"order_id":self.order_id} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            NSLog(@"获取支付类型=====%@",responseJSONString);
            NSArray * datas = responseObject[@"data"];

            for (NSDictionary *dic in datas) {
                [self.dataArray addObject:dic];
            }
            [self.tableView reloadData];
            
            
        }
    } fail:^(NSError *error) {
        
    }];
}



-(void)payResult:(NSNotification *)noti{
    [self goSuccessVC];
}

- (void)loadData{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/user.order/pay" param:@{@"order_id":self.order_id} success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        if (responseSuccess) {
            NSDictionary *  orderDic = responseObject[@"data"][@"order"];
            self.oderNumLabel.text = [NSString stringWithFormat:@"订单编号:%@",orderDic[@"order_no"]];
            self.priceLabel.text = [NSString stringWithFormat:@"￥%@",orderDic[@"pay_price"]];
            balanceStr = responseObject[@"data"][@"balance"];
            [self.tableView reloadData];
            [self.payDic setValue:orderDic[@"order_id"] forKey:@"order_id"];
         self.order_id = [NSString stringWithFormat:@"%@",orderDic[@"order_id"]];

            [self countDown:responseObject[@"data"][@"pay_time"]];
            
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
}

- (void)payClick{
    MJWeakSelf;
   
    [self.payDic setValue:self.order_id forKey:@"order_id"];
    [self.payDic setValue:self.payType forKey:@"pay_type"];

    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/order/pay" param:self.payDic success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        if (responseSuccess) {
            NSString * payContent = responseObject[@"data"][@"payment"];
            NSString * payType1 = responseObject[@"data"][@"pay_type"];
            [weakSelf goPay:payContent payType:payType1];
        }else{
            ShowErrorHUD(responseMessage);
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
    }else {
        ShowHUD(@"支付成功");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:nil];
        [self goSuccessVC];
    }
}

-(void)goSuccessVC{
    PaySuccessVC * vc = [[PaySuccessVC alloc]init];
    vc.order_id = self.order_id;
    [self.navigationController pushViewController:vc animated:YES];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
          [center postNotificationName:@"refreshCartData" object:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderPayCell * cell = [tableView dequeueReusableCellWithIdentifier:orderPayCellID];
    NSDictionary * dic = self.dataArray[indexPath.row];

    [cell.imgView yy_setImageWithURL:[NSURL URLWithString:dic[@"image"]] placeholder:nil];
    cell.titleLabel.text = dic[@"name"];
    if ([dic[@"money"] length] > 0 && [dic[@"is_show_money"] boolValue] == YES) {
        cell.balanceLabel.text = [NSString stringWithFormat:@"当前余额:￥%@",dic[@"money"]];

    }
    if (indexPath.row == 0) {
         self.payType = [NSString stringWithFormat:@"%@",self.dataArray[0][@"pay_type"]];
    }
    
    if (_selIndex == indexPath) {
           [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_selected"] forState:UIControlStateNormal];
       }else{
           [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];
       }
       if (indexPath.row==0) {//指定第一行为选中状态
           [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_selected"] forState:UIControlStateNormal];
       }else{
           [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];
       }
   
        [cell.selectBtn setTitle:@"" forState:0];
        cell.selectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [cell.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row < 3) {
        //之前选中的，取消选择
        OrderPayCell *celled = [tableView cellForRowAtIndexPath:_selIndex];

            [celled.selectBtn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:UIControlStateNormal];
        
        //记录当前选中的位置索引
        _selIndex = indexPath;
        //当前选择的打勾
        OrderPayCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.selectBtn setImage: [UIImage imageNamed:@"jft_but_selected"] forState:UIControlStateNormal];
        self.payType = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"pay_type"]];
               NSLog(@"选择====%@",self.payType);

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 30)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    label.text = @"选择支付方式";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = kUIColorFromRGB(0x333333);
    [bgView addSubview:label];
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


-(void)countDown:(NSString *)secondsCountDown{
      __weak __typeof(self) weakSelf = self;

         __block int timeout= [secondsCountDown intValue]; //倒计时时间
           dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
           dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
           dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
           dispatch_source_set_event_handler(_timer, ^{
               if(timeout<=0){ //倒计时结束，关闭
                   dispatch_source_cancel(_timer);
                   dispatch_async(dispatch_get_main_queue(), ^{
                       //设置界面的按钮显示 根据自己需求设置
                       self.timeLabel.text = @"支付超时，订单失效";
                       
                   });
               }else{
                   NSInteger days = (int)(timeout/(3600*24));
                                       NSInteger hours = (int)((timeout-days*24*3600)/3600);
                                       NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                                       NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                   NSString *strTime = [NSString stringWithFormat:@"支付倒计时 %02ld:%02ld:%02ld", (long)hours, (long)minute, (long)second];
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           if (days == 0) {
                                               weakSelf.timeLabel.text = strTime;
                                           } else {
                                               weakSelf.timeLabel.text = [NSString stringWithFormat:@"支付倒计时:%ld天%02ld:%02ld:%02ld", (long)days, (long)hours, (long)minute, (long)second];
                                           }

                                       });
                                       timeout--; // 递减
               }
           });
           dispatch_resume(_timer);
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
//    [WXApi registerApp:@"wx758120730fcc7401" universalLink:@"https://shui3v.jmlk.co/"];

    PayReq* request             = [[PayReq alloc] init];
    request.partnerId           = [dataDcit objectForKey:@"partnerid"];
    request.prepayId            = [dataDcit objectForKey:@"prepayid"];
    request.nonceStr            = [dataDcit objectForKey:@"noncestr"];
    request.timeStamp           = stamp.intValue;
    request.package             = [dataDcit objectForKey:@"package"];
    request.sign                = [dataDcit objectForKey:@"sign"];
    //调起微信客户端 支付
    [WXApi sendReq:request completion:^(BOOL success) {
      
    }];
    
    
    
}



-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (NSMutableDictionary *)payDic{
    if (!_payDic) {
        _payDic = [NSMutableDictionary dictionary];
    }
    return _payDic;
}

@end
