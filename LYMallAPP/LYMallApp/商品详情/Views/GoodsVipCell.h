//
//  GoodsVipCell.h
//  LYMallApp
//
//  Created by 科技 on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsVipCell : UITableViewCell
{
    NSArray * imgeArray;
}
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIButton *vipBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property(nonatomic,strong)NSDictionary * dataDic;


- (void)setDataDic:(NSDictionary*)dataDic withIndexPath:(NSIndexPath*)indexpath;

@end

NS_ASSUME_NONNULL_END
