//
//  UIColor+YZExtension.h
//  LYMallApp
//
//  Created by gds on 2020/3/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (YZExtension)

+(UIColor *)colorWithHexString:(NSString *)hexColor alpha:(float)opacity;
+(UIColor*)colorWithRGB:(NSUInteger)hex
                  alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
