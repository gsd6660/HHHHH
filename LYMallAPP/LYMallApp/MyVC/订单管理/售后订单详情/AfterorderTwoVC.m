//
//  AfterorderTwoVC.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/28.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AfterorderTwoVC.h"
#import "AfterOneCell.h"
#import "MyOrderOneCell.h"
#import "AfterTwoCell.h"
#import "AfterInfoCell.h"
#import "AfterInfoCell.h"
#import "MailGoodsVC.h"
#import "ExpressInfoCell.h"
#import "NCLookLogisticsVC.h"
@interface AfterorderTwoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _titleArray;
    //test
    NSArray * _numArray;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSDictionary * dataDic;
@property(nonatomic,strong)NSArray * goodsArray;
@end
static NSString * oneCellID = @"AfterOneCell";
static NSString *cellTwoID = @"MyOrderOneCell";
static NSString * cellThreeID = @"cellsID";
static NSString * cellFourID = @"AfterTwoCell";
static NSString * cellInfoID = @"AfterInfoCell";
static NSString * cellExpressID = @"ExpressInfoCell";
@implementation AfterorderTwoVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self.view addSubview:self.tableView];
     _titleArray = @[@"商品数量",@"订单总价",@"实付款"];
    [self.tableView registerNib:[UINib nibWithNibName:oneCellID bundle:nil] forCellReuseIdentifier:oneCellID];
    [self.tableView registerNib:[UINib nibWithNibName:cellTwoID bundle:nil] forCellReuseIdentifier:cellTwoID];
    [self.tableView registerNib:[UINib nibWithNibName:cellFourID bundle:nil] forCellReuseIdentifier:cellFourID];
    [self.tableView registerNib:[UINib nibWithNibName:cellInfoID bundle:nil] forCellReuseIdentifier:cellInfoID];
    [self.tableView registerNib:[UINib nibWithNibName:cellExpressID bundle:nil] forCellReuseIdentifier:cellExpressID];
    [self loadData];
    if (self.value == 6) {
        [self intBottomView];
        self.tableView.frame =CGRectMake(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight - SafeAreaTopHeight - 49 - kBottomSafeHeight);
    }
}


