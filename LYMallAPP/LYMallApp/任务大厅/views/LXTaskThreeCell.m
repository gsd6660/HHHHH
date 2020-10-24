//
//  LXTaskThreeCell.m
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXTaskThreeCell.h"
#import "LXTaskListViewController.h"
@implementation LXTaskThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    YBDViewBorderRadius(self.bgView, 10);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    YBDViewBorderRadius(self.lowBtn, 7.5);
    YBDViewBorderRadius(self.centerBtn, 7.5);
    YBDViewBorderRadius(self.heightBtn, 7.5);

    // Initialization code
}

- (IBAction)lowClick:(id)sender {
    
    LXTaskListViewController  * vc = [[LXTaskListViewController alloc]init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)centerClick:(id)sender {
    
    LXTaskListViewController  * vc = [[LXTaskListViewController alloc]init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}


- (IBAction)heightClick:(id)sender {
    
    LXTaskListViewController  * vc = [[LXTaskListViewController alloc]init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
