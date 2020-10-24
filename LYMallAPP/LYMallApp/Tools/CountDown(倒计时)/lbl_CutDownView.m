//
//  lbl_CutDownView.m
//  Test
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 筒子家族. All rights reserved.
//

#import "lbl_CutDownView.h"


@implementation lbl_CutDownView
{
    UILabel       *_tint;

    UILabel       *_hourl;
    UILabel       *_minl;
    UILabel       *_secondl;

    long          _totalTimes;
}

- (void)startTime:(NSString *)startTime endTime:(NSString *)endTime cdStyle:(CutDownStyle)style
{
    switch (style)
    {
        case CutDownHome:
        {
            CGFloat width = 16;

            // 提示距离...时间
            if (!_tint)
            {
                _tint           = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 13)];
                _tint.textColor = self.textColor;
                _tint.font      = [UIFont systemFontOfSize:11];
            }
//            [self addSubview:_tint];
            
            // 时
            if (!_hourl)
            {
                _hourl                       = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, width)];
                _hourl.textAlignment         = NSTextAlignmentCenter;
                _hourl.textColor = self.textColor;

                _hourl.font                  = [UIFont systemFontOfSize:11];
                _hourl.layer.masksToBounds   = YES;
                _hourl.layer.cornerRadius    = 2;
                _hourl.backgroundColor = self.backgroundColor;
//                kUIColorFromRGB(0x0BC160);
            }
            [self addSubview:_hourl];
            
            // 分
            if (!_minl)
            {
                _minl                        = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_hourl.frame)+32/3.0, 0, width, width)];
                _minl.textAlignment          = NSTextAlignmentCenter;
                _minl.textColor = self.textColor;

                _minl.font                   = [UIFont systemFontOfSize:11];
                _minl.layer.masksToBounds    = YES;
                _minl.layer.cornerRadius     = 2;
//                _minl.backgroundColor = kUIColorFromRGB(0x0BC160);
                _minl.backgroundColor = self.backgroundColor;
               
            }
            [self addSubview:_minl];
            
            // 秒
            if (!_secondl)
            {
                _secondl                     = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_minl.frame)+32/3.0, 0, width, width)];
                _secondl.textAlignment       = NSTextAlignmentCenter;
                _secondl.textColor = self.textColor;

                _secondl.font                = [UIFont systemFontOfSize:11];
                _secondl.layer.masksToBounds = YES;
                _secondl.layer.cornerRadius  = 2;
