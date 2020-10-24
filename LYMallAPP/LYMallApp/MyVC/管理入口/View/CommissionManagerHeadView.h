//
//  CommissionManagerHeadView.h
//  LYMallApp
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommissionManagerHeadView : UIView
@property (weak, nonatomic) IBOutlet UIButton *incomeButn;
@property (weak, nonatomic) IBOutlet UIButton *recordButn;
@property (weak, nonatomic) IBOutlet UIView *leftlineView;
@property (weak, nonatomic) IBOutlet UIView *rightlineView;

@property (weak, nonatomic) IBOutlet UIButton *tixainButn;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UILabel *lable4;

@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;

-(void)getDataDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
