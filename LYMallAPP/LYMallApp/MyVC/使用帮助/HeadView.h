//
//  HeadView.h
//  KCB
//
//  Created by haozp on 16/1/6.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HelpModel;

@protocol HeadViewDelegate <NSObject>

@optional
- (void)clickHeadView;

@end

@interface HeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) HelpModel *model;


@property (nonatomic, weak) id<HeadViewDelegate> delegate;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;

@end
