//
//  AgentManagerThreeCell.h
//  LYMallApp
//
//  Created by Mac on 2020/4/23.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgentManagerThreeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *total_moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet QMUIFillButton *withdrawButn;

@end

NS_ASSUME_NONNULL_END
