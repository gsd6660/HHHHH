//
//  GiftPackageCell.m
//  LYMallApp
//
//  Created by Mac on 2020/5/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GiftPackageCell.h"
#import "GiftPackageCollectionCell.h"

@interface GiftPackageCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray * listArray;
@end
static NSString *cellID = @"GiftPackageCollectionCell";

@implementation GiftPackageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
    
}


-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.listArray removeAllObjects];
    for (NSDictionary *dic in dataArray) {
        [self.listArray addObject:dic];
    }
    [self.collectionView reloadData];
}

//设置每个item的UIEdgeInsets

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
        return 1;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
        return self.listArray.count;
}



//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        return CGSizeMake(((ScreenWidth - 41) / 3), 200);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
     GiftPackageCollectionCell *cell = (GiftPackageCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (self.listArray.count > 0) {
        cell.dataDic = self.listArray[indexPath.row];
    }
    return cell;
}









- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(NSMutableArray *)listArray{
    if (_listArray == nil) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}

@end
