//
//  NetWorkConnection.m
//  SunCard
//
//  Created by aa on 2016/11/8.
//  Copyright © cc. All rights reserved.
//

#import "NetWorkConnection.h"
#import <AFNetworking.h>
#import "LoginRegisterVC.h"
@implementation NetWorkConnection

#pragma mark - 创建请求者
+(AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    
    
    //最大请求并发任务数
    manager.operationQueue.maxConcurrentOperationCount = 5;
    
    // 请求格式
    // AFHTTPRequestSerializer      二进制格式
    // AFJSONRequestSerializer      JSON
    // AFPropertyListRequestSerializer  PList(是一种特殊的XML,解析起来相对容易)
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    // 超时时间
    manager.requestSerializer.timeoutInterval = 30.0f;
    // 设置请求头
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]; //登录时候返回token
        NSLog(@"token====%@",token);
    
    if (token.length ==0) {
        token = @"";
    }
//
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"PHPSESSID= %@",session] forHTTPHeaderField:@"cookie"];
     [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",token] forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回格式 JSON
//    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    // 设置接收的Content-Type

    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json",@"application/x-www-form-urlencoded", nil];
    
    
    // 返回格式
    // AFHTTPResponseSerializer      二进制格式
    // AFJSONResponseSerializer      JSON
    // AFXMLParserResponseSerializer   XML,只能返回XMLParser,还需要自己通过代理方法解析
    // AFXMLDocumentResponseSerializer (Mac OS X)
    // AFPropertyListResponseSerializer  PList
    // AFImageResponseSerializer     Image
    // AFCompoundResponseSerializer    组合
//
//    //设置返回C的ontent-type
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];;
   

    
    return manager;
}

+ (void)getNativeURL:(NSString *)urlString param:(NSDictionary *)param success:(SuccessBlock)success fail:(AFNErrorBlock)fail{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

    [NetWorkConnection reachabilityStatus:^(id responseObject) {
        if ([responseObject isEqualToString:@"无可用网络"]) {
            return ;
            
        }
    }];
    // 创建请求类
    AFHTTPSessionManager *manager = [self manager];
    //    NSString *path = [NSString stringWithFormat:@"%@%@",BaseUrl,URLString];
    
    [manager GET:urlString parameters:param headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
               if(responseObject){
                   success(responseObject,YES);
                   
                  
                   
               } else {
                   success(@{@"msg":@"暂无数据"}, NO);
               }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}

+ (void)getURL:(NSString *)URLString param:(NSDictionary *)param Success:(SuccessBlock)success fail:(AFNErrorBlock)fail{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    [keyWindow makeToastActivity:CSToastPositionCenter];
    [NetWorkConnection reachabilityStatus:^(id responseObject) {
        if ([responseObject isEqualToString:@"无可用网络"]) {
            [QMUITips showInfo:@"请检查网络是否连接正常"];
            
            return ;
            
        }
    }];
    NSString *path = [NSString stringWithFormat:@"%@%@",BaseUrl,URLString];

    // 创建请求类
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //最大请求并发任务数
    manager.operationQueue.maxConcurrentOperationCount = 5;
    
    // 请求格式
    // AFHTTPRequestSerializer      二进制格式
    // AFJSONRequestSerializer      JSON
    // AFPropertyListRequestSerializer  PList(是一种特殊的XML,解析起来相对容易)
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传普通格式
    // 超时时间
    manager.requestSerializer.timeoutInterval = 30.0f;
    // 设置请求头
//    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]; //登录时候返回token
//    NSLog(@"token====%@",token);
//
//    if (token.length ==0) {
//        token = @"";
//    }
//    //    [manager.requestSerializer setValue:[NSString stringWithFormat:@"PHPSESSID= %@",session] forHTTPHeaderField:@"cookie"];
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",token] forHTTPHeaderField:@"loginkey"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回格式 JSON
        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    // 设置接收的Content-Type
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json",@"application/x-www-form-urlencoded", nil];
//    NSString *path = [NSString stringWithFormat:@"%@%@",BaseUrl,URLString];
    
    [manager GET:path parameters:path headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         // 请求成功
                if(responseObject){
                    
        //            [keyWindow hideToastActivity];

                    success(responseObject,YES);
                } else {
                    success(@{@"msg":@"暂无数据"}, NO);
                }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          // 请求失败
                fail(error);
        //        [keyWindow hideToastActivity];
                if([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {        // server error
                    id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];        // response中包含服务端返回的内容
                    
                } else if ([error.domain isEqualToString:NSCocoaErrorDomain]) {        // server throw exception
                    
                } else if ([error.domain isEqualToString:NSURLErrorDomain]) {        // network error
                    
        //            [keyWindow makeToast:@"和服务器失去联系了" duration:1 position:CSToastPositionCenter];
                }
    }];
  
}

+ (void)postURL:(NSString *)urlString param:(NSDictionary *)param success:(SuccessBlock)success fail:(AFNErrorBlock)fail
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

  
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [NetWorkConnection reachabilityStatus:^(id responseObject) {
        if ([responseObject isEqualToString:@"无可用网络"]) {

            [user setObject:@"0" forKey:@"networkking"];
            [user synchronize];
            return;
        }else{
           
            
        }
    }];

    // 创建请求类
    AFHTTPSessionManager *manager = [self manager];

    NSString *path = [NSString stringWithFormat:@"%@%@",BaseUrl,urlString];

    NSLog(@"==========%@",[param mj_JSONString]);
    
    [manager POST:path parameters:param headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         // 请求成功
        if(responseObject){
            
            NSInteger  code = [responseObject[@"code"] integerValue];
            if (code == 1) {
                success(responseObject,YES);
            }else if (code == -1) {
                [UIApplication sharedApplication].delegate.window.rootViewController = [[LoginRegisterVC alloc]init];
                
                success(responseObject,YES);
            }else{
                success(responseObject, NO);
            }
        }
           

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         // 请求失败
                fail(error);
                　if([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {        // server error
                    id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];        // response中包含服务端返回的内容

                } else if ([error.domain isEqualToString:NSCocoaErrorDomain]) {        // server throw exception
        //            [keyWindow makeToast:@"服务器异常" duration:1 position:CSToastPositionCenter];

                } else if ([error.domain isEqualToString:NSURLErrorDomain]) {        // network error
                    
        //            [keyWindow makeToast:@"和服务器失去联系了" duration:1 position:CSToastPositionCenter];
                }

    }];
    
    

}