- (void)loadData{
    [NetWorkConnection postURL:@"api/user.refund/refund_order_detail" param:@{@"order_refund_id":self.order_id} success:^(id responseObject, BOOL success) {
        NSLog(@"售后详情数据====%@",responseJSONString);
        if (responseSuccess) {
            self.dataDic = responseObject[@"data"];
            self.goodsArray = self.dataDic[@"goods_info"];
            [self.tableView reloadData];
        }else{
            
        }
    } fail:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.value == 6) {
        if (section == 4) {
            return 3;
        }
        if (section == 4){
            return self.goodsArray.count;
        }
    }else{
        if (section == 3) {
            return 3;
        }
        if (section == 2){
            return self.goodsArray.count;
        }
    }
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.value == 6) {
        return 6;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.value == 6) {
        if (indexPath.section == 0) {
               return 60;
           }
           if (indexPath.section == 1) {
               return 120;
           }
           if (indexPath.section == 3) {
               return 110;
           }
           if (indexPath.section == 5) {
               return 300;
           }
    }else{
        if (indexPath.section == 0) {
               return 60;
           }
           if (indexPath.section == 1) {
               return 120;
           }
           if (indexPath.section == 2) {
               return 110;
           }
           if (indexPath.section == 4) {
               return 300;
           }
    }
   
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        AfterOneCell * cell = [tableView dequeueReusableCellWithIdentifier:oneCellID];
        if (self.dataDic) {
            cell.titleLabel.text = self.dataDic[@"state_text"][@"str"];
            cell.descLabel.text = self.dataDic[@"state_text"][@"text"];
        }
        return cell;
    }
    if (indexPath.section == 1) {
        
        ExpressInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellExpressID];
        if (self.dataDic) {
            if (self.value == 6) {
                NSDictionary * dic = self.dataDic[@"terrace_express"];
                cell.expressCompanyLabel.text = [NSString stringWithFormat:@"快递公司：%@",dic[@"terrace_express_name"]];
                  cell.expressNoLabel.text = [NSString stringWithFormat:@"运单号：%@",dic[@"terrace_express_no"]];
                  cell.timeLabel.text = dic[@"terrace_express_time"];
            }else{
                NSDictionary * expressDic = self.dataDic[@"user_send_logistics"];
               cell.expressCompanyLabel.text = [NSString stringWithFormat:@"快递公司：%@",expressDic[@"express_name"]];
               cell.expressNoLabel.text = [NSString stringWithFormat:@"运单号：%@",expressDic[@"express_no"]];
               cell.timeLabel.text = expressDic[@"express_time"];
            }            
        }
        return cell;
    }
    if (self.value == 6) {
        if (indexPath.section == 2) {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellInfo"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellInfo"];
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.text = @"查看我退回的物流信息";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
  
        if (indexPath.section == 3) {
            MyOrderOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTwoID];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.goodsArray.count>0) {
                [cell setAfterDetailModel:self.goodsArray[indexPath.row]];
            }
            return cell;
        }
        if (indexPath.section == 4) {
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
            if(self.dataDic){
                if (indexPath.row == 0) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"共%@件",self.dataDic[@"order_info"][@"total_num"]];
                }
                if (indexPath.row == 1) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",self.dataDic[@"order_info"][@"total_price"]];
                }
                if (indexPath.row == 2) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",self.dataDic[@"order_info"][@"pay_price"]];
                }
            }
            return cell;
        }
        if (indexPath.section == 5) {
            AfterTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellFourID];
            if (self.dataDic) {
                cell.itemlabel.text = self.dataDic[@"apply_info"][@"type"];
                cell.causeLabel.text = self.dataDic[@"apply_info"][@"desc_id"];
                cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.dataDic[@"apply_info"][@"refund_price"]];
                cell.numLabel.text =[NSString stringWithFormat:@"%@件",self.dataDic[@"apply_info"][@"refund_goods_num"]];
                cell.timeLabel.text = self.dataDic[@"apply_info"][@"apply_time"];
                NSString * desc = self.dataDic[@"apply_info"][@"apply_desc"];
                cell.descLabel.text = desc.length>0?desc:@"无";
                NSArray * images = self.dataDic[@"apply_info"][@"voucher_image"];
                 NSMutableArray * imageurls = [NSMutableArray array];
                 if (images.count>0) {
                    for (NSDictionary * dic in images) {
                        [imageurls addObject:dic[@"file_path"]];
                    }
                    cell.photoView.originalUrls = imageurls;
                }
            }
            return cell;
        }
    }else{
        if (indexPath.section == 2) {
            MyOrderOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTwoID];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.goodsArray.count>0) {
                [cell setAfterDetailModel:self.goodsArray[indexPath.row]];
            }
            return cell;
        }
        if (indexPath.section == 3) {
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
            if(self.dataDic){
                if (indexPath.row == 0) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"共%@件",self.dataDic[@"order_info"][@"total_num"]];
                }
                if (indexPath.row == 1) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",self.dataDic[@"order_info"][@"total_price"]];
                }
                if (indexPath.row == 2) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",self.dataDic[@"order_info"][@"pay_price"]];
                }
            }
            return cell;
        }
        if (indexPath.section == 4) {
            AfterTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellFourID];
            if (self.dataDic) {
                cell.itemlabel.text = self.dataDic[@"apply_info"][@"type"];
                cell.causeLabel.text = self.dataDic[@"apply_info"][@"desc_id"];
                cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.dataDic[@"apply_info"][@"refund_price"]];
                cell.numLabel.text =[NSString stringWithFormat:@"%@件",self.dataDic[@"apply_info"][@"refund_goods_num"]];
                cell.timeLabel.text = self.dataDic[@"apply_info"][@"apply_time"];
                NSString * desc = self.dataDic[@"apply_info"][@"apply_desc"];
                cell.descLabel.text = desc.length>0?desc:@"无";
                
                NSArray * images = self.dataDic[@"apply_info"][@"voucher_image"];
                NSMutableArray * imageurls = [NSMutableArray array];
                if (images.count>0) {
                   for (NSDictionary * dic in images) {
                       [imageurls addObject:dic[@"file_path"]];
                   }
                   cell.photoView.originalUrls = imageurls;
               }
            }
            return cell;
        }
    }
    
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.value==6) {
        
        if (indexPath.section == 2) {
            NSLog(@"我退回的物流信息");
            NCLookLogisticsVC * vc = [[NCLookLogisticsVC alloc]init];
            vc.order_id = self.order_id;
            vc.is_refund = 1;
            vc.typeString = @"1";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 1){
        NCLookLogisticsVC * vc = [[NCLookLogisticsVC alloc]init];
        vc.order_id = self.order_id;
        vc.is_refund = 1;
        vc.typeString = @"2";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    label.text = @"商品信息";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:label];
     
    if (self.value == 6) {
        if (section == 1) {
            label.text = @"卖家已发货";
            return bgView;
        }
        if (section == 3){
            label.text = @"商品信息";
            return bgView;
        }
    }else {
        if (section == 2) {
            label.text = @"商品信息";
            return bgView;
        }
    }
        return [UIView new];

}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.value == 6) {
        if (section == 1) {
            return 40;
        }
        if (section == 3) {
            return 40;
        }
    }else{
        if (section == 2) {
            return 40;
        }
    }
    
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
 
    if (self.value == 6) {
        if (section == 3) {
            return 0.1f;
        }
    }else{
        if (section == 2) {
            return 0.1f;
        }
    }
        return 10;
     
}

