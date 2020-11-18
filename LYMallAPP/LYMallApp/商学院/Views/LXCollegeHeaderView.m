//
//  LXCollegeHeaderView.m
//  LYMallApp
//
//  Created by guxiang on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXCollegeHeaderView.h"
#import "LXCollegeListVC.h"
@implementation LXCollegeHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    YBDViewBorderRadius(self.bgView, 20);
    YBDViewBorderRadius(self.serachBtn, 20);
}


- (IBAction)serachClick:(id)sender {
    
    if (self.searchTF.text.length == 0) {
        ShowErrorHUD(@"请输入内容");
        return;
    }
    LXCollegeListVC * vc = [LXCollegeListVC new];
    vc.keyword = self.searchTF.text;
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
    
}



@end
