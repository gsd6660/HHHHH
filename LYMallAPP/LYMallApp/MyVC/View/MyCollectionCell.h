//
//  MyCollectionCell.h
//  LYMallApp
//
//  Created by Mac on 2020/3/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *titLabel;
-(void)setValuecationWithDataDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
