//
//  MySubscripCell.h
//  LYMallApp
//
//  Created by Mac on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MySubscripCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cycle_numLable;
@property (weak, nonatomic) IBOutlet UILabel *namelable;
@property (weak, nonatomic) IBOutlet UILabel *skuLable;
@property (weak, nonatomic) IBOutlet UILabel *period_timeLable;

@property (weak, nonatomic) IBOutlet UILabel *statusLable;

-(void)getDataDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
