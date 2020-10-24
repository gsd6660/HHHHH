//
//  GoodsTwoCell.h
//  LYMallApp
//
//  Created by gds on 2020/3/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *commissionBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property(nonatomic,strong)NSDictionary * dataDic;
@end

NS_ASSUME_NONNULL_END
