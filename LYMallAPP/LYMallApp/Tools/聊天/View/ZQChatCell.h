//
//  ZQChatCell.h
//  TSYCAPP
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZQChatCell : UITableViewCell
@property (nonatomic, strong) SendModel *model;

@property (nonatomic, strong) SendModel *model1;
@property (nonatomic, strong) UIImageView *iconIV;      //头像

@end

NS_ASSUME_NONNULL_END
