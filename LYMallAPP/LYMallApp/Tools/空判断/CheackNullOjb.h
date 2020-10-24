//
//  CheackNullOjb.h
//  GuaFenBaoAPP
//
//  Created by Mac on 2018/11/30.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheackNullOjb : NSObject
/**
 *  判断对象是否为空
 *  PS：nil、NSNil、@""、@0 以上4种返回YES
 *
 *  @return YES 为空  NO 为实例对象
 */
+ (BOOL)cc_isNullOrNilWithObject:(id)object;
@end
