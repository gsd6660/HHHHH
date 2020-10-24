//
//  MyTwoCell.m
//  LYMallApp
//
//  Created by Mac on 2020/3/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MyTwoCell.h"
#import "MyCollectionCell.h"
#import "MyOrderOneVC.h"
#import "MyOrderTwoVC.h"
#import "MyOrderFourVC.h"
#import "WaitingEvaluationVC.h"
#import "MyOrderRefundVC.h"
#import "MyOrderThreeVC.h"
@interface MyTwoCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSArray * dataArray;

@end

@implementation MyTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.butn.imagePosition =  QMUIButtonImagePositionRight;
    self.butn.spacingBetweenImageAndTitle = 9.5;
        
        self.dataArray = @[
          @{@"icon":@"jft_but_pendingpayment",@"title":@"待付款"},
          @{@"icon":@"jft_but_tobeshipped",@"title":@"待发货"},
          @{@"icon":@"jft_but_goodstobereceived",@"title":@"待收货"},
          @{@"icon":@"jft_but_tobeevaluated",@"title":@"待评价"},
          @{@"icon":@"jft_but_aftercustomerservice",@"title":@"退款/售后"}
        ];
        [self.collectionView reloadData];
        
        
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"MyCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"typeCellId"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        
         self.bgView.layer.shadowColor = [UIColor colorWithRed:109/255.0 green:106/255.0 blue:106/255.0 alpha:0.11].CGColor;
          self.bgView.layer.shadowOffset = CGSizeMake(0,1);
          self.bgView.layer.shadowOpacity = 1;
          self.bgView.layer.shadowRadius = 5;
          self.bgView.layer.cornerRadius = 5;
        
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
    return 10.0;
}
 
// UICollectionViewCell最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionCell *cell = (MyCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"typeCellId" forIndexPath:indexPath];
    [cell setValuecationWithDataDic:self.dataArray[indexPath.row]];
    
    return cell;

    }


//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((ScreenWidth - 70) / 5, 80);

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            [self.viewController.navigationController pushViewController:[MyOrderOneVC new] animated:YES];
        }
            break;
        case 1:{
            [self.viewController.navigationController pushViewController:[MyOrderTwoVC new] animated:YES];
        }
            break;
        case 2:
            {
               [self.viewController.navigationController pushViewController:[MyOrderThreeVC new] animated:YES];
            }
            break;
        case 3:
            {
                 [self.viewController.navigationController pushViewController:[WaitingEvaluationVC new] animated:YES];
            }
            break;
        case 4:
            {
                 [self.viewController.navigationController pushViewController:[MyOrderRefundVC new] animated:YES];
            }
            break;
        default:
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
