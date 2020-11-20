//
//  LXGoldPopView.h
//  LYMallApp
//
//  Created by guxiang on 2020/11/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXGoldPopView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *goldTF;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;



@property (nonatomic, copy)void (^cofirmBlock)(NSString * str);
@property (nonatomic, copy)void (^cancelBlock)(void);
@end

NS_ASSUME_NONNULL_END
