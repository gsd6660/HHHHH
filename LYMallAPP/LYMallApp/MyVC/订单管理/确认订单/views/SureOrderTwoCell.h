//
//  SureOrderTwoCell.h
//  LYMallApp
//
//  Created by 科技 on 2020/3/31.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SureOrderTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet QMUIButton *descBtn;

@property (nonatomic,copy)void (^btnClick)(QMUIButton * btn);

@end

NS_ASSUME_NONNULL_END
