//
//  ProductDetailsThreeCell.m
//  ZSWYAPP
//
//  Created by Mac on 2019/4/29.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "ProductDetailsThreeCell.h"




@interface ProductDetailsThreeCell()<WKNavigationDelegate>

@end

@implementation ProductDetailsThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *superView = self.contentView;
        superView.backgroundColor = [UIColor blueColor];

        WKWebView *webView = [[WKWebView alloc] initWithFrame:superView.bounds];
        webView.scrollView.scrollEnabled = NO;//禁用webView滑动
        webView.scrollView.userInteractionEnabled = YES;
        //自适应宽高，这句要加
        webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
         webView.navigationDelegate = self;
        _webView = webView;
        [superView addSubview:_webView];
        //监听webView.scrollView的contentSize属性

        [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        
       

        
    }
    return self;
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        __weak typeof(self) weakSelf = self;
        //执行js方法"document.body.offsetHeight" ，获取wkwebview内容高度
        [_webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            CGFloat contentHeight = [result floatValue];
            if (weakSelf.block) {
                weakSelf.block(contentHeight);
            }
        }];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
}



- (NSArray *)filterImage:(NSString *)html
{
    NSMutableArray *resultArray = [NSMutableArray array];

        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
        NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
        
        for (NSTextCheckingResult *item in result) {
            NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:0]];
            
            NSArray *tmpArray = nil;
            if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
                tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
            } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
                tmpArray = [imgHtml componentsSeparatedByString:@"src="];
            }
            
            if (tmpArray.count >= 2) {
                NSString *src = tmpArray[1];
                
                NSUInteger loc = [src rangeOfString:@"\""].location;
                if (loc != NSNotFound) {
                    src = [src substringToIndex:loc];
                    [resultArray addObject:src];
                }
            }
        }

    return resultArray;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)dealloc
{
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize"];

}



    
@end
