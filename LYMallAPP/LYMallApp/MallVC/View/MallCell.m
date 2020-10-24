//
//  MallCell.m
//  LYMallApp
//
//  Created by Mac on 2020/3/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MallCell.h"
#import "MallModel.h"
#import "SKUModel.h"
#import "XinOrderPayVC.h"
@implementation MallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 5;
    self.layer.cornerRadius = 5;
    
  

}
- (IBAction)addCartButn:(UIButton *)sender {

        NSLog(@"点击===%@",self.model.goods_name);

//    [NetWorkConnection postURL:@"api/cart/add" param:@{@"goods_id":[self.model.goods_id stringValue],@"goods_num":@"1",@"spec_sku_id":[NSString stringWithFormat:@"%@",self.model.goods_sku[@"spec_sku_id"]]} success:^(id responseObject, BOOL success) {
//        if (responseSuccess) {
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCartData" object:nil];
//            ShowHUD(responseMessage);
//
//        }else{
//            ShowErrorHUD(responseJSONString);
//        }
//
//    } fail:^(NSError *error) {
//
//    }];
    
    
    if (self.typeblock) {
        self.typeblock();
    }
    
    
    
}

-(void)setModel:(MallModel *)model{
    _model = model;
    [self.goodsImageView yy_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholder:CCImage(@"")];
    self.goodsNameLabel.text = model.goods_name;
    self.desLabel.text = model.selling_point;
    self.priceLable.text = [NSString stringWithFormat:@"¥%@",model.goods_sku[@"goods_price"]];
    
    self.oldPriceLabel.text = [NSString stringWithFormat:@"¥%@",model.goods_sku[@"line_price"]];
    self.salesLabel.text = [NSString stringWithFormat:@"月销%@份",model.goods_sales];
 
}



@end
