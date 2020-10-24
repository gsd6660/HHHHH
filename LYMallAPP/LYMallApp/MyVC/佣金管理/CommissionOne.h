//
//  CommissionOne.h
//  LYMallApp
//
//  Created by 科技 on 2020/4/1.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^getHeadDataBlock)(NSDictionary *dic);
@interface CommissionOne : BaseViewController<ZJScrollPageViewChildVcDelegate>
@property(nonatomic,copy)getHeadDataBlock block;

@end

NS_ASSUME_NONNULL_END
