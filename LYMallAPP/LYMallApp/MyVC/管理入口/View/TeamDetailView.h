//
//  teamDetailView.h
//  LYMallApp
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeamDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *orderMoneylabel;

@property (weak, nonatomic) IBOutlet UILabel *yongjinLabel;

@property (weak, nonatomic) IBOutlet UILabel *daozhangTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *closeButn;
@property (weak, nonatomic) IBOutlet UIView *topView;

-(void)getDataDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
