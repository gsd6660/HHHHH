//
//  APPIntroduceVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/9.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "APPIntroduceVC.h"

@interface APPIntroduceVC ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation APPIntroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"平台介绍";
}
- (IBAction)updateApp:(UIButton *)sender {
    ShowHUD(@"已是最新版");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
