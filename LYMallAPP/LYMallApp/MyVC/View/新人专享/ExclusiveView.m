//
//  ExclusiveView.m
//  LYMallApp
//
//  Created by Mac on 2020/5/6.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ExclusiveView.h"

@implementation ExclusiveView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}


-(void)creatUI{
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 258)];
    self.imgView.image = CCImage(@"jft_img_couponspopup");
    self.imgView.userInteractionEnabled = YES;
    [self addSubview:self.imgView];
    
    
    self.closeButn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButn.frame = CGRectMake(ScreenWidth / 2  - 15, self.imgView.bottom + 50, 30, 30);
    [self.closeButn setImage:CCImage(@"jft_but_close") forState:UIControlStateNormal];
    [self addSubview:self.closeButn];
    
}

@end
