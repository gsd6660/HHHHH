//
//  CommentOneCell.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CommentOneCell.h"

@interface CommentOneCell()
{
    NSInteger _count;
}

@end

@implementation CommentOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * tipLabel= [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 20)];
        tipLabel.text = @"宝贝评价";
        tipLabel.textColor = kUIColorFromRGB(0x333333);
        tipLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:tipLabel];
        
        [self.contentView addSubview:self.starView];
        [self.contentView addSubview:self.starLabel];
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.photosView];
        
        self.photosView.frame = CGRectMake(10, 120, ScreenWidth - 20, 80);
        
 
//        [self.photosView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.right.mas_equalTo(-10);
//            make.top.equalTo(self.textView.mas_bottom).offset(10);
//            make.height.mas_equalTo(80);
//        }];
        
        MJWeakSelf;
        self.starView.evaluateViewChooseStarBlock = ^(NSUInteger count) {
            if (count<=2) {
                weakSelf.starLabel.text = @"差";
            }else if(count==3){
                weakSelf.starLabel.text = @"一般";
            }else if (count>=4){
                weakSelf.starLabel.text = @"好";
            }
            weakSelf.selectStarClick(count, weakSelf.indexPath);
        };
 
    }
    return self;
}



- (TggStarEvaluationView *)starView{
    if (!_starView) {
        _starView = [[TggStarEvaluationView alloc]initWithFrame:CGRectMake(90, 10, 200, 40)];
        _starView.backgroundColor = [UIColor whiteColor];
        _starView.tapEnabled = YES;
        //        _starView.maximumValue = 5;
        //        _starView.minimumValue = 0;
        //        _starView.spacing = 15;
        //        _starView.starBorderWidth = 10;
        //        _starView.value = 0;
        //        _starView.emptyStarImage = [[UIImage imageNamed:@"jft_icon_greystar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //        _starView.filledStarImage = [[UIImage imageNamed:@"jft_icon_greystar_full"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _starView;
}

- (UILabel *)starLabel{
    if (!_starLabel) {
        _starLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 80, 20, 60, 20)];
        _starLabel.textColor = kUIColorFromRGB(0x333333);
        _starLabel.font = [UIFont systemFontOfSize:13];
    }
    return _starLabel;
}


- (QMUITextView *)textView{
    if (!_textView) {
        _textView = [[QMUITextView alloc]initWithFrame:CGRectMake(10, 60, ScreenWidth - 20, 50)];
        _textView.placeholder = @"宝贝满足您的期待吗？请发表您对它的评价吧~";
    }
    return _textView;
}

- (PYPhotosView *)photosView{
    if (!_photosView) {
        _photosView = [[PYPhotosView alloc]init];
        _photosView.images = nil;
        _photosView.photosMaxCol = 3;
        _photosView.imagesMaxCountWhenWillCompose = 3;
    }
    return _photosView;
}




@end
