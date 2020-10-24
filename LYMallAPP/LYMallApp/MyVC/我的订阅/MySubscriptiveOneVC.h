//
//  MySubscriptiveOneVC.h
//  LYMallApp
//
//  Created by Mac on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^getHeadDataBlock)(NSDictionary *dic,UITableView *tableView);

@interface MySubscriptiveOneVC : BaseViewController<ZJScrollPageViewChildVcDelegate>
@property(nonatomic,strong)NSString *dataType;
@property(nonatomic,copy)getHeadDataBlock block;
@end

NS_ASSUME_NONNULL_END
