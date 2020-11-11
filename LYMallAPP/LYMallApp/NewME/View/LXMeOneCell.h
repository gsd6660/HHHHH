//
//  LXMeOneCell.h
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXMeOneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet QMUIButton *oneBtn;


@property (weak, nonatomic) IBOutlet QMUIButton *threeBtn;
@property (weak, nonatomic) IBOutlet QMUIButton *fourBtn;

@property (weak, nonatomic) IBOutlet QMUIButton *fiveBtn;



@property(nonatomic, copy) void (^oneClickBtn)();

@property(nonatomic, copy) void (^threeClickBtn)();
@property(nonatomic, copy) void (^fourClickBtn)();


@property(nonatomic, copy) void (^fiveClickBtn)();


@end

NS_ASSUME_NONNULL_END
