//
//  SelectPayTypeVC.h
//  LYMallApp
//
//  Created by Mac on 2020/5/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SelectPayTypeDelegate <NSObject>

-(void)getPayType:(NSString *)payType payName:(NSString *)name;

@end

@interface SelectPayTypeVC : BaseViewController
@property(nonatomic,strong)NSArray * payDataArray;
@property(nonatomic,weak)id <SelectPayTypeDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
