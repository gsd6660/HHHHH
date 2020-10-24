//
//  RefundCell.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RefundCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *descTF;

@end

NS_ASSUME_NONNULL_END
