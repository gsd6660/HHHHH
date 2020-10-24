//
//  ProductDetailsThreeCell.h
//  ZSWYAPP
//
//  Created by Mac on 2019/4/29.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef void(^webHeightChangedCallback)(CGFloat h);
@class ProductDetailsModel;
NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailsThreeCell : UITableViewCell
@property(nonatomic,strong)ProductDetailsModel * model;
@property(nonatomic,copy)webHeightChangedCallback block;

@property(nonatomic,strong)WKWebView *webView;

@property(nonatomic,strong)NSString *htmlStr;


@end

NS_ASSUME_NONNULL_END
