//
//  LXCollegeSectionHeaderView.m
//  LYMallApp
//
//  Created by gds on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXCollegeSectionHeaderView.h"
#import "LXCollegeListVC.h"

@implementation LXCollegeSectionHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.moreBtn.imagePosition = QMUIButtonImagePositionRight;
    self.moreBtn.spacingBetweenImageAndTitle = 5;
    
      [self.moreBtn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
        
   
}

- (void)pushVC{
    [self.viewController.navigationController pushViewController:[LXCollegeListVC new] animated:YES];
}
@end
