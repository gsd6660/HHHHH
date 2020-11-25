//
//  InviteFriendsVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "InviteFriendsVC.h"
#import "DetailView.h"
@interface InviteFriendsVC ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,CLLocationManagerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView * codeImage;
}
@property (weak, nonatomic) IBOutlet DetailView *wk;
@property (strong, nonatomic)UIImage *shareImage;
@property (strong, nonatomic)UIActivityIndicatorView *testActivityIndicator;
@end

@implementation InviteFriendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请好友";
   NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]; //登录时候返回token
       NSLog(@"token====%@",token);
   
   if (token.length ==0) {
       token = @"";
   }
    [self creatActivetyView];

    self.wk.scrollView.bounces = NO;
    self.wk.UIDelegate = self;
    self.wk.navigationDelegate = self;
    NSString * url = [NSString stringWithFormat:@"%@wap/invite/index&Authorization=%@",BaseUrl,token];
    NSLog(@"%@",url);
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.wk loadRequest:request];
    [self.wk.configuration.userContentController addScriptMessageHandler:self name:@"share"];//扫码功能
 
}
 
-(void)creatActivetyView{
    UIActivityIndicatorView *testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
     testActivityIndicator.center = CGPointMake(100.0f, 100.0f);//只能设置中心，不能设置大小
    testActivityIndicator.frame = CGRectMake(100, 100, 100, 100);//不建议这样设置，因为UIActivityIndicatorView是不能改变大小只能改变位置，这样设置得到的结果是控件的中心在（100，100）上，而不是和其他控件的frame一样左上角在（100， 100）长为100，宽为100.
    testActivityIndicator.color = [UIColor redColor];
    self.testActivityIndicator = testActivityIndicator;
    [testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
    self.testActivityIndicator.center = self.view.center;
    [self.view addSubview:testActivityIndicator];

}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    [shareObject setShareImage:self.shareImage];

    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

#pragma mark - WKScriptMessageHandler   JS交互

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"share"]) {
        self.shareImage = [self makeImageWithView:self.wk];
        //显示分享面板
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:platformType];
        }];
    }
    
}
- (UIImage *)makeImageWithView:(UIView *)view{
    CGSize size = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



//WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"是否允许这个导航");
    [self.testActivityIndicator startAnimating]; // 开始旋转
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"知道返回内容之后，是否允许加载，允许加载");
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"开始加载");
//    [self.testActivityIndicator stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


#pragma mark 网页加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"网页加载完成");
    [self.testActivityIndicator stopAnimating]; // 结束旋转

    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'" completionHandler:nil];
      [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"网页由于某些原因加载失败1");
    
    
    [self.testActivityIndicator stopAnimating]; // 结束旋转

    
    
    
    
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"网页由于某些原因加载失败2");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [self.testActivityIndicator stopAnimating]; // 结束旋转

}








@end
