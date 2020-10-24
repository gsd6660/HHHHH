//
//  CommissionManagerCell.h
//  LYMallApp
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CommissionModel;
@interface CommissionManagerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *mobilelable;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (weak, nonatomic) IBOutlet QMUIFillButton *detailButn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property(nonatomic,strong)CommissionModel *model;

@end

NS_ASSUME_NONNULL_END
