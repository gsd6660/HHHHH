//
//  DetailView.m
//  LYMallApp
//
//  Created by Mac on 2020/4/2.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    CGRect frame = [[UIScreen mainScreen] bounds];

    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
        WKPreferences * preferences = [[WKPreferences alloc]init];
        preferences.javaScriptCanOpenWindowsAutomatically = true;

    NSString*jScript =@"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript * wkUscript = [[WKUserScript alloc]initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *ucontroller =[[WKUserContentController alloc]init];
    [ucontroller addUserScript:wkUscript];
    configuration.userContentController = ucontroller;
    configuration.preferences = preferences;
    self = [super initWithFrame:frame configuration:configuration];

    self.translatesAutoresizingMaskIntoConstraints = NO;

    return self;
}
@end
