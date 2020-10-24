//
//  AddMyAddressListVC.h
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^refreshDataBlock)(void);

@interface AddMyAddressListVC : UIViewController
@property(nonatomic,copy)refreshDataBlock block;
@property(nonatomic,strong)NSString *is_edit;
@property(nonatomic,strong)NSString *address_id;

@end

NS_ASSUME_NONNULL_END
