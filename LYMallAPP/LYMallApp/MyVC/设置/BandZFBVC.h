//
//  bandZFBVC.h
//  GuaFenBaoAPP
//
//  Created by Mac on 2018/11/25.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
typedef void(^refreshDataBlock)(void);
@interface BandZFBVC : BaseViewController
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,copy)refreshDataBlock block;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *phone;
@end
