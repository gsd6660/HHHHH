//
//  ZQChatCell.m
//  TSYCAPP
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "ZQChatCell.h"
#define ICON_WH 40
@interface ZQChatCell()
@property (nonatomic, strong) UIImageView  *bubbleIV;   //气泡

@property (nonatomic, strong) UILabel *contentLabel;    //文字
@end


@implementation ZQChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        UIView *backView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView = backView;
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews {
    
    //头像
    self.iconIV = [[UIImageView alloc] init];
    self.iconIV.frame = CGRectMake(0, 0, ICON_WH, ICON_WH);
    self.iconIV.contentMode = UIViewContentModeScaleAspectFit;
    self.iconIV.image = [UIImage imageNamed:@"default_icon"];
    [self.contentView addSubview:self.iconIV];
    
    //背景气泡
    self.bubbleIV = [[UIImageView alloc] init];
    self.bubbleIV.userInteractionEnabled = YES;
    [self.contentView addSubview:self.bubbleIV];
    
    //消息内容
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [UIColor grayColor];
    [self.bubbleIV addSubview:self.contentLabel];
}

- (void)setModel:(SendModel *)model {
    //计算文字长度
    self.contentLabel.text = model.content;
    CGSize labelSize = [model.content boundingRectWithSize: CGSizeMake(SCREEN_WIDTH-160, MAXFLOAT)
                                                   options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                                attributes: @{NSFontAttributeName:self.contentLabel.font}
                                                   context: nil].size;
    self.contentLabel.frame = CGRectMake(model.from_side == 1 ? 20 : 10 , 5, labelSize.width, labelSize.height + 10);
    
    //计算气泡位置
    CGFloat bubbleX = model.from_side == 1 ? (ICON_WH + 25) : (SCREEN_WIDTH - ICON_WH - 25 - labelSize.width - 30);
    self.bubbleIV.frame = CGRectMake(bubbleX, 20, self.contentLabel.frame.size.width + 30, self.contentLabel.frame.size.height+10);
    
    //头像位置
    CGFloat iconX = model.from_side == 1 ? 15 : (SCREEN_WIDTH - ICON_WH - 15);
    self.iconIV.frame = CGRectMake(iconX, 15, ICON_WH, ICON_WH);
//    self.iconIV.image = [UIImage imageNamed: model.from_side  == 1 ? @"default_icon" : @"teacher_image"];
    
    //拉伸气泡
    UIImage *backImage = [UIImage imageNamed: model.from_side  == 1 ? @"bubble_left" : @"bubble_right"];
    backImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 10, 30) resizingMode:UIImageResizingModeStretch];
    self.bubbleIV.image = backImage;
}

- (void)setModel1:(SendModel *)model1{
    _model1 = model1;
    self.contentLabel.text = model1.content;
    CGSize labelSize = [model1.content boundingRectWithSize: CGSizeMake(SCREEN_WIDTH-160, MAXFLOAT)
                                                   options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                                attributes: @{NSFontAttributeName:self.contentLabel.font}
                                                   context: nil].size;
    self.contentLabel.frame = CGRectMake(model1.from_side == 2 ? 20 : 10 , 5, ceil(labelSize.width)+1, ceil(labelSize.height) + 10);
    
    //计算气泡位置
    CGFloat bubbleX = model1.from_side == 2 ? (ICON_WH + 25) : (SCREEN_WIDTH - ICON_WH - 25 - labelSize.width - 30);
    self.bubbleIV.frame = CGRectMake(bubbleX, 20, self.contentLabel.frame.size.width + 30, self.contentLabel.frame.size.height+10);
    
    //头像位置
    CGFloat iconX = model1.from_side == 2 ? 15 : (SCREEN_WIDTH - ICON_WH - 15);
    self.iconIV.frame = CGRectMake(iconX, 15, ICON_WH, ICON_WH);
    //    self.iconIV.image = [UIImage imageNamed: model.from_side  == 1 ? @"default_icon" : @"teacher_image"];
    
    //拉伸气泡
    UIImage *backImage = [UIImage imageNamed: model1.from_side  == 2 ? @"bubble_left" : @"bubble_right"];
    backImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 10, 30) resizingMode:UIImageResizingModeStretch];
    self.bubbleIV.image = backImage;
    
}

@end
