//
//  PaySuccessVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/24.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "PaySuccessVC.h"
#import "OrderDetailVC.h"
@interface PaySuccessVC ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation PaySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付成功";
    [self.lookButn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        OrderDetailVC * vc = [[OrderDetailVC alloc]init];
        vc.order_id = self.order_id;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.lookButn setBackgroundColor:kUIColorFromRGB(0x3ACD7B)];
    [self.backHomeButn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem qmui_backItemWithTarget:self action:@selector(backVC:)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           LOTAnimationView *animation = [LOTAnimationView animationNamed:@"17775-success"];
           animation.frame = CGRectMake(0, 0, 75, 75);
           animation.loopAnimation = NO;
           animation.contentMode  = UIViewContentModeScaleAspectFit;
           [animation play];
           [animation playWithCompletion:^(BOOL animationFinished) {
               // Do Something
           }];
           [self.bgView addSubview:animation];
       });
    
}


-(void)backVC:(UIBarButtonItem *)butn{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
