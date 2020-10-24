//
//  HomeTowCell.m
//  LYMallApp
//
//  Created by Mac on 2020/3/10.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "HomeTowCell.h"
#import "MessageVC.h"

@interface HomeTowCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation HomeTowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
}

-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    [self.dataArray removeAllObjects];

    NSArray * articles = dataDic[@"articles"];
    for (NSDictionary *dic in articles) {
        [self.dataArray addObject:dic];
    }
    [self.tableView reloadData];
    
    
    
}
//配置每个section(段）有多少row（行） cell
 //默认只有一个section
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self.dataArray.count;
}
//每行显示什么东西
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *cellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }

    //使用cell
     NSDictionary *dic = self.dataArray[indexPath.row];
     
     cell.textLabel.text = dic[@"article_title"];
     cell.textLabel.font = FONTSIZE(13);
     cell.textLabel.textColor = kUIColorFromRGB(0x666666);
     cell.detailTextLabel.text = dic[@"view_time"];
     cell.detailTextLabel.textColor =kUIColorFromRGB(0x666666);
     cell.detailTextLabel.font = FONTSIZE(13);
     return cell;
     
 }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 38;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        [[[self viewController]navigationController] pushViewController:vc animated:YES];
        
        
    } fail:^(NSError *error) {
        
    }];
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, kWithSP(50))];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12.5, 18, 3, 17)];
    imageView.image = CCImage(@"green-juxing");
    [headView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(24,18,166,17);
    label.numberOfLines = 0;
    [headView addSubview:label];
    label.text = @"隆源资讯 NEWS";

    QMUIButton * butn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    butn.frame = CGRectMake(ScreenWidth - 53, 0, 60, kWithSP(50));
    [butn setTitle:@"更多" forState:UIControlStateNormal];
    [butn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
    butn.titleLabel.font = FONTSIZE(12);
    [butn setImage:CCImage(@"jft_icon_rightarrow") forState:UIControlStateNormal];
    butn.imagePosition = QMUIButtonImagePositionRight;
    butn.spacingBetweenImageAndTitle = 5;
    [butn addTarget:self action:@selector(moreButn:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:butn];
    return headView;
}

-(void)moreButn:(UIButton *)butn{
    MessageVC * vc = [[MessageVC alloc]init];
    [[self viewController].navigationController pushViewController:vc animated:YES];

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kWithSP(50);

}


-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
