//
//  MyAddressListCell.h
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;
NS_ASSUME_NONNULL_BEGIN

@interface MyAddressListCell : UITableViewCell
@property(nonatomic,strong)AddressModel * model;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;

@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UIButton *radioButn;

@property (weak, nonatomic) IBOutlet UIButton *editButn;
@property (weak, nonatomic) IBOutlet UILabel *defultLabel;

@property(nonatomic,strong)NSDictionary * dataDic;

@end

NS_ASSUME_NONNULL_END
