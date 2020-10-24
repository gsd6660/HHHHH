//
//  HeadView.m
//  KCB
//
//  Created by haozp on 16/1/6.
//  Copyright © 2016年 haozp. All rights reserved.
//
#define SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)

#import "HeadView.h"
#import "HelpModel.h"

@interface HeadView()
{
    UIButton *_bgButton;
    UILabel *_numLabel;
    UIView *_bgView;
}
@end

@implementation HeadView

+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *headIdentifier = @"header";
    
    HeadView *headView;
    if (headView == nil) {
        headView = [[HeadView alloc] initWithReuseIdentifier:headIdentifier];
        headView.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
//        _bgView =  [[UIView alloc] initWithFrame:self.bounds];
//        _bgView.ba
        [self.backgroundView addSubview:_bgView];
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.frame = CGRectMake(0, 0, ScreenWidth, 60);
        [bgButton setImage:[UIImage imageNamed:@"jft_icon_rightarrow"] forState:UIControlStateNormal];
        [bgButton setTitleColor:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1] forState:UIControlStateNormal];
        bgButton.titleLabel.font = [UIFont systemFontOfSize:16];
        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(30, SCREEN_WIDTH-30, 30, 0);
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, -SCREEN_WIDTH+30, 0, 50);
        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        _bgButton = bgButton;
        
    }
    return self;
}

- (void)headBtnClick{
    _model.opened = !_model.isOpened;
    if ([_delegate respondsToSelector:@selector(clickHeadView)]) {
        [_delegate clickHeadView];
    }
}

-(void)setModel:(HelpModel *)model{
    _model = model;
    [_bgButton setTitle:[NSString stringWithFormat:@"  %@",model.title] forState:UIControlStateNormal];
}

- (void)didMoveToSuperview{
    _bgButton.imageView.transform = _model.isOpened ? CGAffineTransformMakeRotation(M_PI_4*2) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _bgButton.frame = self.bounds;
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    line.backgroundColor = kUIColorFromRGB(0xEEEEEE);
    [self addSubview:line];
}

@end
