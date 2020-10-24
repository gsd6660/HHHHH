//
//  GoodsSelectCell.h
//  LYMallApp
//
//  Created by 科技 on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsSelectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;
@property(nonatomic,strong)NSDictionary * dataDic;
@end

NS_ASSUME_NONNULL_END
