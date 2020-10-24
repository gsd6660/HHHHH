//
//  MessageVC.m
//  LYMallApp
//
//  Created by Mac on 2020/3/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MessageVC.h"
#import "MessageCell.h"
#import "MessageHeadView.h"
@interface MessageVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) MessageHeadView *headView;
@property (strong, nonatomic) NSMutableArray  *dataArray;
@property (strong, nonatomic) NSMutableArray  *imageArray;

@end
static NSString * cellID = @"MessageCell";
@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隆源资讯";
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    self.headView = [[MessageHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    self.tableView.tableHeaderView = self.headView;
    [self getlongyuan_info_bannerData];
    [self getarticlelistsData];
}
//获取隆源资讯头部轮播
-(void)getlongyuan_info_bannerData{
    [NetWorkConnection postURL:@"api/article/longyuan_info_banner" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"资讯头部轮播===%@",responseJSONString);
        if (responseSuccess) {

            NSArray * arr = responseObject[@"data"];
            for (NSDictionary *dic in arr) {
                [self.imageArray addObject:dic];
            }
            self.headView.array = self.imageArray;
            [self.tableView reloadData];
            
        }
    } fail:^(NSError *error) {
        
    }];
}

//获取隆源咨询文章列表
-(void)getarticlelistsData{
    [NetWorkConnection postURL:@"api/article/lists" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"资讯文章列表===%@",responseJSONString);
        if (responseSuccess) {
            [self.dataArray removeAllObjects];
            NSArray * data = responseObject[@"data"][@"list"][@"data"];
            for (NSDictionary *dic in data) {
                [self.dataArray addObject:dic];
            }
            [self.tableView reloadData];
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
    MessageCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.dic = dic;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}

//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger cellnum=indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"我点击了第%ld行",cellnum);
     NSDictionary * dic = self.dataArray[indexPath.row];
        
        [NetWorkConnection postURL:@"api/article/detail" param:@{@"article_id":dic[@"article_id"]} success:^(id responseObject, BOOL success) {
            NSLog(@"文章详情====%@",responseMessage);
            
            WKWebViewVC * vc = [[WKWebViewVC alloc]init];
    //        vc.htmlString = responseObject[@"data"][@"detail"][@"article_content"];
            vc.htmlString = [NSString stringWithFormat:@"<html> \n"
            "<head> \n"
            "<style type=\"text/css\"> \n"
            "body {font-size:15px;}\n"
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
            "</html>", responseObject[@"data"][@"detail"][@"article_content"]];
            vc.title = responseObject[@"data"][@"detail"][@"article_title"];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        } fail:^(NSError *error) {
            
        }];
}



-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [[NSMutableArray alloc]init];
    }
    return _imageArray;
}
@end
