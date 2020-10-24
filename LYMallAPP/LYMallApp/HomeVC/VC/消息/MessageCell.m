//
//  MessageCell.m
//  LYMallApp
//
//  Created by Mac on 2020/3/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    
    [self.aImageView yy_setImageWithURL:[NSURL URLWithString:dic[@"image"][@"file_path"]] placeholder:CCImage(@"fangxingzhanweitu")];
    self.titLabel.text = dic[@"article_title"];
    self.readCountLabel.text = [NSString stringWithFormat:@"阅读%@",dic[@"show_views"]];
    self.timeLabel.text = dic[@"view_time"];

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
