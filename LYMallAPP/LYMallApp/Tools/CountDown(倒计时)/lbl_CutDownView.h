//
//  lbl_CutDownView.h
//  Test
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 筒子家族. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum {
    
    CutDownHome,
    CutDownDetail,
    
} CutDownStyle;

@interface lbl_CutDownView : UIView

- (void)startTime:(NSString *)startTime endTime:(NSString *)endTime cdStyle:(CutDownStyle)style;

@property (nonatomic,strong) dispatch_source_t timer;
// 结束
@property (nonatomic,copy)   void              (^TimeEndBlock)(void);
// 开始
@property (nonatomic,copy)   void              (^TimeStartBlock)(void);
// 是否结束
@property (nonatomic,assign) BOOL              timeEnd;
// 是否开始
@property (nonatomic,assign) BOOL              timeStart;
//背景色
@property (nonatomic,strong)UIColor * backgroundColor;
//字体颜色
@property (nonatomic,strong)UIColor * textColor;
//冒号颜色
@property (nonatomic,strong)UIColor * colonColor;


@end
