//
//  XinWithDrawRecordCell.h
//  LYMallApp
//
//  Created by Mac on 2020/6/1.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XinWithDrawRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *real_moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *tixianTypeLable;



@end

NS_ASSUME_NONNULL_END
