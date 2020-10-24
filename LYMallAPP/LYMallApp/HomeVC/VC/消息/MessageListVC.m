//
//  MessageListVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/5.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MessageListVC.h"
#import "MessageListCell.h"
#import "ChatMeassageVC.h"
#import "SystemMessageVC.h"
@interface MessageListVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary  *dataDic;

@end
static NSString *cellID = @"MessageListCell";
@implementation MessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    [self getData];
    self.tableView.tableFooterView = [UIView new];
}


-(void)getData{
    [NetWorkConnection postURL:@"api/customerservice/get_list" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"消息-=====%@",responseJSONString);
        self.dataDic = responseObject[@"data"];
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}


//显示多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;//设置多少组数据
}
//列表中每一个view对象，设置每一个view的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (indexPath.row == 0) {
        cell.titLable.text = @"系统消息";
        cell.contentLable.text = self.dataDic[@"system"][@"content"];
        cell.timeLabel.text = self.dataDic[@"system"][@"last_time"];

        cell.imgView.image = CCImage(@"jft_icon_notice");
    }else{
        cell.contentLable.text = self.dataDic[@"service"][@"content"];
        cell.timeLabel.text = self.dataDic[@"service"][@"last_time"];
       cell.titLable.text = @"我的客服";
        cell.imgView.image = CCImage(@"jft_icon_customerservice");
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    if (indexPath.row == 1) {
        [NetWorkConnection postURL:@"api/customerservice/logs" param:nil success:^(id responseObject, BOOL success) {
            if (responseMessage) {
                ChatMeassageVC * vc = [ChatMeassageVC new];
                vc.title = @"消息";
                vc.record_id = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"record_id"]];
                [self.navigationController pushViewController:vc animated:YES];
            }
        } fail:^(NSError *error) {
    
        }];
    }else{
        SystemMessageVC * vc = [[SystemMessageVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
}




@end
