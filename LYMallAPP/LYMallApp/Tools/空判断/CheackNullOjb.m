
//
//  CheackNullOjb.m
//  GuaFenBaoAPP
//
//  Created by Mac on 2018/11/30.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CheackNullOjb.h"

@implementation CheackNullOjb
+ (BOOL)cc_isNullOrNilWithObject:(id)object;
{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}


@end
