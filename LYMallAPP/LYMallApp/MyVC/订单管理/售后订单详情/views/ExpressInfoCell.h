//
//  ExpressInfoCell.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/28.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExpressInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *expressCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *expressNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

NS_ASSUME_NONNULL_END
