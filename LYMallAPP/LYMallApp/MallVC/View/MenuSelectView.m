
//
//  MenuSelectView.m
//  LYMallApp
//
//  Created by Mac on 2020/4/7.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MenuSelectView.h"
#import "MenuSelectViewCell.h"
@interface MenuSelectView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation MenuSelectView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    [self addSubview:self.tableView];

    
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            // 执行动画
            self.alpha -= 0.1;
        
        } completion:^(BOOL finished) {
            // 动画完成做什么事情
           [UIView animateWithDuration:0.5 animations:^{
               self.alpha += 0.5;

           }];
        }];

    [self showMenuView];
    
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.isShow = 0;
        }];
    }];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    [self getTypeData];
    
}

-(void)getTypeData{
    [NetWorkConnection postURL:@"api/category/index" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"商品分类====%@",responseJSONString);
        if (responseSuccess) {
            NSArray * list = responseObject[@"data"][@"list"];
            for (NSDictionary *dic in list) {
                [self.dataArray addObject:dic];
            }
            
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    }];
}

-(void)showMenuView{
    [UIView animateWithDuration:1.1 //动画持续时间
                          delay:1 //动画延迟执行的时间
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
        self.tableView.frame = CGRectMake(0, 0, 100, ScreenHeight);
    }                completion:^(BOOL finished) {
                      //动画执行完毕后的操作
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.text = self.dataArray[indexPath.row][@"name"];
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.alpha = 0;
    self.isShow = 0;
    NSString * category_id = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"category_id"]];
    if (self.block) {
        self.block(category_id);
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//如果是子视图 self.edittingArea ，设置无法接受 父视图_collectionView 的长按事件。
    if ([touch.view isDescendantOfView:self.tableView]) {
      return NO;
     }
      return YES;
}


-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorColor = kUIColorFromRGB(0xf1f4f8);
    }
    return _tableView;
}


-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


@end
