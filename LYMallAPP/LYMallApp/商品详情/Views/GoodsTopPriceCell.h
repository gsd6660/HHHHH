//
//  GoodsTopPriceCell.h
//  LYMallApp
//
//  Created by 科技 on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsTopPriceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *beforePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property(nonatomic,strong)NSDictionary * dataDic;
@end

NS_ASSUME_NONNULL_END
