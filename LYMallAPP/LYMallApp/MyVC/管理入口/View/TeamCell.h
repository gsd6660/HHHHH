//
//  TeamCell.h
//  LYMallApp
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TeamModel;
@interface TeamCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moblieLable;
@property (weak, nonatomic) IBOutlet UIImageView *typeImagView;


@property (weak, nonatomic) IBOutlet UILabel *orderCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *xiaofeiLabel;

@property (weak, nonatomic) IBOutlet UILabel *yongjinLabel;

@property (weak, nonatomic) IBOutlet UILabel *noDaozhangLabel;

@property (strong, nonatomic) TeamModel *model;

@property (weak, nonatomic) IBOutlet UILabel *up_real_nameLabel;


@end

NS_ASSUME_NONNULL_END
