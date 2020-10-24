//
//  GoodsThereCell.h
//  LYMallApp
//
//  Created by gds on 2020/3/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsThreeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;

@property (nonatomic,strong)NSDictionary * dataDic;

@end

NS_ASSUME_NONNULL_END
