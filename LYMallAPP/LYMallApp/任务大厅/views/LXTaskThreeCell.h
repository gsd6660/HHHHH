//
//  LXTaskThreeCell.h
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXTaskThreeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;


@property (weak, nonatomic) IBOutlet UIButton *lowBtn;

@property (weak, nonatomic) IBOutlet UIButton *centerBtn;
@property (weak, nonatomic) IBOutlet UIButton *heightBtn;

@end

NS_ASSUME_NONNULL_END
