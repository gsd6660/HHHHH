//
//  MyTeamVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/9.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MyTeamVC.h"
#import "MyTeamCell.h"
#import "MyTeamModel.h"
@interface MyTeamVC ()
{
    UIImageView * headView;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger page;

@end
static NSString * cellID = @"MyTeamCell";
@implementation MyTeamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.title = @"我的团队";
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, kHeightSP(130))];
    headView.userInteractionEnabled = YES;
//    headView.image = CCImage(@"jft_banner_team");
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [headView addGestureRecognizer:tap];
    self.tableView.tableHeaderView = headView;
    self.tableView.tableFooterView = [UIView new];
    [self getData];
    MJWeakSelf;
    self.tableView.mj_header = [YMRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf getData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf getData];
    }];
    
    
}

-(void)tap:(UITapGestureRecognizer *)tap{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]; //登录时候返回token
               NSLog(@"token====%@",token);
           if (token.length ==0) {
               token = @"";
           }
   WKWebViewVC * vc = [[WKWebViewVC alloc]init];
   vc.urlString = [NSString stringWithFormat:@"%@wap/invite/index&Authorization=%@",BaseUrl,token];
   [self.navigationController pushViewController:vc animated:YES];
}

-(void)getData{
    [NetWorkConnection postURL:@"api/user.dealer.team/lists" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"我的团队=====%@",responseJSONString);
        NSArray * data = responseObject[@"data"][@"list"];
        [headView sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"banner"]]];
        if (responseSuccess) {
            [self.dataArray removeAllObjects];
            for (NSDictionary *dic in data) {
                MyTeamModel * model = [MyTeamModel mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            if (self.dataArray.count > 0) {
                [self.tableView reloadData];

            }
            
            
        }
        
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (data.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }

    } fail:^(NSError *error) {
       [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTeamCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (self.dataArray.count > 0) {
        cell.model = self.dataArray[indexPath.row];

    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    headView.backgroundColor = [UIColor clearColor];
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(14, 0, 200, 40)];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共有%ld人",self.dataArray.count] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:58/255.0 green:205/255.0 blue:123/255.0 alpha:1.0]} range:NSMakeRange(2, string.length - 3)];
    lable.attributedText = string;
    [headView addSubview:lable];
    return headView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


@end

