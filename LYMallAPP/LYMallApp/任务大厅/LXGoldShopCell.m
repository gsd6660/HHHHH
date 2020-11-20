//
//  LXGoldShopCell.m
//  LYMallApp
//
//  Created by guxiang on 2020/11/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXGoldShopCell.h"

@implementation LXGoldShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    YBDViewBorderRadius(self.buyBtn, 10);
    YBDViewBorderRadius(_bgView, 10);
    
}
 

- (void)setDic:(NSDictionary *)dic{
    YBDViewBorderRadius(self, 10);
    _dic = dic;
    self.goldLabel.text = dic[@"gold"];
    NSDictionary * userDic = dic[@"user"];
    self.nameLabel.text = userDic[@"nickName"];
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:userDic[@"avatarUrl"]]];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
     
}


- (void)setFrame:(CGRect)frame{
    frame.size.width -=20;
    frame.origin.x = 10;
//    self.layer.cornerRadius = 25;
    [super setFrame:frame];
}

- (IBAction)buyClick:(id)sender {
    
    self.buyClick();
    
    
}




@end
