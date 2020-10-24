//
//  AppleyAgentVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/8.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AppleyAgentVC.h"
#import <WebKit/WebKit.h>
#import "DetailView.h"
#import "CommitAppleyDataVC.h"
@interface AppleyAgentVC ()<WKUIDelegate,WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet DetailView *wk;


@end

@implementation AppleyAgentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请代理";
    self.wk.UIDelegate =self;
    self.wk.navigationDelegate = self;
    [self getData];
    
    
    
}
-(void)getData{
    [NetWorkConnection postURL:@"api/agency.apply/apply_info" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"代理申请页面信息==%@",responseJSONString);
        if (responseSuccess) {
            NSString *urlStr = responseObject[@"data"][@"content"];
            [self.wk loadHTMLString:urlStr baseURL:[[NSBundle mainBundle] bundleURL]];
        }
        
    } fail:^(NSError *error) {
        
    }];
}



- (IBAction)applyButn:(QMUIFillButton *)sender {
    CommitAppleyDataVC * vc = [[CommitAppleyDataVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        LyinfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        return cell;
//    }
    
    static NSString * cellINFO = @"celllll";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellINFO] ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellINFO];
        cell.textLabel.textColor = kUIColorFromRGB(0x4D4D4D);
        cell.textLabel.font = FONTSIZE(15);
        cell.detailTextLabel.textColor = kUIColorFromRGB(0x4D4D4D);
        cell.detailTextLabel.font = FONTSIZE(15);
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"客服电话";
        cell.detailTextLabel.text = @"18738596637";
        cell.detailTextLabel.textColor = kUIColorFromRGB(0x2E7AFB);

    }
    
    return cell;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 18)];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 18;
}

@end

