//
//  RegisterMemberFootView.h
//  LYMallApp
//
//  Created by Mac on 2020/5/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^getInviterCodeBlock)();

@interface RegisterMemberFootView : UIView
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeButn;
@property (weak, nonatomic) IBOutlet UIImageView *bgimgView;
@property (nonatomic,copy)getInviterCodeBlock block;
@end

NS_ASSUME_NONNULL_END
