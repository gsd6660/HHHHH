//
//  CollectionHeaderView.h
//  LYMallApp
//
//  Created by Mac on 2020/3/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


static NSString *const identifierCollectionHeader = @"CollectionHeaderView";
static CGFloat const heightCollectionHeader = 45.0;

@interface CollectionHeaderView : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END
