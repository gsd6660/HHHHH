//
//  MyTeamCell.h
//  LYMallApp
//
//  Created by Mac on 2020/4/9.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTeamModel;
NS_ASSUME_NONNULL_BEGIN

@interface MyTeamCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *leveLabel;
@property (strong, nonatomic)  MyTeamModel *model;

@end

NS_ASSUME_NONNULL_END
