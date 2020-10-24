//
//  EquityManagementCell.h
//  LYMallApp
//
//  Created by Mac on 2020/5/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EquityManagementCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *biandongLable;
@property (weak, nonatomic) IBOutlet UILabel *desLable;
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet UILabel *typeLable;
@property(nonatomic,strong)NSDictionary *dataDic;
@end

NS_ASSUME_NONNULL_END
