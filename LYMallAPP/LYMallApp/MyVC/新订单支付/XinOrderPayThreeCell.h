//
//  XinOrderPayThreeCell.h
//  LYMallApp
//
//  Created by Mac on 2020/5/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberCalculate.h"
NS_ASSUME_NONNULL_BEGIN

@interface XinOrderPayThreeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLbale;
@property (weak, nonatomic) IBOutlet NumberCalculate *numLabel;
@end

NS_ASSUME_NONNULL_END
