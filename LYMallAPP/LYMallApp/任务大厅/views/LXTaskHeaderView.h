//
//  LXTaskHeaderView.h
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXTaskHeaderView : UIView
@property (weak, nonatomic) IBOutlet SDCycleScrollView *sdcyleScrollView;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;


@property(nonatomic, strong) NSArray * dataArray;


@end

NS_ASSUME_NONNULL_END
