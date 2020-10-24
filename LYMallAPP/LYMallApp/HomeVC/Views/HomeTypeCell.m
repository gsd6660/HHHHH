//
//  HomeTypeCell.m
//  LYMallApp
//
//  Created by Mac on 2020/3/10.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "HomeTypeCell.h"

@implementation HomeTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}
-(void)setValuecationWithDataDic:(NSDictionary *)dic{
   
    if (![CheackNullOjb cc_isNullOrNilWithObject:dic[@"image"]]) {
        [self.goodsImageView yy_setImageWithURL:[NSURL URLWithString:dic[@"image"][@"file_path"]] placeholder:nil];
    }
    self.goodsNameLabel.text = [dic[@"name"] length] > 0 ? dic[@"name"] :@"***";
    
}
@end
