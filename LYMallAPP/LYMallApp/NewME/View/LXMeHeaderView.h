//
//  LXMeHeaderView.h
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXMeHeaderView : UIView
@property (weak, nonatomic) IBOutlet QMUIButton *oneBtn;

@property (weak, nonatomic) IBOutlet QMUIButton *twoBtn;
@property (weak, nonatomic) IBOutlet QMUIButton *threeBtn;

@property (weak, nonatomic) IBOutlet QMUIButton *fourBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

NS_ASSUME_NONNULL_END
