//
//  LXKeFuViewController.m
//  LYMallApp
//
//  Created by guxiang on 2020/11/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXKeFuViewController.h"

@interface LXKeFuViewController ()
@property (weak, nonatomic) IBOutlet QMUITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *commit;

@end

@implementation LXKeFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系客服";
    YBDViewBorderRadius(self.textView, 10);
    YBDViewBorderRadius(self.commit, 5);
    [self.commit addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)commitClick{
    if (self.textView.text.length == 0) {
        [QMUITips showError:@"请输入内容"];
        return;
    }
    
    [QMUITips showLoadingInView:self.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [QMUITips showSucceed:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}



@end
