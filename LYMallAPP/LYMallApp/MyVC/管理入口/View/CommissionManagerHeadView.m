//
//  CommissionManagerHeadView.m
//  LYMallApp
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CommissionManagerHeadView.h"
#import "WithdrawDepositVC.h"
@implementation CommissionManagerHeadView

- (void)drawRect:(CGRect)rect {
    self.tixainButn.layer.qmui_maskedCorners = QMUILayerMinXMaxYCorner|QMUILayerMinXMinYCorner;
    self.tixainButn.layer.cornerRadius = 14;
    [self setShadowsView:self.view1];
    [self setShadowsView:self.view2];
    [self setShadowsView:self.view3];
    [self setShadowsView:self.view4];
    [self setShadowsView:self.view5];
    [self setShadowsView:self.view6];
}

-(void)setShadowsView:(UIView *)view{
    view.layer.shadowColor = [UIColor colorWithRed:109/255.0 green:106/255.0 blue:106/255.0 alpha:0.11].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,1);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 5;
    view.layer.cornerRadius = 5;
}
-(void)getDataDic:(NSDictionary *)dic{
    self.label1.text = [NSString stringWithFormat:@"%@",dic[@"always_money"]];
    self.label2.text = [NSString stringWithFormat:@"%@",dic[@"not_money"]];
    self.label3.text = [NSString stringWithFormat:@"%@",dic[@"money"]];
    self.lable4.text = [NSString stringWithFormat:@"%@",dic[@"last_month"]];
    self.label5.text = [NSString stringWithFormat:@"%@",dic[@"this_month"]];
    self.label6.text = [NSString stringWithFormat:@"%@",dic[@"this_week"]];
    

}


- (IBAction)tixian:(UIButton *)sender {
    WithdrawDepositVC *vc = [[WithdrawDepositVC alloc]init];
    vc.urlStr = @"api/signed.withdraw/submit_info";
    vc.submitUrlStr = @"api/signed.withdraw/submit";
    
    [[[self viewController] navigationController] pushViewController:vc animated:YES];
    
    
}




@end
