//
//  LXTaskDetalViewController.m
//  LYMallApp
//
//  Created by gds on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXTaskDetalViewController.h"
#import <WebKit/WebKit.h>


@interface LXTaskDetalViewController ()<WKNavigationDelegate>

@property(nonatomic, strong) UIProgressView *progressView;
@property(nonatomic, strong) WKWebView *wkWebView;

@property(nonatomic, strong) UILabel * rightLabel;



@property(nonatomic, strong) UITextView * contentView;

@end

@implementation LXTaskDetalViewController
 




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
    self.title = @"任务详情";

    if (([self.content hasPrefix:@"http:"] || [self.content hasPrefix:@"https:"])) {
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.content]]];
    }else {
        NSString *headerString = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>",SCREEN_WIDTH-20];
        [self.wkWebView loadHTMLString:[headerString stringByAppendingString:self.content?:@""] baseURL:[NSURL URLWithString:self.baseURL]];
    }
    [self.view addSubview:self.wkWebView];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:self.progressView];
  

//    self.contentView = [[UITextView alloc]init];
//    [self.view addSubview:self.contentView];
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self.view);
//    }];
//
////    NSMutableAttributedString * text = [[NSMutableAttributedString alloc]initWithString:self.content ];
//    NSAttributedString * text = [[NSAttributedString alloc]initWithData:[self.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//
//
//    self.contentView.attributedText = text;
    
    
    self.rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.rightLabel.textColor = UIColor.whiteColor;
    self.rightLabel.font = [UIFont systemFontOfSize:15];
    self.rightLabel.text = @"15S";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightLabel];
   
    __block NSInteger second = 15;
    //(1)
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //(2)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //(3)
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //(4)
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
                self.rightLabel.hidden = YES;
                //(6)
//                [QMUITips showSucceed:@"完成任务" inView:self.view];
//                [self taskWC];
                dispatch_cancel(timer);
            } else {
                self.rightLabel.text = [NSString stringWithFormat:@"%ldS",second];
                second--;
            }
        });
    });
    //(5)
    dispatch_resume(timer);
    [self createBack];
}


- (void)createBack{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"jft_icon_backoff"] forState:0];
    backBtn.frame = CGRectMake(10, StatusBarHeight, 30, 30);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}

- (void)backClick{
    
    UIAlertController * al = [UIAlertController alertControllerWithTitle:@"提示" message:@"任务还未完成，是否确认退出?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * leftAction = [UIAlertAction actionWithTitle:@"继续任务" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * rightAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [al addAction:leftAction];
    [al addAction:rightAction];
    [self presentViewController:al animated:YES completion:nil];

    
}

- (void)taskWC{
    [NetWorkConnection postURL:@"api/task.task/finish" param:@{@"log_id":self.orderID} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            [QMUITips showSucceed:@"完成任务" inView:self.view];
        }else{
            [QMUITips showError:responseMessage inView:self.view];
        }
    } fail:^(NSError *error) {
        
    }];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
