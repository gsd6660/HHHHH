//
//  teamDetailView.m
//  LYMallApp
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "TeamDetailView.h"

@implementation TeamDetailView


- (void)drawRect:(CGRect)rect {
//    QMUILayerMinXMinYCorner = 1U << 0,
//    QMUILayerMaxXMinYCorner = 1U << 1,
//    QMUILayerMinXMaxYCorner = 1U << 2,
//    QMUILayerMaxXMaxYCorner = 1U << 3,
    self.topView.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner |QMUILayerMaxXMinYCorner;
    self.topView.layer.cornerRadius = 7.5;
}

-(void)getDataDic:(NSDictionary *)dic{
    
    self.orderNumLabel.text = [NSString stringWithFormat:@"%@",dic[@"order_sn"]];
    self.timeLable.text = [NSString stringWithFormat:@"%@",dic[@"create_time"]];
    self.orderMoneylabel.text = [NSString stringWithFormat:@"%@",dic[@"pay_price"]];
    self.yongjinLabel.text = [NSString stringWithFormat:@"%@",dic[@"commission_price"]];
    self.daozhangTimeLabel.text = [NSString stringWithFormat:@"%@",dic[@"settle_time"]];

    self.nameLabel.text = [NSString stringWithFormat:@"%@",dic[@"real_name"]];
    self.mobileLabel.text = [NSString stringWithFormat:@"%@",dic[@"mobile"]];

    
}
@end
