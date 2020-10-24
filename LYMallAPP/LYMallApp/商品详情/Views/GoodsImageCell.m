//
//  GoodsImageCell.m
//  LYMallApp
//
//  Created by 科技 on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GoodsImageCell.h"
#import <WebKit/WebKit.h>

@interface GoodsImageCell()


@end

@implementation GoodsImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    [self.wkwebView loadRequest:[NSURLRequest requestWithURL:url]];
    
   
}
-(void)setContentHtml:(NSString *)contentHtml
{
    _contentHtml=contentHtml;
    
    [self.wkwebView loadHTMLString:contentHtml baseURL:nil];
    
   
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //获取网页正文全文高，刷新cell
    [self.wkwebView evaluateJavaScript:@"document.documentElement.scrollHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
       CGFloat height = [result doubleValue];
       self.wkwebView.height = height;
       //通知cell更改约束
        [self refreshWebViewCell];

     }];
    
}

-(void)refreshWebViewCell{
    [self.tabView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:7]] withRowAnimation:UITableViewRowAnimationNone];//刷新制定位置Cell
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
