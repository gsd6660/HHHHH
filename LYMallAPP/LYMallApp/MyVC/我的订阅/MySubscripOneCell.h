//
//  MySubscripOneCell.h
//  LYMallApp
//
//  Created by Mac on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MySubscripOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *countNumLable;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet QMUIGhostButton *afterSaleButn;
@property (weak, nonatomic) IBOutlet QMUIGhostButton *pingjiaButn;
-(void)getDataDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
