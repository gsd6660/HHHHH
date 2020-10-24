//
//  CommentTwoCell.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TggStarEvaluationView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentTwoCell : UITableViewCell
@property(nonatomic,strong)TggStarEvaluationView * starView;
@property(nonatomic,strong)UILabel * starLabel;
@property(nonatomic,strong)UILabel * tipLabel;

@property(nonatomic,strong)NSIndexPath * indexPath;

@property(nonatomic,copy)void (^selectStar)(NSInteger count,NSIndexPath * indexPath);

@end

NS_ASSUME_NONNULL_END
