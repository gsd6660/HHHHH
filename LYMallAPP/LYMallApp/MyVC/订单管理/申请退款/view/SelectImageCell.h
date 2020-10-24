//
//  SelectImageCell.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYPhotosView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SelectImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PYPhotosView *publishPhotosView;

@end

NS_ASSUME_NONNULL_END
