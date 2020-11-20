//
//  LXGoldPopView.m
//  LYMallApp
//
//  Created by guxiang on 2020/11/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXGoldPopView.h"

@implementation LXGoldPopView


- (void)awakeFromNib{
    [super awakeFromNib];
    YBDViewBorderRadius(self, 10);
    YBDViewBorderRadius(self.confirmBtn, 10);
    YBDViewBorderRadius(self.cancelBtn, 10);
    self.goldTF.keyboardType = UIKeyboardTypePhonePad;
}
- (IBAction)confirmClick:(id)sender {
    if (self.goldTF.text.length == 0) {
        ShowErrorHUD(@"请输入金豆数量");
        return;
    }
    
    self.cofirmBlock(self.goldTF.text);
}

- (IBAction)cancelBtnClick:(id)sender {
    self.cancelBlock();
}

@end