- (void)initNav{
    CGFloat H1 = ScreenHeight > 812 ? 45 : 35;
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0,0,ScreenWidth,SafeAreaTopHeight);
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,ScreenWidth,SafeAreaTopHeight);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:58/255.0 green:205/255.0 blue:123/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:89/255.0 green:229/255.0 blue:151/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    
    [bgView.layer addSublayer:gl];
    
    UIButton * leftButn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButn setImage:CCImage(@"jft_but_whitearrow") forState:UIControlStateNormal];
    leftButn.frame = CGRectMake(10, H1, 80, 30);
    leftButn.backgroundColor = [UIColor clearColor];
    [leftButn addTarget:self action:@selector(leftButn:) forControlEvents:UIControlEventTouchUpInside];
    leftButn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftButn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    [bgView addSubview:leftButn];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake((ScreenWidth - 100) /2,H1,100,18);
    label.numberOfLines = 0;
    label.text = @"售后详情";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONTSIZE(19);
    label.textColor = [UIColor whiteColor];
    [bgView addSubview:label];
    [self.view addSubview:bgView];
    
    
}
-(void)leftButn:(UIButton *)butn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)intBottomView{
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0,ScreenHeight - 49 - kBottomSafeHeight,ScreenWidth,49+kBottomSafeHeight);
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.shadowColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:0.75].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,0);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 11;
    [self.view addSubview:view];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"确认收货" forState:0];
    [button setTitleColor:kUIColorFromRGB(0x333333) forState:0];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.frame = CGRectMake(ScreenWidth - 100, 10, 77, 35);
    button.layer.cornerRadius = 17.5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = kUIColorFromRGB(0xB5B5B5).CGColor;
    [view addSubview:button];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [self sure_goodsClick];
    }];
    
}

- (void)sure_goodsClick{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/user.refund/refund_reap_goods" param:@{@"order_refund_id":self.order_id} success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        if (responseSuccess) {
            ShowHUD(responseMessage);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        [self hideEmptyView];
        ShowErrorHUD(@"网络错误");
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight - SafeAreaTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
