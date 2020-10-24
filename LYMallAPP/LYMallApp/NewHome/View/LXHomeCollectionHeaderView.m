//
//  LXHomeCollectionHeaderView.m
//  LYMallApp
//
//  Created by guxiang on 2020/10/17.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXHomeCollectionHeaderView.h"

@interface LXHomeCollectionHeaderView()<SDCycleScrollViewDelegate>

@end

@implementation LXHomeCollectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cycleScrollView.delegate = self;
}



@end
