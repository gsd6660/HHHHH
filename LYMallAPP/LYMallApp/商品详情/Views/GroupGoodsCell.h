//
//  GroupGoodsCell.h
//  LYMallApp
//
//  Created by 科技 on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lbl_CutDownView.h"
NS_ASSUME_NONNULL_BEGIN

@interface GroupGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet lbl_CutDownView *timerView;
@property (nonatomic,strong)NSDictionary * dataDic;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

NS_ASSUME_NONNULL_END