//                _secondl.backgroundColor = kUIColorFromRGB(0x0BC160);
                _secondl.backgroundColor = self.backgroundColor;
            }
            [self addSubview:_secondl];
            
            // 冒号
            for (int i=0; i<2; i++)
            {
                UILabel *mh = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_hourl.frame) + (width+33/3.0)*i, 0, 33/3.0, width)];
                mh.text = @":";
                mh.textColor = self.colonColor;
                mh.textAlignment = NSTextAlignmentCenter;
                [self addSubview:mh];
            }
        }
            break;
        case CutDownDetail:
        {
            UIImageView *bgImgv = [[UIImageView alloc] initWithFrame:self.bounds];
            bgImgv.image        = [UIImage imageNamed:@"cutdown"];
            [self addSubview:bgImgv];

            CGFloat width       = 47/3.0;

            // 提示距离...时间
            if (!_tint)
            {
                _tint               = [[UILabel alloc] initWithFrame:CGRectMake(180/3.0, 22, 70, 15)];
                _tint.textColor     = self.textColor;
                _tint.font          = [UIFont systemFontOfSize:10];
            }
//            [bgImgv addSubview:_tint];
            
            // 时
            if (!_hourl)
            {
                _hourl                       = [[UILabel alloc] initWithFrame:CGRectMake(180/3.0, CGRectGetHeight(self.frame)-20/3.0-width, width, width)];
                _hourl.backgroundColor = self.backgroundColor;;
                _hourl.textColor             = self.textColor;
                _hourl.textAlignment         = NSTextAlignmentCenter;
                _hourl.font                  = [UIFont systemFontOfSize:12];
                _hourl.layer.masksToBounds   = YES;
                _hourl.layer.cornerRadius    = 2;
            }
            [bgImgv addSubview:_hourl];
            
            // 分
            if (!_minl)
            {
                _minl                        = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_hourl.frame)+32/3.0, CGRectGetHeight(self.frame)-20/3.0-width, width, width)];
                _minl.backgroundColor = self.backgroundColor;
                _minl.textColor              = self.textColor;
                _minl.textAlignment          = NSTextAlignmentCenter;
                _minl.font                   = [UIFont systemFontOfSize:32/3.0];
                _minl.layer.masksToBounds   = YES;
                _minl.layer.cornerRadius     = 2;
            }
            [bgImgv addSubview:_minl];
            
            // 秒
            if (!_secondl)
            {
                _secondl                     = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_minl.frame)+32/3.0, CGRectGetHeight(self.frame)-20/3.0-width, width, width)];
                _secondl.backgroundColor = self.backgroundColor;
                _secondl.textColor              = self.textColor;
                _secondl.textAlignment       = NSTextAlignmentCenter;
                _secondl.font                = [UIFont systemFontOfSize:12];
                _secondl.layer.masksToBounds = YES;
                _secondl.layer.cornerRadius  = 2;
            }
            [bgImgv addSubview:_secondl];
            
            // 冒号
            for (int i=0; i<2; i++)
            {
                UILabel *mh = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_hourl.frame) + (width+32/3.0)*i, CGRectGetHeight(self.frame)-25/3.0-width, 32/3.0, width)];
                mh.text = @":";
                mh.textColor = self.colonColor;
                mh.textAlignment = NSTextAlignmentCenter;
                [bgImgv addSubview:mh];
            }
        }
            break;
            
        default:
            break;
    }
    
    // 时间处理
    NSString *distanceEndTime = [self intervalFromLastDate:[self getCurrentTime] toTheDate:endTime];
    
    int end_hour   = [[distanceEndTime componentsSeparatedByString:@":"][0] intValue];
    int end_min    = [[distanceEndTime componentsSeparatedByString:@":"][1] intValue];
    int end_second = [[distanceEndTime componentsSeparatedByString:@":"][2] intValue];
    
    _totalTimes = end_hour*60*60 + end_min*60 + end_second;
    
    if (self.timer) {
        dispatch_cancel(self.timer);
    }

    // 已经结束
    if (_totalTimes <= 0)
    {
        _hourl.text   = @"00";
        _minl.text    = @"00";
        _secondl.text = @"00";

        _tint.text    = @"距离结束时间";
        self.timeEnd  = YES;
    }
    // 还未结束 ---> 判断是否开始
    else
    {
        self.timeEnd = NO;

        NSString *distanceStartTime = [self intervalFromLastDate:startTime toTheDate:[self getCurrentTime]];
        
        int start_hour   = [[distanceStartTime componentsSeparatedByString:@":"][0] intValue];
        int start_min    = [[distanceStartTime componentsSeparatedByString:@":"][1] intValue];
        int start_second = [[distanceStartTime componentsSeparatedByString:@":"][2] intValue];
        
        long totalTimes = start_hour*60*60 + start_min*60 + start_second;
        
        // 已经开始(当前时间 大于 开始时间)
        if (totalTimes >= 0)
        {
            self.timeStart = YES;
            _tint.text     = @"距离结束时间";
            
            [self hour:end_hour minute:end_min second:end_second];
        }
        // 还未开始(当前时间 小于 开始时间)
        else
        {
            self.timeStart = NO;
            _tint.text     = @"距离开始时间";
            _totalTimes    = -totalTimes;
            
            [self hour:-start_hour minute:-start_min second:-start_second];
        }
        
        [self cutDown];
    }
}

