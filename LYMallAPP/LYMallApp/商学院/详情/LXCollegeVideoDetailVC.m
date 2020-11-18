//
//  LXCollegeVideoDetailVC.m
//  LYMallApp
//
//  Created by guxiang on 2020/11/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXCollegeVideoDetailVC.h"
#import <ZFPlayer.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <WebKit/WebKit.h>
@interface LXCollegeVideoDetailVC ()<WKNavigationDelegate>

@property(nonatomic, strong) UIProgressView *progressView;
@property(nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIButton *playBtn;

@end

@implementation LXCollegeVideoDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.playBtn];
    
    if (([self.content hasPrefix:@"http:"] || [self.content hasPrefix:@"https:"])) {
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.content]]];
    }else {
        NSString *headerString = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>",SCREEN_WIDTH-20];
        [self.wkWebView loadHTMLString:[headerString stringByAppendingString:self.content?:@""] baseURL:[NSURL URLWithString:self.baseURL]];
    }
    [self.view addSubview:self.wkWebView];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:self.progressView];
    
    [self setupPlayer];
}

- (void)setupPlayer {
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
//    ZFIJKPlayerManager *playerManager = [[ZFIJKPlayerManager alloc] init];

    playerManager.shouldAutoPlay = YES;
    
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
//    self.player.resumePlayRecord = YES;
    
    @zf_weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
//        kAPPDelegate.allowOrentitaionRotation = isFullScreen;
    };
    
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @zf_strongify(self)
        if (!self.player.isLastAssetURL) {
            [self.player playTheNext];
            NSString *title = [NSString stringWithFormat:@"视频标题%zd",self.player.currentPlayIndex];
            [self.controlView showTitle:title coverURLString:@"" fullScreenMode:ZFFullScreenModeLandscape];
        } else {
            [self.player stop];
        }
    };
    
    self.player.assetURLs = @[[NSURL URLWithString:self.playUrl]];
    [self.player playTheIndex:0];
//    [self.controlView showTitle:@"iPhone X" coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];

    
}

- (void)playClick:(UIButton *)sender {
    [self.player playTheIndex:0];
    [self.controlView showTitle:@"视频标题" coverURLString:@"" fullScreenMode:ZFFullScreenModeAutomatic];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        
        CGFloat x = 0;
        CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        CGFloat w = CGRectGetWidth(self.view.frame);
        CGFloat h = w*9/16;
        self.containerView.frame = CGRectMake(x, y, w, h);
        
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.prepareShowLoading = YES;
        _controlView.prepareShowControlView = NO;
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        [_containerView sd_setImageWithURL:[NSURL URLWithString:@""] completed:nil];
    }
    return _containerView;
}


- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
//        _playBtn.backgroundColor = UIColor.redColor;
        [_playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat w = 44;
        CGFloat h = w;
        CGFloat x = (CGRectGetWidth(self.containerView.frame)-w)/2;
        CGFloat y = (CGRectGetHeight(self.containerView.frame)-h)/2;
        self.playBtn.frame = CGRectMake(x, y, w, h);
        
    }
    return _playBtn;
}



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
        CGFloat w = CGRectGetWidth(self.view.frame);
        CGFloat h = w*9/16;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, h + NavigationBarHeight, ScreenWidth, ScreenHeight - h - NavigationBarHeight) configuration:wkWebConfig];
        _wkWebView.backgroundColor = UIColor.whiteColor;
        _wkWebView.navigationDelegate = self;
        _wkWebView.opaque = YES;
    }
    return _wkWebView;
}


@end
