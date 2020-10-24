//
//  MySubscripOneCell.m
//  LYMallApp
//
//  Created by Mac on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MySubscripOneCell.h"
#import "NCLookLogisticsVC.h"

@interface MySubscripOneCell ()
@property(nonatomic,strong)NSDictionary *dic;
@end

@implementation MySubscripOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)getDataDic:(NSDictionary *)dic{
    
    self.dic = dic;
    self.goodsNameLabel.text = dic[@"name"];
       self.sizeLable.text = dic[@"sku"];
       self.countNumLable.text = [NSString stringWithFormat:@"第%@期",dic[@"cycle_num"]];
       self.timeLabel.text = [NSString stringWithFormat:@"预发货时间：%@",dic[@"period_time"]];
       if ([dic[@"status"] intValue] == 0) {
           //0未发货 1已发货 2已完成
           self.statusLabel.text = @"未发货 ";
       }else if ([dic[@"status"] intValue] == 1) {
           self.statusLabel.text = @"已发货";
       }else if ([dic[@"status"] intValue] == 2) {
           self.statusLabel.text = @"已完成";
       }
    
}

//查看物流
- (IBAction)afterSaleButn:(UIButton *)sender {
    #pragma mark 查看物流

    if ([CheackNullOjb cc_isNullOrNilWithObject:self.dic] == NO) {
        NCLookLogisticsVC * vc = [[NCLookLogisticsVC alloc]init];
        vc.order_id = [NSString stringWithFormat:@"%@",self.dic[@"cycle_id"]];
        vc.is_refund = 2;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    
        

}



- (IBAction)pingjiaButn:(UIButton *)sender {
    #pragma mark 确定收货
    if ([CheackNullOjb cc_isNullOrNilWithObject:self.dic] == NO) {
        [NetWorkConnection postURL:@"api/user.cycle/receipt" param:@{@"cycle_id":self.dic[@"cycle_id"]} success:^(id responseObject, BOOL success) {
                   if (responseSuccess) {
                       ShowHUD(@"收货成功");
                   }else{
                       ShowErrorHUD(responseMessage);
                   }
                   
               } fail:^(NSError *error) {
                   
               }];
        
    }
       
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
