//
//  NewHomeVC.m
//  LYMallApp
//
//  Created by guxiang on 2020/10/17.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "NewHomeVC.h"
#import "LXHomeCollectionHeaderView.h"
#import "LXNewHomeOneCell.h"
#import "LXHomeCollectionHeaderView.h"
#import "NewHoemTwoCell.h"
@interface NewHomeVC ()

@end

@implementation NewHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.collectionView];
    
    self.collectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
        });
    }];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LXNewHomeOneCell *cell = (LXNewHomeOneCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        //    cell.dataDic = self.dataDic;
        return cell;
    }else{
        NewHoemTwoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewHoemTwoCell" forIndexPath:indexPath];
        return cell;
    }
    
}



// 添加一个补充视图(页眉或页脚)
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    LXHomeCollectionHeaderView * header;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXHomeCollectionHeaderView" forIndexPath:indexPath];
        return header;
    }else{
    
    }
    
    
    return nil;
}


//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
         return CGSizeMake(ScreenWidth, 200);
    }else{
        return CGSizeMake(ScreenWidth,390 );
    }
}


// 设定页眉的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
     
    return CGSizeMake(ScreenWidth, 250);
}



-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -StatusBarHeight, ScreenWidth, ScreenHeight+StatusBarHeight) collectionViewLayout:layout];
        
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[LXNewHomeOneCell class] forCellWithReuseIdentifier:@"cellId"];
 
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"LXHomeCollectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXHomeCollectionHeaderView"];
        [_collectionView registerNib:[UINib nibWithNibName:@"NewHoemTwoCell" bundle:nil] forCellWithReuseIdentifier:@"NewHoemTwoCell"];
        
  
    }
    return _collectionView;
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
