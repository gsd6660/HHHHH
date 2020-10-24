//
//  LXNewHomeOneCell.m
//  LYMallApp
//
//  Created by guxiang on 2020/10/17.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXNewHomeOneCell.h"
#import "HomeTypeCell.h"

@interface LXNewHomeOneCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSArray * dataArray;
@property (nonatomic, strong) XRCarouselView *carouselView;
@property (nonatomic, strong)NSMutableArray * bannerArr;
@property (nonatomic, strong) NSMutableArray *categoryArry;//分类

@end

@implementation LXNewHomeOneCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.collectionView];
        
//        self.backgroundColor = UIColor.c;
        YBDViewBorderRadius(self.collectionView, 10);
        self.dataArray = @[
          @{@"icon":@"all",@"title":@"全部"},
          @{@"icon":@"xiaomi",@"title":@"小米"},
          @{@"icon":@"mianfen",@"title":@"面粉"},
          @{@"icon":@"miantiao",@"title":@"果蔬苗条"},
          @{@"icon":@"fengmi",@"title":@"蜂蜜"},
          @{@"icon":@"putaojiu",@"title":@"葡萄酒"},
          @{@"icon":@"xiaomi",@"title":@"黄梨"},
          @{@"icon":@"chubu",@"title":@"粗布"}
        ];
        [self.collectionView reloadData];
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;

}

//设置每个item的UIEdgeInsets

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   
     return UIEdgeInsetsMake(0, 10, 10, 10);
}


// UICollectionViewCell最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}
 
// UICollectionViewCell最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeTypeCell *cell = (HomeTypeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"typeCellId" forIndexPath:indexPath];
    if (self.dataArray.count > 0) {
//        [cell setValuecationWithDataDic:self.dataArray[indexPath.row]];
        NSDictionary * dic = self.dataArray[indexPath.row];
        cell.goodsImageView.image = [UIImage imageNamed:dic[@"icon"]];
        cell.goodsNameLabel.text = dic[@"title"];
    }
    
    return cell;
}


//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((ScreenWidth - 70) / 4, 80);

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSDictionary *dic = self.categoryArry[indexPath.row];
//    MallVC * vc = [[MallVC alloc]init];
//    vc.title = @"商城";
//    vc.category_id = [NSString stringWithFormat:@"%@",dic[@"category_id"]];
//    [[self viewController].navigationController pushViewController:vc animated:YES];
}





-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(180);
        }];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeTypeCell" bundle:nil] forCellWithReuseIdentifier:@"typeCellId"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}


@end
