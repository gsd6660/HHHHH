//
//  TeamHeadView.m
//  LYMallApp
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "TeamHeadView.h"
#import "AddTeamVC.h"

@interface TeamHeadView()

@end

@implementation TeamHeadView


- (void)drawRect:(CGRect)rect {
    
    [self setShadowsView:self.view1];
    [self setShadowsView:self.view2];
    [self setShadowsView:self.view3];
    [self setShadowsView:self.view4];
    [self setShadowsView:self.view5];
    [self setShadowsView:self.view6];
    self.addbutn.layer.qmui_maskedCorners = QMUILayerMinXMaxYCorner|QMUILayerMinXMinYCorner;
    self.addbutn.layer.cornerRadius = 14;
}

-(void)setShadowsView:(UIView *)view{
    view.layer.shadowColor = [UIColor colorWithRed:109/255.0 green:106/255.0 blue:106/255.0 alpha:0.11].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,1);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 5;
    view.layer.cornerRadius = 5;
}

-(void)getDataDic:(NSDictionary *)dic{
    self.label1.text = [NSString stringWithFormat:@"%@",dic[@"sum"]];
    self.label2.text = [NSString stringWithFormat:@"%@",dic[@"second_num"]];
    self.label3.text = [NSString stringWithFormat:@"%@",dic[@"third_num"]];
    self.label4.text = [NSString stringWithFormat:@"%@",dic[@"last_month"]];
    self.label5.text = [NSString stringWithFormat:@"%@",dic[@"this_month"]];
    self.label6.text = [NSString stringWithFormat:@"%@",dic[@"this_week"]];
}

- (IBAction)addbutn:(UIButton *)sender {
    AddTeamVC * vc = [[AddTeamVC alloc]init];
    vc.typeStr = sender.titleLabel.text;//0没有添加权限1可添加团队长2可添加团员
    
    [[[self viewController] navigationController] pushViewController:vc animated:YES];
}


@end
