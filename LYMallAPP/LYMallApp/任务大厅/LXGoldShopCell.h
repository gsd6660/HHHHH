//
//  LXGoldShopCell.h
//  LYMallApp
//
//  Created by guxiang on 2020/11/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXGoldShopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *goldLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;


@property (nonatomic, copy) void (^buyClick)();

@property(nonatomic, strong) NSDictionary * dic;

@end

NS_ASSUME_NONNULL_END
