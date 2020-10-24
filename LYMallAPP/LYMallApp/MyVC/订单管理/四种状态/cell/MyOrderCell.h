//
//  MyOrderCell.h
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^deleteBlock)(void);
@interface MyOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *snLable;
@property (weak, nonatomic) IBOutlet UILabel *statelabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titLable;
@property (weak, nonatomic) IBOutlet UILabel *guigeLable;

@property (weak, nonatomic) IBOutlet UILabel *countLable;

@property (weak, nonatomic) IBOutlet UIButton *leftButn;


@property (weak, nonatomic) IBOutlet UILabel *moneyLable;

@property(nonatomic,copy)deleteBlock block;
@property(nonatomic,strong)NSDictionary *dicData;

@end

NS_ASSUME_NONNULL_END
