//
//  SystemMessageVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/5.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "SystemMessageVC.h"
#import "MessageListDetailCell.h"
@interface SystemMessageVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray  *dataArray;

@end
static NSString *cellID = @"MessageListDetailCell";

@implementation SystemMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统消息";
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    [self getData];
}


-(void)getData{
    [NetWorkConnection postURL:@"api/customerservice/logs" param:@{@"type":@"2"} success:^(id responseObject, BOOL success) {
        if (responseMessage) {
            NSLog(@"系统消息===%@",responseJSONString);
            if (responseSuccess) {
                NSArray *data = responseObject[@"data"][@"logs"];
                for (NSDictionary *dic in data) {
                    [self.dataArray addObject:dic];
                }
                [self.tableView reloadData];
            }
        }
    } fail:^(NSError *error) {
        
    }];
}

//显示多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;//设置多少组数据
}
//列表中每一个view对象，设置每一个view的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageListDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.timeLabel.text = dic[@"update_time"];
    cell.contentLabel.text = dic[@"content"];

    return cell;
}



//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}



-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
@end
