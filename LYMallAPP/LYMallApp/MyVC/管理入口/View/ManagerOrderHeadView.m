
//
//  ManagerOrderHeadView.m
//  LYMallApp
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ManagerOrderHeadView.h"

@implementation ManagerOrderHeadView


- (void)drawRect:(CGRect)rect {
    
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

- (IBAction)finishButn:(UIButton *)sender {
    self.centerLineView.hidden = YES;
    self.rightLineView.hidden = YES;
    self.leftLineView.hidden = NO;
    if (self.block) {
        self.block(1);
    }
}

- (IBAction)noFinishButn:(UIButton *)sender {
    self.leftLineView.hidden = YES;
    self.rightLineView.hidden = YES;
    self.centerLineView.hidden = NO;
    if (self.block) {
        self.block(2);
    }
}

- (IBAction)afterSaleButn:(UIButton *)sender {
    self.centerLineView.hidden = YES;
    self.leftLineView.hidden = YES;
    self.rightLineView.hidden = NO;
    if (self.block) {
        self.block(3);
    }

}

-(void)getDataDic:(NSDictionary *)dic{
    self.Label1.text = [NSString stringWithFormat:@"%@",dic[@"ok_num"]];
    self.label2.text = [NSString stringWithFormat:@"%@",dic[@"not_num"]];
    self.label3.text = [NSString stringWithFormat:@"%@",dic[@"refund_num"]];
    self.label4.text = [NSString stringWithFormat:@"%@",dic[@"last_month"]];
    self.label5.text = [NSString stringWithFormat:@"%@",dic[@"this_month"]];
    self.label6.text = [NSString stringWithFormat:@"%@",dic[@"this_week"]];
}


@end
