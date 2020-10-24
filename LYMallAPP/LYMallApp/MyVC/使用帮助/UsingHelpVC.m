//
//  UsingHelpVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "UsingHelpVC.h"
#import "HelpModel.h"
#import "HeadView.h"
#import "AnswerCell.h"
@interface UsingHelpVC ()<UITableViewDelegate,UITableViewDataSource,HeadViewDelegate>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *answersArray;
@property (nonatomic, assign) CGSize textSize;
@end

@implementation UsingHelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"使用帮助";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.sectionHeaderHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self getData];
        
}

#pragma mark 加载数据
-(void)getData{
        [NetWorkConnection postURL:@"api/user/help" param:nil success:^(id responseObject, BOOL success) {
            if (responseSuccess) {
                NSLog(@"使用帮助===%@",responseJSONString);
                if (responseSuccess) {
                    NSArray * list = responseObject[@"data"][@"list"];
                    for (NSDictionary *dic in list) {
                        HelpModel * model = [HelpModel mj_objectWithKeyValues:dic];
                        [self.dataArray addObject:model];
                    }
                }
                [self.tableView reloadData];

            }
        } fail:^(NSError *error) {
            
        }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HelpModel *model = self.dataArray[section];
    NSInteger count = model.isOpened ? 1 : 0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    
    AnswerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AnswerCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HelpModel *answerModel = self.dataArray[indexPath.section];
    cell.textViewLabel.text = answerModel.content;
    
    self.textSize = [self getLabelSizeFortextFont:[UIFont systemFontOfSize:15] textLabel:answerModel.content];
//    NSLog(@"====%f",self.textSize.height);

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.textSize.height+40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    headView.delegate = self;
    headView.model = self.dataArray[section];
    return headView;
}

- (void)clickHeadView
{
    [self.tableView reloadData];
}


- (CGSize)getLabelSizeFortextFont:(UIFont *)font textLabel:(NSString *)text{
    NSDictionary * totalMoneydic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize totalMoneySize =[text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-16,1000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:totalMoneydic context:nil].size;
    return totalMoneySize;
}



-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (NSMutableArray *)answersArray{
    if (_answersArray == nil) {
        self.answersArray = [NSMutableArray array];
    }
    return _answersArray;
}
@end
