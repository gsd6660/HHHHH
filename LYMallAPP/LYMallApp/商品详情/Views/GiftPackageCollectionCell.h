//
//  GiftPackageCollectionCell.h
//  LYMallApp
//
//  Created by Mac on 2020/5/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiftPackageCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (strong, nonatomic)  NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
