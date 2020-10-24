//
//  MySubscriptiveHeadView.h
//  LYMallApp
//
//  Created by Mac on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MySubscriptiveHeadView : UIView
@property(nonatomic,strong)UILabel * nameLable;
@property(nonatomic,strong)UILabel * crea_timeLable;
@property(nonatomic,strong)UILabel * end_timeLable;
@property(nonatomic,strong)UILabel * cycle_numLable;
@property(nonatomic,strong)NSString * goods_id;

-(void)getDataDic:(NSDictionary *)dic;


@end

NS_ASSUME_NONNULL_END
