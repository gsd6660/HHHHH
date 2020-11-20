//
//  NibView.m
//  LEEAlertDemo
//
//  Created by 李响 on 2018/9/20.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "NibView.h"

@implementation NibView

+ (instancetype)instance {
    return [[[NSBundle mainBundle] loadNibNamed:@"NibView"
                                          owner:nil options:nil]lastObject];
}
- (IBAction)noUseButn:(UIButton *)sender {
    [QMUITips showInfo:@"需要获得你的同意后才可继续使用和乐宝PP" inView:[[UIApplication sharedApplication]keyWindow] hideAfterDelay:2];
}

- (IBAction)agreeButn:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
    
}


@end