- (void)hour:(int)h minute:(int)m second:(int)s
{
    if (h < 10) {
        _hourl.text   = [NSString stringWithFormat:@"0%d", h];
    } else {
        _hourl.text   = [NSString stringWithFormat:@"%d", h];
    }
    
    if (m < 10) {
        _minl.text    = [NSString stringWithFormat:@"0%d", m];
    } else {
        _minl.text    = [NSString stringWithFormat:@"%d", m];
    }
    
    if (s < 10) {
        _secondl.text = [NSString stringWithFormat:@"0%d", s];
    } else {
        _secondl.text = [NSString stringWithFormat:@"%d", s];
    }
}

- (void)cutDown
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    uint64_t intival      = 1.0 * NSEC_PER_SEC;
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW,(int64_t)2.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(_timer, start, intival, 0);
    
    dispatch_source_set_event_handler(_timer, ^
    {
        __block long time = -- _totalTimes;
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            // 秒
            if (time%60 < 10) {
                _secondl.text = [NSString stringWithFormat:@"0%ld",time%60];
            } else {
                _secondl.text = [NSString stringWithFormat:@"%ld",time%60];
            }
                                              
            // 分
            time /= 60;
            if (time > 0)
            {
                if (time%60 < 10) {
                    _minl.text = [NSString stringWithFormat:@"0%ld",time%60];
                } else {
                    _minl.text = [NSString stringWithFormat:@"%ld",time%60];
                }
                
            } else {
                _minl.text = @"00";
            }
                                              
            // 时
            time /= 60;
            if (time > 0)
            {
                if (time < 10) {
                    _hourl.text = [NSString stringWithFormat:@"0%ld",time];
                } else {
                    _hourl.text = [NSString stringWithFormat:@"%ld",time];
                }
                
            } else {
                _hourl.text = @"00";
            }
        });
        
        if (_totalTimes == 0)
        {
            dispatch_cancel(self.timer);

            if (self.TimeEndBlock) {
                self.TimeEndBlock();
            }
            
            if (CutDownDetail)
            {
                // 未开始 ---> 开始,刷新计时器,进入结束倒计时
                if (!self.timeStart)
                {
                    if (self.TimeStartBlock) {
                        self.TimeStartBlock();
                    }
                }
            }
        }
    });
    dispatch_resume(_timer);
}

// 计算2个时间的时间差
- (NSString *)intervalFromLastDate:(NSString *)dateString1  toTheDate:(NSString *)dateString2
{
    NSArray *timeArray1   = [dateString1 componentsSeparatedByString:@"."];
    dateString1           = [timeArray1 objectAtIndex:0];

    NSArray *timeArray2   = [dateString2 componentsSeparatedByString:@"."];
    dateString2           = [timeArray2 objectAtIndex:0];

    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate *d1            = [date dateFromString:dateString1];
    NSTimeInterval late1  = [d1 timeIntervalSince1970]*1;

    NSDate *d2            = [date dateFromString:dateString2];
    NSTimeInterval late2  = [d2 timeIntervalSince1970]*1;

    NSTimeInterval cha    = late2 - late1;
    NSString *timeString  = @"";
    NSString *house       = @"";
    NSString *min         = @"";
    NSString *sen         = @"";
    
    // 秒
    sen        = [NSString stringWithFormat:@"%d", (int)cha%60];
    sen        = [NSString stringWithFormat:@"%@", sen];

    // 分
    min        = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    min        = [NSString stringWithFormat:@"%@", min];

    // 小时
    house      = [NSString stringWithFormat:@"%d", (int)cha/3600];
    house      = [NSString stringWithFormat:@"%@", house];

    timeString = [NSString stringWithFormat:@"%@:%@:%@",house,min,sen];
    
    return timeString;
}

- (NSString *)getCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    return dateTime;
}

@end
