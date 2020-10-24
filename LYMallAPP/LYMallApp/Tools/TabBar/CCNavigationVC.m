//
//  CCNavigationVC.m
//  LYMallApp
//
//  Created by Mac on 2020/3/10.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CCNavigationVC.h"

@interface CCNavigationVC ()<UIGestureRecognizerDelegate>

@end

@implementation CCNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navBar = self.navigationBar; //[UINavigationBar appearance];
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg"] forBarMetrics:UIBarMetricsDefault];
    //[navBar setShadowImage:[UIImage new]];
    navBar.backgroundColor = UIColorHex(0x188dfb);
    //设置title的字体颜色、字体大小
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    //设置导航栏的样式
    navBar.barStyle = UIStatusBarStyleDefault;
    //设置导航栏默认返回按钮颜色
    [navBar setTintColor:UIColor.whiteColor];
    //设置导航栏的毛玻璃效果，NO起点从（0，0）开始，YES起点从（0，64）开始
    navBar.translucent = NO;
}





/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
