//
//  SendModel.h
//  TSYCAPP
//
//  Created by Mac on 2019/9/7.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SendModel : NSObject
@property (nonatomic , copy) NSString  * update_time;
@property (nonatomic , copy) NSString  * content;
@property (nonatomic , assign) NSInteger  id;
@property (nonatomic , assign) NSInteger  record_id;
@property (nonatomic , assign) NSInteger from_side;
@property (nonatomic , assign) NSInteger  member_id;
@property (nonatomic , copy) NSString  * create_time;
@property (nonatomic , assign) NSInteger   type;
@property (nonatomic , assign) NSInteger  is_read;
@property (nonatomic , assign)BOOL is_showTime;

@end

NS_ASSUME_NONNULL_END
