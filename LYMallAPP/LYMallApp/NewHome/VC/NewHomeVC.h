//
//  NewHomeVC.h
//  LYMallApp
//
//  Created by guxiang on 2020/10/17.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewHomeVC : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end

NS_ASSUME_NONNULL_END
