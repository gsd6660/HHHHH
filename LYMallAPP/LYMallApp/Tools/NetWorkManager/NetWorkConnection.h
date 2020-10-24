//
//  NetWorkConnection.h
//  SunCard
//
//  Created by cc on 2016/11/8.
//  Copyright © cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define kTimeOutInterval 8 // 请求超时的时间

typedef void (^SuccessBlock)(id responseObject, BOOL success); // 访问成功block
typedef void (^AFNErrorBlock)(NSError *error); // 访问失败block

@interface NetWorkConnection : NSObject
+ (void)getURL:(NSString *)URLString param:(NSDictionary *)param Success:(SuccessBlock)success fail:(AFNErrorBlock)fail;
+ (void)postURL:(NSString *)urlString param:(NSDictionary *)param success:(SuccessBlock)success fail:(AFNErrorBlock)fail;
+ (void)getNativeURL:(NSString *)urlString param:(NSDictionary *)param success:(SuccessBlock)success fail:(AFNErrorBlock)fail;

+ (void)uploadPost:(NSString *)urlString parameters:(id)parameters name:(NSString *)name UploadImage:(UIImage *)image success:(SuccessBlock)successs failure:(AFNErrorBlock)fail;

// 网络监测
+ (void)reachabilityStatus:(void (^)(id responseObject))netStatus;

@end
