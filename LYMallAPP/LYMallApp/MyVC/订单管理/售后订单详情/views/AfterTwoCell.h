//
//  AfterTwoCell.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYPhotosView.h"
NS_ASSUME_NONNULL_BEGIN

@interface AfterTwoCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *itemlabel;

@property (weak, nonatomic) IBOutlet UILabel *causeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet PYPhotosView *photoView;

@end

NS_ASSUME_NONNULL_END
