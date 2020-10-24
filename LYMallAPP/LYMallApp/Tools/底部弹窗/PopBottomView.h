//
//  PopBottomView.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopBottomView : UIView

@property(nonatomic,copy)void (^selectIndexClick)(NSIndexPath* indexPath);

- (instancetype)initWithFrame:(CGRect)frame withDataSource:(NSArray*)dataSource;

@end

NS_ASSUME_NONNULL_END
