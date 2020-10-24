//
//  GoodsVipCell.m
//  LYMallApp
//
//  Created by 科技 on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GoodsVipCell.h"

@implementation GoodsVipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    imgeArray = @[@"jft_icon_V1",@"jft_icon_V2",@"jft_icon_V3",@"jft_icon_V4",@"jft_icon_V5"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataDic:(NSDictionary *)dataDic withIndexPath:(NSIndexPath *)indexpath{
    if (indexpath.row == 0) {
        self.moreBtn.hidden = NO;
        self.vipBtn.hidden = NO;
        [self.vipBtn setTitle:[NSString stringWithFormat:@"￥%@",dataDic[@"price"]] forState:0];
        [self.vipBtn setImage:[UIImage imageNamed:imgeArray[indexpath.row]] forState:0];
    }else{
        self.moreBtn.hidden = YES;
        self.vipBtn.hidden = YES;
        [self.leftBtn setTitle:[NSString stringWithFormat:@"￥%@",dataDic[@"price"]] forState:0];
        [self.leftBtn setImage:[UIImage imageNamed:imgeArray[indexpath.row]] forState:0];
    }
}

@end
