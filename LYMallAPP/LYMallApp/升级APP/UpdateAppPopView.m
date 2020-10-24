
//
//  UpdateAppPopView.m
//  CDZAPP
//
//  Created by Mac on 2019/3/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "UpdateAppPopView.h"

@implementation UpdateAppPopView


- (void)drawRect:(CGRect)rect {
//    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.bgView.layer.mask  = maskLayer;
    
    
}

- (IBAction)updateButn:(UIButton *)sender {
    if (self.updateBlock) {
        self.updateBlock();
    }
}



- (IBAction)colseButn:(UIButton *)sender {
    if (self.colseBlock) {
        self.colseBlock();
    }
}

@end
