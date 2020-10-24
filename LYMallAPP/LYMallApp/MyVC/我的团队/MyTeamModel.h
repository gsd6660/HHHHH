//
//  MyTeamModel.h
//  LYMallApp
//
//  Created by Mac on 2020/4/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTeamModel : NSObject
@property (nonatomic , assign) NSInteger              wxapp_id;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * levelname;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              dealer_id;
@property (nonatomic , assign) NSInteger              level;
@property (nonatomic , copy) NSString              * avatarUrl;
@property (nonatomic , copy) NSString              * commission;
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * nickName;
@end

NS_ASSUME_NONNULL_END
