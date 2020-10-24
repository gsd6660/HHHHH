//
//  EquityManagementCell.m
//  LYMallApp
//
//  Created by Mac on 2020/5/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "EquityManagementCell.h"

@implementation EquityManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    self.timeLable.text = [NSString stringWithFormat:@"%@",dataDic[@"create_time"]];
    self.biandongLable.text = [NSString stringWithFormat:@"%@",dataDic[@"money"]];
    self.desLable.text = [NSString stringWithFormat:@"说明：%@",dataDic[@"scene"]];
    self.countLable.text = [NSString stringWithFormat:@"%@",dataDic[@"surplus_num"]];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
