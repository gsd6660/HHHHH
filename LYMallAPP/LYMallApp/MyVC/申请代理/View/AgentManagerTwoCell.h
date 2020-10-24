//
//  AgentManagerTwoCell.h
//  LYMallApp
//
//  Created by Mac on 2020/4/23.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgentManagerTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *last_monthOrderPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *last_monthCommissionLabel;
@property (weak, nonatomic) IBOutlet UILabel *current_monthOrderPriceLable;
@property (weak, nonatomic) IBOutlet UILabel *current_monthCommissionLabel;




@end

NS_ASSUME_NONNULL_END
