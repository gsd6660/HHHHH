//
//  SelectCouponsView.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/10.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectCouponsView : UIView

@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,copy)void (^hideView)(NSDictionary * dic);
@property(nonatomic,strong)NSIndexPath * selectIndexPath;
@end

NS_ASSUME_NONNULL_END
