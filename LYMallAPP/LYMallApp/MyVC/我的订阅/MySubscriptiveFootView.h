//
//  MySubscriptiveFootView.h
//  LYMallApp
//
//  Created by Mac on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MySubscriptiveFootView : UITableViewHeaderFooterView
@property(nonatomic,strong)UIButton * leftBtn;
@property(nonatomic,strong)UIButton * rightBtn;
@property(nonatomic,strong)NSString * leftTitle;
@property(nonatomic,strong)NSString * rightTitle;
@property(nonatomic,strong)UIView *bgView;
@end

NS_ASSUME_NONNULL_END
