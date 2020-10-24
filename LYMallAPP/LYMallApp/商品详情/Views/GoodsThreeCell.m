//
//  GoodsThereCell.m
//  LYMallApp
//
//  Created by gds on 2020/3/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GoodsThreeCell.h"

@implementation GoodsThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    if ([CheackNullOjb cc_isNullOrNilWithObject:dataDic[@"user"][@"avatarUrl"]] == NO) {
        [self.headerView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"user"][@"avatarUrl"]]];
    }
    if ([CheackNullOjb cc_isNullOrNilWithObject:dataDic[@"user"][@"nickName"]] == NO) {
        self.nameLabel.text = dataDic[@"user"][@"nickName"];
    }
    if ([CheackNullOjb cc_isNullOrNilWithObject:dataDic[@"content"]] == NO) {
        self.descLabel.text = dataDic[@"content"];
    }
}

@end
