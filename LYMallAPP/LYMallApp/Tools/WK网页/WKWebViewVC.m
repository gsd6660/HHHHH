
//
//  WKWebViewVC.m
//  ZYTOBJT
//
//  Created by Mac on 2019/3/25.
//  Copyright © 2019年 Mac. All rights reserved.
//
#if NS_BLOCKS_AVAILABLE
typedef void(^ReturnBlock)(BOOL isOpen);
#endif
#import "WKWebViewVC.h"
#import <WebKit/WebKit.h>
#import <UShareUI/UShareUI.h>
@interface WKWebViewVC ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,CLLocationManagerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) WKWebView *wkWebview;
@property (strong, nonatomic) NSString *payTypeStr;
@property (strong, nonatomic) NSString *aplipayStr;
@property (strong, nonatomic) NSString *functionNameStr;
@property(nonatomic,strong) UIImagePickerController *imagePicker; //声明全局的UIImagePickerController
@property (strong, nonatomic)UIActivityIndicatorView *testActivityIndicator;

@end

@implementation WKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.wkWebview];
    if (@available(iOS 11.0, *)) {
        self.wkWebview.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self creatActivetyView];
    if (self.htmlString.length > 0) {
        [self.wkWebview loadHTMLString:self.htmlString baseURL:nil];
    }else{
        [self LoadRequest];
    }
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


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.wkWebview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];

}


- (void)LoadRequest{
    //    [self.view makeToastActivity:CSToastPositionCenter];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:50];
    [_wkWebview loadRequest:request];
}




#pragma mark - WKScriptMessageHandler   JS交互

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{

    
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






#pragma mark --- wk
- (WKWebView *)wkWebview
{
    if (_wkWebview == nil)
    {
       WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
            WKPreferences * preferences = [[WKPreferences alloc]init];
            preferences.javaScriptCanOpenWindowsAutomatically = true;

       NSString*jScript =@"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
       WKUserScript * wkUscript = [[WKUserScript alloc]initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
           WKUserContentController *ucontroller =[[WKUserContentController alloc]init];
       [ucontroller addUserScript:wkUscript];
       configuration.userContentController = ucontroller;
       configuration.preferences = preferences;

        _wkWebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight - SafeAreaTopHeight) configuration:configuration];
       [self.view addSubview:_wkWebview];
        [_wkWebview.configuration.userContentController addScriptMessageHandler:self name:@"share"];//分享功能
        _wkWebview.UIDelegate = self;
        _wkWebview.navigationDelegate = self;
      
    }
    return _wkWebview;
}


#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //网页title
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.wkWebview) {
            self.title = self.wkWebview.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}






@end
