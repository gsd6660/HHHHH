//
//  UpdateAppPopView.h
//  CDZAPP
//
//  Created by Mac on 2019/3/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^UpdateBlock)(void);
typedef void(^ColseBlock)(void);
@interface UpdateAppPopView : UIView
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property(nonatomic,copy)UpdateBlock updateBlock;
@property(nonatomic,copy)ColseBlock colseBlock;

@end

NS_ASSUME_NONNULL_END
