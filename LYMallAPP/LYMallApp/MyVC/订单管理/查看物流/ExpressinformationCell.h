//
//  ExpressinformationCell.h
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExpressinformationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *numLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property(nonatomic,strong)NSDictionary *dic;

- (void)setDetailModel:(NSDictionary*)dic;
@end

NS_ASSUME_NONNULL_END
