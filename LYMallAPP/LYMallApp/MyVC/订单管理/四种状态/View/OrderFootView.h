//
//  OrderFootView.h
//  LYMallApp
//
//  Created by Mac on 2020/3/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderFootView : UITableViewHeaderFooterView
@property(nonatomic,strong)UIButton * leftButn;
@property(nonatomic,strong)UIButton * rightButn;
@property(nonatomic,strong)UIButton * centerButn;
@property(nonatomic,strong)UILabel * priceLable;
@property(nonatomic,strong)NSString * leftTitle;
@property(nonatomic,strong)NSString * rightTitle;
@property(nonatomic,strong)NSString * centerTitle;
@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,copy)void (^rightBtnClick)(UIButton * btn);
@property(nonatomic,copy)void (^centerBtnClick)(UIButton * btn);
@property(nonatomic,copy)void (^leftBtnClick)(UIButton * btn);
@end

NS_ASSUME_NONNULL_END
