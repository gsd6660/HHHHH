//
//  TabBarViewVC.m
//  LYMallApp
//
//  Created by Mac on 2020/3/10.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "TabBarViewVC.h"
#import "HomeVC.h"
#import "LXCollegeViewController.h"
#import "CartVC.h"
#import "LXMeViewController.h"
#import "LoginRegisterVC.h"
#import "LXVIPViewController.h"
//
#import "CCNavigationVC.h"
@interface TabBarViewVC ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatVC];
    self.delegate = self;
}

-(void)creatVC{

    HomeVC *vc1 = [[HomeVC alloc] init];
    vc1.hidesBottomBarWhenPushed = NO;
    CCNavigationVC *nav1 = [[CCNavigationVC alloc] initWithRootViewController:vc1];
//    nav1.navigationBar.tintColor = kUIColorFromRGB(0xcdcdcd);
//    QMUICMI.navBarTintColor = kUIColorFromRGB(0x333333);

    vc1.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"首页" image:[UIImageMake(@"jft_but_home_normal") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"home_select") tag:0];
    AddAccessibilityHint(vc1.tabBarItem, @"展示一系列对系统原生控件的拓展的能力");
    
    LXVIPViewController * vc5 = [[LXVIPViewController alloc]init];
    vc5.hidesBottomBarWhenPushed = NO;
    CCNavigationVC *nav5 = [[CCNavigationVC alloc] initWithRootViewController:vc5];
    nav5.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"VIP" image:[UIImageMake(@"jft_but_shoppingmall_normal") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"jft_but_shoppingmall") tag:0];
    AddAccessibilityHint(nav5.tabBarItem, @"展示一系列对系统原生控件的拓展的能力");
    
    
    LXCollegeViewController * vc2 = [[LXCollegeViewController alloc]init];
    vc2.hidesBottomBarWhenPushed = NO;
    CCNavigationVC *nav2 = [[CCNavigationVC alloc] initWithRootViewController:vc2];
    nav2.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"商学院" image:[UIImageMake(@"jft_but_shoppingmall_normal") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"jft_but_shoppingmall") tag:0];
    AddAccessibilityHint(nav2.tabBarItem, @"展示一系列对系统原生控件的拓展的能力");
    
  
    CartVC * vc3 = [[CartVC alloc]init];
    vc3.hidesBottomBarWhenPushed = NO;
    CCNavigationVC *nav3 = [[CCNavigationVC alloc] initWithRootViewController:vc3];
    nav3.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"购物车" image:[UIImageMake(@"jft_but_shoppingcart_normal") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"jft_but_shoppingcart") tag:0];
    AddAccessibilityHint(nav3.tabBarItem, @"展示一系列对系统原生控件的拓展的能力");
    
    
    
    LXMeViewController *vc4 = [[LXMeViewController alloc] init];
    vc4.hidesBottomBarWhenPushed = NO;
    CCNavigationVC *nav4 = [[CCNavigationVC alloc] initWithRootViewController:vc4];
    nav4.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"我的" image:[UIImageMake(@"jft_but_me_normal") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"jft_but_me") tag:1];
    AddAccessibilityHint(nav4.tabBarItem, @"展示 QMUI 自己的组件库");

    
    // window root controller
    self.viewControllers = @[nav1,nav3,nav2,nav4];
    
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = kUIColorFromRGB(0x3ACD7B);//改变选中字体颜色
//    if (@available(iOS 10.0, *)) {
//        self.tabBar.unselectedItemTintColor = kUIColorFromRGB(0x666666);
//    } else {
//        self.tabBar.barTintColor = kUIColorFromRGB(0xFC6465);
//    }
}



- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
     
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
//    if ([CheackNullOjb cc_isNullOrNilWithObject:token]) {
//        if ([viewController.tabBarItem.title isEqualToString:@"购物车"]||[viewController.tabBarItem.title isEqualToString:@"我的"]) {
//           
//            LoginRegisterVC * vc = [LoginRegisterVC new];
//            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
//            self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//            nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//            [self presentViewController:nav animated:YES completion:nil];
//            return NO;
//        }
//    }
    return YES;
    
}


@end
