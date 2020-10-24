//
//  HomeSectionThreeVC.m
//  LYMallApp
//
//  Created by 科技 on 2020/5/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "HomeSectionThreeVC.h"
#import "HomeFourCell.h"
#import "GoodsDetailsVC.h"
#import "MallModel.h"
@interface HomeSectionThreeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)NSInteger page;


@end

@implementation HomeSectionThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    MJWeakSelf;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadData];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf loadData];
    }];
    [self.collectionView.mj_header beginRefreshing];
}


- (void)loadData{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/goods/lists" param:@{@"filter_type":self.filter_type,@"page":@(self.page)} success:^(id responseObject, BOOL success) {
        NSLog(@"商品列表======%@",responseJSONString);
        if (responseSuccess) {
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
                
            }
            NSArray * array = responseObject[@"data"][@"list"][@"data"];
            
            for (NSDictionary *dic in array) {
                MallModel * model = [MallModel mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            
            if (self.dataArray.count == 0) {
                [self showEmptyViewWithImage:CCImage(@"wushuju") text:@"暂无数据" detailText:@"" buttonTitle:@"点击重试" buttonAction:@selector(loadData)];
            }else{
                [self hideEmptyView];
            }
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            if (array.count == 0) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else{
            ShowErrorHUD(responseMessage);
        }
        [self.collectionView reloadData];
    } fail:^(NSError *error) {
        [self hideEmptyView];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}


//设置每个item的UIEdgeInsets

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (ScreenWidth == 320) {
        return CGSizeMake(((ScreenWidth - 21) / 2), 264);
    }else if (ScreenWidth == 375) {
        return CGSizeMake(((ScreenWidth - 21) / 2), 290);
    }
    return CGSizeMake(((ScreenWidth - 21) / 2), 310);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeFourCell *cell = (HomeFourCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellFourId" forIndexPath:indexPath];
    MallModel * model = self.dataArray[indexPath.row];
    cell.mallModel = model;
    
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataArray.count == 0) {
        self.collectionView.mj_footer.hidden = YES;
    }else{
        self.collectionView.mj_footer.hidden = NO;
    }
    return self.dataArray.count;
}


// UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        MallModel * model = self.dataArray[indexPath.row];
        GoodsDetailsVC * vc = [GoodsDetailsVC new];
        vc.goods_id = [NSString stringWithFormat:@"%@",model.goods_id];
        vc.typeStr = [model.gift_goods_type stringValue];
        [self.navigationController pushViewController:vc animated:YES];
    
    
}


-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[HomeFourCell class] forCellWithReuseIdentifier:@"cellFourId"];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
