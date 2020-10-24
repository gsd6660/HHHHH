//
//  CollectionHeaderView.m
//  LYMallApp
//
//  Created by Mac on 2020/3/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUI];
    }
    
    return self;
}
 
#pragma mark - 视图
 
- (void)setUI
{
    
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = CCImage(@"green-juxing");
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(12.5);
        make.top.height.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(3, 17));
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"新品上市" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

    self.titleLabel.attributedText = string;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12.5);
        make.top.height.mas_equalTo(16);
        make.left.equalTo(imageView.mas_right).offset(9);
        make.width.mas_equalTo(100);
    }];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
}




@end
