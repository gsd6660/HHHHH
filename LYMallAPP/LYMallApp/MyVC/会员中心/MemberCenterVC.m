//
//  MemberCenterVC.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/1.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MemberCenterVC.h"
#import "MemberOneCell.h"
#import <WebKit/WebKit.h>
#import "MallVC.h"
@interface MemberCenterVC ()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate>
{
   
    NSString * _viprule;
    WKWebView * wkWebView;
    UIView * footView;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
@property (weak, nonatomic) IBOutlet QMUIFillButton *upBtn;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *loadProgress;
@property (weak, nonatomic) IBOutlet UILabel *leftTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTipLabel;
@property (nonatomic, strong)NSMutableArray * vipArray;
@end

static NSString * cellOnnID = @"MemberOneCell";

@implementation MemberCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员中心";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:cellOnnID bundle:nil] forCellReuseIdentifier:cellOnnID];
    [self addTableViewFooterView];
    [self loadData];
}


- (void)loadData{
    [NetWorkConnection postURL:@"api/user.viprule/index" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"%@",responseObject);
        if (responseSuccess) {
            NSDictionary * infoDic = responseObject[@"data"][@"vip_info"];
            [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:infoDic[@"avatarUrl"]]];
            self.nameLabel.text = infoDic[@"nickName"];
            self.integralLabel.text =[NSString stringWithFormat:@"我的积分：%d",[infoDic[@"points"]intValue]];
            self.descLabel.text = [NSString stringWithFormat:@"当前会员等级:%@",infoDic[@"vipname"]];
            self.bottomDescLabel.text = [NSString stringWithFormat:@"%@",infoDic[@"next_expend_money"]];
            self.rightTipLabel.text = infoDic[@"next_vipname"];
            self.leftTipLabel.text = infoDic[@"vipname"];
            NSArray * data = responseObject[@"data"][@"vip_rights"];
            if (data.count > 0) {
                for (NSDictionary *dic in data) {
                    [self.vipArray addObject:dic];
                }
            }
            self->_viprule = responseObject[@"viprule"];
            CGFloat nextV = [infoDic[@"need_points"]floatValue];
            CGFloat currenV = [infoDic[@"points"]floatValue];
            [self.loadProgress setProgress:currenV/(nextV +currenV) animated:YES];
            NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
            "<head> \n"
            "<style type=\"text/css\"> \n"
            "body {font-size:20px;}\n"
            "</style> \n"
            "</head> \n"
            "<body>"
            "<script type='text/javascript'>"
            "window.onload = function(){\n"
            "var $img = document.getElementsByTagName('img');\n"
            "for(var p in  $img){\n"
            " $img[p].style.width = '100%%';\n"
            "$img[p].style.height ='auto'\n"
            "}\n"
            "}"
            "</script>%@"
            "</body>"
            "</html>", responseObject[@"data"][@"viprule"]];
            [self->wkWebView loadHTMLString:htmlString baseURL:nil];
            [self.tableView reloadData];
        }else{
            ShowErrorHUD(responseMessage);
        }
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)addTableViewFooterView{
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    footView.backgroundColor = [UIColor whiteColor];
    wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 100)];
    wkWebView.navigationDelegate = self;
    [footView addSubview:wkWebView];
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    wkWebView.scrollView.scrollEnabled = NO;
    [webView evaluateJavaScript:@"document.body.scrollHeight"
              completionHandler:^(id result, NSError *_Nullable error) {
            //result 就是加载完成后 webView的实际高度
            //获取后返回重新布局
        CGFloat height = [result floatValue];
        self->footView.frame = CGRectMake(0, 0, ScreenWidth, 500);
        self->wkWebView.frame = CGRectMake(10, 0, ScreenWidth-20, 500);
        self.tableView.tableFooterView = self->footView;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.vipArray.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MemberOneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellOnnID];
    if (self.vipArray.count > 0) {
        NSDictionary *dic = self.vipArray[indexPath.row];
        cell.titleLabel.text = dic[@"title"];
        cell.descLabel.text = dic[@"text"];
        [cell.imgV yy_setImageWithURL:[NSURL URLWithString:dic[@"image"]] placeholder:nil];
    }
 
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 3, 20)];
    lineLabel.backgroundColor = kUIColorFromRGB(0xFED072);
    [bgView addSubview:lineLabel];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(23, 15, 100, 20)];
    titleLabel.textColor = kUIColorFromRGB(0x333333);
    titleLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:titleLabel];
    if (section == 0) {
        titleLabel.text = @"会员权益";
    }else{
        titleLabel.text = @"会员体系规则";
    }
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (IBAction)upButn:(UIButton *)sender {
   
    MallVC * vc = [[MallVC alloc]init];
    vc.title = @"商城";
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSMutableArray *)vipArray{
    if (!_vipArray) {
        _vipArray = [NSMutableArray array];
    }
    return _vipArray;
}

@end
