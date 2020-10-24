//
//  GFCommonFun.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GFCommonFun.h"
#import "LoginRegisterVC.h"
@implementation GFCommonFun

+ (UIViewController *)rootViewController{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}
+ (BOOL)checkLogin {
   NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (![CheackNullOjb cc_isNullOrNilWithObject:token]) {
        return NO;
    }
    UIViewController* root = [GFCommonFun rootViewController];
    LoginRegisterVC *viewController = [[LoginRegisterVC alloc] init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:viewController];
    nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [root presentViewController:nav animated:YES completion:^{
    }];
    return YES;
}
@end
