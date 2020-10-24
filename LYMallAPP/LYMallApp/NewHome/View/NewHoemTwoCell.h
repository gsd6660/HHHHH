//
//  NewHoemTwoCell.h
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewHoemTwoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *leftImg;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@property (weak, nonatomic) IBOutlet UIImageView *leftOneImg;
@property (weak, nonatomic) IBOutlet UIImageView *leftTwoImg;

@property (weak, nonatomic) IBOutlet UIImageView *rightImg;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rightOneImg;
@property (weak, nonatomic) IBOutlet UIImageView *rightTwoImg;

@property (weak, nonatomic) IBOutlet UIImageView *leftBottomImg;
@property (weak, nonatomic) IBOutlet UILabel *leftBottomLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bottomOneImg;

@end

NS_ASSUME_NONNULL_END
