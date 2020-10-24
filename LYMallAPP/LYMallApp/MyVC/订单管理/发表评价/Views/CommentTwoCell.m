//
//  CommentTwoCell.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CommentTwoCell.h"

@implementation CommentTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tipLabel= [[UILabel alloc]init];
        self.tipLabel.text = @"宝贝评价";
        self.tipLabel.textColor = kUIColorFromRGB(0x333333);
        self.tipLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.tipLabel];
        [self.contentView addSubview:self.starView];
        [self.contentView addSubview:self.starLabel];
        MJWeakSelf;
        self.starView.evaluateViewChooseStarBlock = ^(NSUInteger count) {
            if (count<=2) {
                weakSelf.starLabel.text = @"差";
            }else if(count==3){
                 weakSelf.starLabel.text = @"一般";
            }else if (count>=4){
                 weakSelf.starLabel.text = @"好";
            }
            weakSelf.selectStar(count, weakSelf.indexPath);
        };
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(22);
            make.width.mas_equalTo(80);
        }];
        [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tipLabel.mas_right).offset(10);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(40);
        }];
        [self.starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.starView.mas_right).offset(10);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    return self;
}

- (TggStarEvaluationView *)starView{
    if (!_starView) {
        _starView = [[TggStarEvaluationView  alloc]init];
        _starView.backgroundColor = [UIColor whiteColor];
        _starView.starCount = 0;
        _starView.tapEnabled = YES;
    }
    return _starView;
}

- (UILabel *)starLabel{
    if (!_starLabel) {
        _starLabel = [[UILabel alloc]init];
        _starLabel.textColor = kUIColorFromRGB(0x333333);
        _starLabel.font = [UIFont systemFontOfSize:13];
    }
    return _starLabel;
}

@end
