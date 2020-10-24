//
//  HelpModel.h
//  LYMallApp
//
//  Created by Mac on 2020/4/17.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign, getter = isOpened) BOOL opened;

@end

NS_ASSUME_NONNULL_END
