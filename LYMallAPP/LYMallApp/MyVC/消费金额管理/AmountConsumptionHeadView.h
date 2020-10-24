//
//  AmountConsumptionHeadView.h
//  LYMallApp
//
//  Created by Mac on 2020/5/29.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AmountConsumptionHeadView : UITableViewHeaderFooterView
@property(nonatomic,strong)UILabel * orderNumLable;
@property(nonatomic,strong)UILabel * stateLable;
@property(nonatomic,strong)UIView *grayView;
@property(nonatomic,strong)UIView *topView;
@end

NS_ASSUME_NONNULL_END
