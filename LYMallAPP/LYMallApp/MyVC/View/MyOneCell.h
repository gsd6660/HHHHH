//
//  MyOneCell.h
//  LYMallApp
//
//  Created by Mac on 2020/3/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *vipTypeLabel;
@property (weak, nonatomic) IBOutlet QMUIButton *butn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topH;
@property(nonatomic,strong)NSArray * dataArray;

@end

NS_ASSUME_NONNULL_END
