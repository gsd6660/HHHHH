//
//  HBK_ShopppingCartBottomView.m
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBK_ShopppingCartBottomView.h"

@implementation HBK_ShopppingCartBottomView

- (void)drawRect:(CGRect)rect {
    self.allButn.imagePosition = QMUIButtonImagePositionLeft;
    self.allButn.spacingBetweenImageAndTitle = 3;
    
}



- (IBAction)allButn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
      if (sender.selected) {
          [sender setImage:[UIImage imageNamed:@"jft_but_selected"] forState:(UIControlStateNormal)];
      } else {
          [sender setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:(UIControlStateNormal)];
      }
      if (self.AllClickBlock) {
          self.AllClickBlock(sender.selected);
      }
    
}




- (IBAction)balanceAcountButn:(UIButton *)sender {
    if (self.AccountBlock) {
          self.AccountBlock(sender);
      }
    
    
}

- (void)setIsClick:(BOOL)isClick {
    _isClick = isClick;
    self.allButn.selected = isClick;
    if (isClick) {
        [self.allButn setImage:[UIImage imageNamed:@"jft_but_selected"] forState:(UIControlStateNormal)];
    } else {
        [self.allButn setImage:[UIImage imageNamed:@"jft_but_Unselected"] forState:(UIControlStateNormal)];
    }
}


@end
