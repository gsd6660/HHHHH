//
//  MenuSelectView.h
//  LYMallApp
//
//  Created by Mac on 2020/4/7.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^getcategory_idBlock)(NSString *category_id);
@interface MenuSelectView : UIView
-(void)showMenuView;
@property(nonatomic,assign)NSInteger isShow;
@property(nonatomic,copy)getcategory_idBlock block;

@end

NS_ASSUME_NONNULL_END
