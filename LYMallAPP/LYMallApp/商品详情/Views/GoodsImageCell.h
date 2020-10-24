//
//  GoodsImageCell.h
//  LYMallApp
//
//  Created by 科技 on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"
NS_ASSUME_NONNULL_BEGIN

@interface GoodsImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property(nonatomic,strong)NSDictionary * dataDic;
@property (weak, nonatomic) IBOutlet DetailView *wkwebView;
@property(nonatomic,strong)UITableView * tabView;
//浏览器高度
@property(nonatomic,assign)CGFloat webHeight;
//内容
@property(nonatomic,copy)NSString *contentHtml;
@end

NS_ASSUME_NONNULL_END
