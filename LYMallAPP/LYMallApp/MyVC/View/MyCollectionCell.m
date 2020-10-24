//
//  MyCollectionCell.m
//  LYMallApp
//
//  Created by Mac on 2020/3/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MyCollectionCell.h"

@implementation MyCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setValuecationWithDataDic:(NSDictionary *)dic{
   
    self.myImageView.image = CCImage(dic[@"icon"]);
    self.titLabel.text = [dic[@"title"] length] > 0 ? dic[@"title"] :@"***";
    
}
@end
