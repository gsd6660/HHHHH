//
//  LXCollegeTwoCell.h
//  LYMallApp
//
//  Created by gds on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXCollegeTwoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet QMUIButton *moreBtn;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;


@property(nonatomic, strong) NSArray *dataArray;


@end

NS_ASSUME_NONNULL_END
