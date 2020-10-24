//
//  CommentOneCell.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYPhotoBrowser.h"
#import "TggStarEvaluationView.h"
#import "HCSStarRatingView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentOneCell : UITableViewCell
@property(nonatomic,strong)TggStarEvaluationView * starView;
@property(nonatomic,strong)QMUITextView * textView;
@property(nonatomic,strong)PYPhotosView * photosView;
@property(nonatomic,strong)UILabel * starLabel;

@property(nonatomic,strong)NSIndexPath * indexPath;

@property(nonatomic,copy)void(^selectStarClick)(NSInteger count,NSIndexPath*indexPath);

@end

NS_ASSUME_NONNULL_END
