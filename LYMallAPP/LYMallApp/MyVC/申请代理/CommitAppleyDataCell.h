//
//  CommitAppleyDataCell.h
//  LYMallApp
//
//  Created by Mac on 2020/4/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommitAppleyDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet QMUITextField *nameTF;
@property (weak, nonatomic) IBOutlet QMUITextField *mobileTF;
@property (weak, nonatomic) IBOutlet QMUITextField *addressTF;
@property (weak, nonatomic) IBOutlet UIButton *levelButn;
@property (weak, nonatomic) IBOutlet UIButton *areaButn;

@end

NS_ASSUME_NONNULL_END
