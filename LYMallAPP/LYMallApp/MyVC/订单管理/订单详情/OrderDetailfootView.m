//
//  OrderDetailfootView.m
//  TSYCAPP
//
//  Created by Mac on 2019/8/10.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "OrderDetailfootView.h"


@interface OrderDetailfootView()



@end

@implementation OrderDetailfootView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        self.bgView.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}


- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
   __block UILabel * lastLabel;
    __block CGFloat viewHeight;
   __block CGFloat height = 0;
    __block CGFloat liuyanH = 0;
    [titleArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel * label = [[UILabel alloc]init];
        [self.bgView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastLabel ? lastLabel.mas_bottom:@0).offset(10);
            make.width.offset(ScreenWidth - 80);
            make.left.offset(10);
            make.height.offset(20);
        }];
        if ([titleArray[idx] hasPrefix:@"留言"]) {
            height =  [self getLabelHeight:titleArray[idx]];
            liuyanH = height;
        }
        
        else{
            height = 20;
        }
        [label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(height);
        }];
        
        label.text = titleArray[idx];
        label.numberOfLines = 0;
        label.font  = [UIFont systemFontOfSize:13];
        label.textColor = UIColorHex(0x666666);
        if ([titleArray[idx] hasPrefix:@"订单编号"]) {
        UIButton * btn = [[UIButton alloc]init];
        [self.bgView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastLabel ? lastLabel.mas_bottom:@0).offset(5);
            make.width.offset(50);
            make.right.offset(-10);
            make.height.offset(20);
        }];
        [btn setTitle:@"复制" forState:0];
        [btn setTitleColor:UIColorHex(0x444A53) forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        btn.layer.cornerRadius  = 5;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = UIColorHex(0xC8CDCF).CGColor;
        [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:titleArray[idx]];
            [QMUITips showInfo:@"复制成功"];
        }];
            
        }
        lastLabel = label;
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(10);
        make.width.offset(ScreenWidth-20);
        make.bottom.equalTo(lastLabel.mas_bottom).offset(10);
    }];
    viewHeight = 10 + (20*self.titleArray.count + 20 + liuyanH + 35);
    
    NSLog(@"%f",self.bgView.height);
    self.frame = CGRectMake(0, 0, ScreenWidth, viewHeight);
}

- (CGFloat)getLabelHeight:(NSString *)string{
    CGRect rect=[string boundingRectWithSize:CGSizeMake(ScreenWidth - 80, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    return rect.size.height;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}


@end
