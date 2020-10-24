

//
//  LXRuleTableViewCell.h
//  LYMallApp
//
//  Created by gds on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXRuleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

NS_ASSUME_NONNULL_END
