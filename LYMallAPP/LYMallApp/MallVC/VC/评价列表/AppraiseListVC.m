
//
//  AppraiseListVC.m
//  LYMallApp
//
//  Created by Mac on 2020/3/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AppraiseListVC.h"
#import "AppraiseListCell.h"

@interface AppraiseListVC ()
{
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong)NSMutableDictionary * parmDic;
@property (nonatomic,strong)NSMutableArray * commentArray;


@end

@implementation AppraiseListVC

static NSString * cellID = @"AppraiseListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价列表";
    self.tableView.estimatedRowHeight = 180;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.estimatedSectionFooterHeight = 10;
    [self setUI];
    [self.parmDic setValue:self.goods_id forKey:@"goods_id"];
    [self.parmDic setValue:self.goods_type forKey:@"goods_type"];

    [self.parmDic setValue:@0 forKey:@"type"];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self getCommentData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self getCommentData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

//获取评价列表数据
-(void)getCommentData{
    [self showEmptyViewWithLoading];
    [self.parmDic setValue:@(page) forKey:@"page"];
    
    [NetWorkConnection postURL:@"api/comment/getlists" param:self.parmDic success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        NSLog(@"评价列表数据===%@",responseJSONString);
        if (responseSuccess) {
            if (self.commentArray.count>0 && page == 1) {
                [self.commentArray removeAllObjects];
            }
            NSDictionary * dic = responseObject[@"data"][@"list"];
            NSArray * data = dic[@"data"];
            for (NSDictionary *dic in data) {
                [self.commentArray addObject:dic];
            }
        }else{
            ShowErrorHUD(responseMessage);
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } fail:^(NSError *error) {
        [self hideEmptyView];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


-(void)setUI{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headView.backgroundColor = [UIColor whiteColor];
    self.headView = headView;
    NSArray *arr = @[@"全部",@"有图",@"最新"];
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 10;//用来控制button距离父视图的高
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        button.backgroundColor = kUIColorFromRGB(0xF5F5F5);
        button.layer.cornerRadius = 3;
        button.titleLabel.font = FONTSIZE(14);
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        if (i == 0) {
            [button setBackgroundColor:kUIColorFromRGB(0xF3FDF7)];//选中button的颜色
            button.layer.borderWidth = 1;
            button.layer.borderColor = kUIColorFromRGB(0x3ACD7B).CGColor;
        }
        //依据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGFloat length = [arr[i] boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:arr[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 35 , 30);
        //当button的位置超出屏幕边缘时换行 320 仅仅是button所在父视图的宽度
        //            if(10 + w + length + 15 > 320){
        //                w = 0; //换行时将w置为0
        //                h = h + button.frame.size.height + 10;//距离父视图也变化
        //                button.frame = CGRectMake(10 + w, h, length + 15, 30);//重设button的frame
        //            }
        w = button.frame.size.width + button.frame.origin.x;
        [headView addSubview:button];
    }
    self.tableView.tableHeaderView = headView;
}

//点击事件
  - (void)handleClick:(UIButton *)sender{
      NSLog(@"%ld",sender.tag);
      page = 1;
      if (sender.tag == 101) {
          [self.parmDic setValue:@1 forKey:@"type"];
      }else if(sender.tag == 102){
          [self.parmDic setValue:@2 forKey:@"type"];
      }else if(sender.tag == 100){
          [self.parmDic setValue:@0 forKey:@"type"];
      }
      [self getCommentData];
      NSArray *array = [self.headView subviews];//获取button父视图上的所有子控件
      for(int i=0;i<array.count;i++) //遍历数组 找出所有的button
      {
          id view = array[i];
          if([view isKindOfClass:[UIButton class]])
          {
              UIButton *btn = (UIButton*)view;
              [btn setBackgroundColor:kUIColorFromRGB(0xF5F5F5)];//未选中button的颜色
              btn.layer.borderWidth = 1;
                   btn.layer.borderColor = kUIColorFromRGB(0xF5F5F5).CGColor;
              btn.selected = NO;
          }
      }
      sender.selected =YES;
      [sender setBackgroundColor:kUIColorFromRGB(0xF3FDF7)];//选中button的颜色
      sender.layer.borderWidth = 1;
      sender.layer.borderColor = kUIColorFromRGB(0x3ACD7B).CGColor;
      
      
  }

//显示多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.commentArray.count;//设置多少组数据
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bg.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    return bg;
}
//列表中每一个view对象，设置每一个view的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppraiseListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (self.commentArray.count > 0) {
        NSDictionary * dic = self.commentArray[indexPath.section];
        [self getDic:dic cell:cell];
    }
    return cell;
}

-(void)getDic:(NSDictionary *)dic cell:(AppraiseListCell *)cell{
    
    if ([CheackNullOjb cc_isNullOrNilWithObject:dic[@"user"]] == NO) {
        cell.userNameLbale.text = dic[@"user"][@"nickName"];
        [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"user"][@"avatarUrl"]] placeholderImage:CCImage(@"jft_icon_headportrait")];

    }
     cell.goodsNameLabel.text = dic[@"order_goods"][@"goods_name"];
     cell.timeLabel.text = dic[@"create_time"];
     cell.contentLabel.text = dic[@"content"];
     cell.orderLalbel.text = [NSString stringWithFormat:@"来自订单编号：%@",dic[@"order"][@"order_no"]];
     cell.starView.starCount = [dic[@"score"] integerValue];
     NSArray * images = dic[@"image"];
     if (images.count>0) {
         cell.collectionViewHeight.constant = 113;

     }else{
         cell.collectionViewHeight.constant = 0;
     }
     cell.imagesArray = dic[@"image"];
}


//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger cellnum=indexPath.row;
    NSLog(@"我点击了第%ld行",cellnum);
    
    
    
    
}


- (NSMutableDictionary *)parmDic{
    if (!_parmDic) {
        _parmDic = [NSMutableDictionary dictionary];
    }
    return _parmDic;
}

- (NSMutableArray *)commentArray{
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

@end
