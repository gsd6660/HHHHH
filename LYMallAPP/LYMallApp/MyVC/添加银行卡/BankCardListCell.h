//
//  BankCardListCell.h
//  FuTaiAPP
//
//  Created by Mac on 2019/1/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BankCardLisModel;
@interface BankCardListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bankNamelbale;
@property (weak, nonatomic) IBOutlet UILabel *desLable;
@property (weak, nonatomic) IBOutlet UILabel *cardNumlable;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;



@property(nonatomic,strong)BankCardLisModel * model;
@end