// 上传
// 上传
+ (void)uploadPost:(NSString *)urlString parameters:(id)parameters name:(NSString *)name UploadImage:(UIImage *)image success:(SuccessBlock)successs failure:(AFNErrorBlock)fail{
    UIImage * headImage = image;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //最大请求并发任务数
    manager.operationQueue.maxConcurrentOperationCount = 5;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    // 请求格式
    // AFHTTPRequestSerializer      二进制格式
    // AFJSONRequestSerializer      JSON
    // AFPropertyListRequestSerializer  PList(是一种特殊的XML,解析起来相对容易)
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传普通格式
    // 超时时间
    manager.requestSerializer.timeoutInterval = 30.0f;
    // 设置请求头
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]; //登录时候返回token
    NSLog(@"token====%@",token);
    
    if (token.length ==0) {
        token = @"";
    }
    
 [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",token] forHTTPHeaderField:@"loginkey"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回格式 JSON

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
 
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];

    manager.requestSerializer.timeoutInterval = 20;
    
    [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,urlString] parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        NSData *imageData = UIImageJPEGRepresentation(headImage, 0.5);
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
        /*
         *该方法的参数
         1. appendPartWithFileData：要上传的照片[二进制流]
         2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
         3. fileName：要保存在服务器上的文件名
         4. mimeType：上传的文件的类型
         */
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject){
            successs(responseObject,YES);
        } else {
            successs(@{@"msg":@"暂无数据"}, NO);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

// 网络监测
+ (void)reachabilityStatus:(void (^)(id responseObject))netStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {

            case AFNetworkReachabilityStatusUnknown:

                if (netStatus) {
                    netStatus(@"未知网络");
                }
                break;

            case AFNetworkReachabilityStatusNotReachable:

                if (netStatus) {
                    netStatus(@"无可用网络");
                    
                    
                }
                break;

            case AFNetworkReachabilityStatusReachableViaWiFi:

                if (netStatus) {
                    netStatus(@"当前Wifi网络");

                }
                break;

            case AFNetworkReachabilityStatusReachableViaWWAN:

                if (netStatus) {
                    netStatus(@"正在使用蜂窝网络");

                }
                break;

            default:

                break;

        }

    }];
    [manager startMonitoring];
}


@end
