//
//  MenuSelectViewCell.m
//  LYMallApp
//
//  Created by Mac on 2020/4/7.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MenuSelectViewCell.h"

@implementation MenuSelectViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        [self.contentView addSubview:self.titLabel];
        
    }
    return self;
}


@end
