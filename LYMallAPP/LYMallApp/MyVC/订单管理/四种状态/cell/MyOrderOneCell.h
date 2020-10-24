//
//  MyOrderOneCell.h
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockA)(NSInteger a);

typedef void(^blockB)(NSInteger b);
                      
NS_ASSUME_NONNULL_BEGIN

@interface MyOrderOneCell : UITableViewCell
@property(nonatomic,strong)NSDictionary *dicData;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titLable;
@property (weak, nonatomic) IBOutlet UILabel *guigeLable;

@property (weak, nonatomic) IBOutlet UILabel *countLable;

@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (weak, nonatomic) IBOutlet UILabel *numLbale;

@property(nonatomic,strong)NSDictionary *consumeData;


@property(nonatomic,copy)blockA blocka;
@property(nonatomic,copy)blockB blockb;
@property(nonatomic,assign)NSInteger index;

- (void)setAfterDetailModel:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
