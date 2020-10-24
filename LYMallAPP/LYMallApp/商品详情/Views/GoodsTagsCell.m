//
//  GoodsTagsCell.m
//  LYMallApp
//
//  Created by gds on 2020/3/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GoodsTagsCell.h"
@interface GoodsTagsCell()
@end

@implementation GoodsTagsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    

    
}
-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
     NSArray * array = dataDic[@"tags"];
     CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
     CGFloat h = 0;//用来控制button距离父视图的高
     for (int i = 0; i < array.count; i++) {
         QMUIButton *button = [QMUIButton buttonWithType:UIButtonTypeCustom];
         button.tag = 100 + i;
         button.titleLabel.font = [UIFont systemFontOfSize:12];
         [button setTitleColor:[UIColor colorWithRGB:0x666666 alpha:1] forState:UIControlStateNormal];
         [button setImage:CCImage(@"jft_icon_checkmark") forState:UIControlStateNormal];
         button.imagePosition = QMUIButtonImagePositionLeft;
         button.spacingBetweenImageAndTitle = 5;
         //依据计算文字的大小
         NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
         CGFloat length = [array[i] boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
         //为button赋值
         [button setTitle:array[i] forState:UIControlStateNormal];
         //设置button的frame
         button.frame = CGRectMake(10 + w, h, length + 25 , 20);
         //当button的位置超出屏幕边缘时换行 320 仅仅是button所在父视图的宽度
         if(10 + w + length + 15 > 320){
             w = 0; //换行时将w置为0
             button.frame = CGRectMake(10 + w, h, length + 25, 20);//重设button的frame
         }
         w = button.frame.size.width + button.frame.origin.x;
         [self.contentView addSubview:button];
     }
    
}

@end
