//
//  BankCardLisModel.h
//  FuTaiAPP
//
//  Created by Mac on 2019/1/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardLisModel : NSObject
//"card_type":"招商银行",
//"account_name":"CC",
//"id_card":"6214833804973132",
//"id":10007,
//"phone":"15903615689",
//"is_delete":0,
//"is_default":true,
//"user_id":10013

@property(nonatomic,strong)NSString *bank_bg;
@property(nonatomic,strong)NSString *bank_logo;
@property(nonatomic,strong)NSString *card_type;
@property(nonatomic,strong)NSString *id_card;
@property(nonatomic,strong)NSString *bank_sn;
@property(nonatomic,strong)NSString *phone;

@property(nonatomic,strong)NSNumber *ID;

@property(nonatomic,strong)NSNumber *user_id;


@end
