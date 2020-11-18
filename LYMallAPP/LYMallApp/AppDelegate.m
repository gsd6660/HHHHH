//
//  AppDelegate.m
//  LYMallApp
//
//  Created by Mac on 2020/3/5.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewVC.h"
#import <UMShare/UMShare.h>
#import "LoginRegisterVC.h"

//#import "WxSdk.h"

#import "KSGuaidViewManager.h"
@interface AppDelegate ()<JPUSHRegisterDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//     KSGuaidManager.images = @[[UIImage imageNamed:@"guid01"],
//     [UIImage imageNamed:@"guid02"],
//     [UIImage imageNamed:@"guid03"]];
//     KSGuaidManager.shouldDismissWhenDragging = YES;
//     [KSGuaidManager begin];
    [WXApi registerApp:@"wx1c9765d7b1eaf378" universalLink:@"https://bqgvo7.jgmlink.cn"];

    [self createTabBarController];
    // U-Share 平台设置
  /*  [self confitUShareSettings];
    [self configUSharePlatforms];
    [self confitJpush];
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    [JPUSHService setupWithOption:launchOptions appKey:@"584bcffd38b694fbbc32c281"
                          channel:@"App Store"
                 apsForProduction:1
            advertisingIdentifier:nil];
    // Custom code
   */
    
    JMLinkConfig *config = [[JMLinkConfig alloc] init];
    config.appKey = @"8570b4786642bb33c699071f";
    [JMLinkService setupWithConfig:config];
//    [WxSdk registerApp];

    return YES;
}

-(void)confitJpush{
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
     JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
     entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
     if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
       // 可以添加自定义 categories
       // NSSet<UNNotificationCategory *> *categories for iOS10 or later
       // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
     }
     [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    
}


- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;

    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;

        //配置微信平台的Universal Links
    //微信和QQ完整版会校验合法的universalLink，不设置会在初始化平台失败
//    [UMSocialGlobal shareInstance].universalLinkDic = @{(UMSocialPlatformType_WechatSession):@"https://umplus-sdk-download.oss-cn-shanghai.aliyuncs.com/"};


}

- (void)configUSharePlatforms
{
    [UMConfigure initWithAppkey:@"5e8ec886167edd097c000096" channel:@"App Store"];

    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx1c9765d7b1eaf378" appSecret:@"ff5f0eb418f71ad14669582a24fad5c8" redirectURL:@"http://mobile.umeng.com/social"];
   
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];

    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];

}

- (void)createTabBarController {
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"token"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if ([CheackNullOjb cc_isNullOrNilWithObject:token]) {
        LoginRegisterVC * vc = [LoginRegisterVC new];
        self.window.rootViewController = vc;
    }else{
        TabBarViewVC *tabBarViewController = [[TabBarViewVC alloc] init];
        self.window.rootViewController = tabBarViewController;
        self.window.backgroundColor = [UIColor whiteColor];
    }
   
    [self.window makeKeyAndVisible];
}


#pragma mark 支付宝回调（APP支付回调）
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] integerValue] == 9000){
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"payResult" object:@"success"]];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:nil];
                [QMUITips showSucceed:@"支付成功"];
            }else if ([resultDic[@"resultStatus"] integerValue] == 6001){
                [QMUITips showInfo:@"用户取消支付"];
            }else if ([resultDic[@"resultStatus"] integerValue] == 6002){
                [QMUITips showInfo:@"网络连接出错"];
            }else if ([resultDic[@"resultStatus"] integerValue] == 4000){
                [QMUITips showInfo:@"订单支付失败"];
            }
        }];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}





#pragma mark - WXApiDelegate 微信SDK支付回调
- (void)onResp:(BaseResp *)resp {
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        if (resp.errCode == 0) {
            [QMUITips showSucceed:@"支付成功"];
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"payResult" object:@"success"]];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:nil];
        }else if (resp.errCode == -2) {
            [QMUITips showError:@"用户取消"];
        }else if (resp.errCode == -1) {
            [QMUITips showError:@"订单支付失败"];
        }
    }
    
    //
    if([resp isKindOfClass:[SendAuthResp class]]){
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if(aresp.errCode== 0 )
        {
            NSString *code = aresp.code;

            if ([aresp.state isEqualToString:@"band"]) {
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"weixinBand" object:nil userInfo:@{@"code":code}]];

            }else{
//                [self getWeiXinInfo:code];

            }
        }
    }
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
         // 其他如支付等SDK的回调
    }
    return result;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

  /// Required - 注册 DeviceToken
  [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
  if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    //从通知界面直接进入应用
  }else{
    //从通知设置界面进入应用
  }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
  // Required
  NSDictionary * userInfo = notification.request.content.userInfo;
  if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
  }
  completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
  // Required
  NSDictionary * userInfo = response.notification.request.content.userInfo;
  if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
  }
  completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

  // Required, iOS 7 Support
  [JPUSHService handleRemoteNotification:userInfo];
  completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

  // Required, For systems with less than or equal to iOS 6
  [JPUSHService handleRemoteNotification:userInfo];
}

@end
