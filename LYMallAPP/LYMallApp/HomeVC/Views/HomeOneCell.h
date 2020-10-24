//
//  HomeOneCell.h
//  TableViewDemo
//
//  Created by C C on 2020/3/9.
//  Copyright © 2020 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeOneCell : UICollectionViewCell
@property(nonatomic)UIView * bannerView;
@property(nonatomic)UIView * buttonView;
@property(nonatomic)UIImageView * imageView;


@property (nonatomic, strong) NSDictionary *dataDic;//数据源

@end

NS_ASSUME_NONNULL_END
