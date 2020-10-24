//
//  OrderDetailBottomView.h
//  LYMallApp
//
//  Created by 科技 on 2020/3/31.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailBottomView : UIView

@property(nonatomic,strong)UIButton * leftBtn;
@property(nonatomic,strong)UIButton * rightBtn;
@property(nonatomic,strong)UIButton * centerBtn;
@property(nonatomic,strong)NSString * leftTitle;
@property(nonatomic,strong)NSString * rightTitle;
@property(nonatomic,strong)NSString * centerTitle;
@end

NS_ASSUME_NONNULL_END
