//
//  MyOneCell.m
//  LYMallApp
//
//  Created by Mac on 2020/3/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MyOneCell.h"
#import "MyCouponCell.h"
#import "CouponVC.h"
#import "CouponModel.h"
@interface MyOneCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSMutableArray *array;
@end

@implementation MyOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.butn.imagePosition =  QMUIButtonImagePositionRight;
    self.butn.spacingBetweenImageAndTitle = 9.5;
       
    
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"MyCouponCell" bundle:nil] forCellWithReuseIdentifier:@"MyCouponCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
           
    
    
}


-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
//    for (CouponModel *model in dataArray) {
//        self.dataArray
////    }
//    if (dataArray.count == 0) {
        self.collectionH.constant = 0;
        self.topH.constant = 0;
//    }else{
//       self.collectionH.constant = 65;
//        self.topH.constant = 10;
//    }
    [self.collectionView reloadData];
}

///////////////////////////////////////////

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;

}

//设置每个item的UIEdgeInsets

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   
     return UIEdgeInsetsMake(0, 0, 0, 0);
}


// UICollectionViewCell最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 7.5;
}
 
// UICollectionViewCell最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCouponCell *cell = (MyCouponCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCouponCell" forIndexPath:indexPath];
    CouponModel * model = self.dataArray[indexPath.row];
    cell.model = model;
//    [cell setValuecationWithDataDic:self.array[indexPath.row]];
    
    return cell;

    }


//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(110, 65);

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController * mainVC = [self viewController];

    CouponVC * vc = [[CouponVC alloc]init];
    [mainVC.navigationController pushViewController:vc animated:YES];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSMutableArray *)array{
    if (_array == nil) {
        _array = [[NSMutableArray alloc]init];
        
    }
    return _array;
}

@end
