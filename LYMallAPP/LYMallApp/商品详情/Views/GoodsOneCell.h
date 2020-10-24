//
//  GoodsOneCell.h
//  LYMallApp
//
//  Created by gds on 2020/3/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsOneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property(nonatomic,strong)NSDictionary * dataDic;
@end

NS_ASSUME_NONNULL_END
