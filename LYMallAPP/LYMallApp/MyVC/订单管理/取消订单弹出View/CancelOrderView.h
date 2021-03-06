//
//  CancelOrderView.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CancelOrderView : UIView

@property (nonatomic,copy)void (^selectClick)(NSIndexPath * indexPath);

-(instancetype)initWithFrame:(CGRect)frame withDataSource:(NSArray*)dataSource;



@end

NS_ASSUME_NONNULL_END
