//
//  MyAddressListVC.h
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
@class AddressModel;
NS_ASSUME_NONNULL_BEGIN

typedef void(^BlockAddress)(AddressModel *model);

@interface MyAddressListVC : BaseViewController
@property(nonatomic,copy)BlockAddress block;
@property(nonatomic,assign)NSNumber * address_id;
@end

NS_ASSUME_NONNULL_END
