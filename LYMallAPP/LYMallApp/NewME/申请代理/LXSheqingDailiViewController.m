//
//  LXSheqingDailiViewController.m
//  LYMallApp
//
//  Created by guxiang on 2020/11/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXSheqingDailiViewController.h"
#import <WebKit/WebKit.h>
#import "CommitAppleyDataVC.h"

@interface LXSheqingDailiViewController ()<WKNavigationDelegate>

@property(nonatomic, strong) UIProgressView *progressView;
@property(nonatomic, strong) WKWebView *wkWebView;

@end

@implementation LXSheqingDailiViewController

- (void)dealloc {
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (instancetype)init {
    if (self = [super init]) {
        self.progressTintColor = [UIColor redColor];
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (([self.content hasPrefix:@"http:"] || [self.content hasPrefix:@"https:"])) {
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.content]]];
    }else {
        NSString *headerString = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>",SCREEN_WIDTH-20];
        [self.wkWebView loadHTMLString:[headerString stringByAppendingString:self.content?:@""] baseURL:[NSURL URLWithString:self.baseURL]];
    }
    [self.view addSubview:self.wkWebView];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:self.progressView];
    
    [self crateBtn];
 }


- (void)crateBtn{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = UIColorBlue;
    [btn setTitle:@"申请区/县级代理" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, ScreenHeight - 60, ScreenWidth - 40, 50);
    YBDViewBorderRadius(btn, 25);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(popClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)popClick{
    CommitAppleyDataVC * vc = [CommitAppleyDataVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)setContent:(NSString *)content {
    _content = content;
    
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    _progressTintColor = progressTintColor;
    _progressView.progressTintColor = progressTintColor;
}

- (void)navigationPopOnBackButton {
    if (_wkWebView.canGoBack) {
        [_wkWebView goBack];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


//#if __IPHONE_8_0

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;

            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

// WKNavigationDelegate 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{

    //开始加载网页时展示出progressView
    self.progressView.progress = 0.f;
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
//    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
//    //防止progressView被网页挡住
//    [self.view bringSubviewToFront:self.progressView];
}

// WKNavigationDelegate 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    //navigationAction.request.URL.host
    NSLog(@"WKwebView ... didCommitNavigation ..");
}
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
////    NSURL *requestURL = navigationAction.request.URL;
////
////    if ([self validateRequestURL:requestURL]) {//允许跳转
////        decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
////    } else {
////        decisionHandler(WKNavigationActionPolicyCancel);//不允许跳转
////    }
//}

// WKNavigationDelegate 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    // 禁止放大缩小
    NSString *injectionJSString = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
    
    //计算出webView滚动视图滚动的高度
//    [webView evaluateJavaScript:@"document.body.scrollWidth"completionHandler:^(id _Nullable result,NSError * _Nullable error){
//
//        CGFloat ratio =  CGRectGetWidth(self.wkWebView.frame) / [result floatValue];
//
//        [webView evaluateJavaScript:@"document.body.scrollHeight"completionHandler:^(id _Nullable result,NSError * _Nullable error){
//
//            NSLog(@"scrollHeight计算高度：%.2f",[result floatValue]*ratio);
//            CGFloat newHeight = [result floatValue]*ratio;
//
//            //[self resetWebViewFrameWithHeight:newHeight];
//
//        }];
//
//    }];
    
}

// WKNavigationDelegate 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    
}

#pragma mark - getter

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
        _progressView.progressTintColor = self.progressTintColor;
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.hidden = YES;
    }
    return _progressView;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:wkWebConfig];
        _wkWebView.backgroundColor = UIColor.whiteColor;
        _wkWebView.navigationDelegate = self;
        _wkWebView.opaque = YES;
    }
    return _wkWebView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
