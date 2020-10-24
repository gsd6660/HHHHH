//
//  GiftPackageCell.h
//  LYMallApp
//
//  Created by Mac on 2020/5/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiftPackageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
