//
//  GoodsOneCell.m
//  LYMallApp
//
//  Created by gds on 2020/3/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GoodsOneCell.h"

@implementation GoodsOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.tipLabel.textColor = kUIColorFromRGB(0x3ACD7B);
    YBDViewBorderRadiusWithBorder(self.tipLabel, 5, 1, kUIColorFromRGB(0x3ACD7B));
    [self.contentView addSubview:self.tipLabel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",dataDic[@"goods_name"]];
       self.descLabel.text = [NSString stringWithFormat:@"%@",dataDic[@"selling_point"]];
    
    
}

@end
