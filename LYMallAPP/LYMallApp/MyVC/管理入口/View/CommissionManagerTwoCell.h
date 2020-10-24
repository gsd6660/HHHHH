//
//  CommissionManagerTwoCell.h
//  LYMallApp
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CommissionModel;
@interface CommissionManagerTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tixianTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *daozhangLabel;
@property (weak, nonatomic) IBOutlet UILabel *qudaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *realMoneyLable;


@property (nonatomic,strong)CommissionModel *model;
@end

NS_ASSUME_NONNULL_END
