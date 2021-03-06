//
//  AddBankCardCell.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/2.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddBankCardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *descTF;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;

@end

NS_ASSUME_NONNULL_END
