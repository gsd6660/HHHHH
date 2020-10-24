//
//  GoodsTopVipCell.m
//  LYMallApp
//
//  Created by 科技 on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GoodsTopVipCell.h"

@implementation GoodsTopVipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgImgView.userInteractionEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataDic:(NSDictionary *)dataDic{
    self.titleLabel.text = [NSString stringWithFormat:@"当前%@会员价",dataDic[@"user_grade"][@"grade_name"]];
    self.pricelabel.text = [NSString stringWithFormat:@"￥%@",dataDic[@"user_grade_price"]];
}

@end
