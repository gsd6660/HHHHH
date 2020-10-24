//
//  WebSocketManager.h
//  TSYCAPP
//
//  Created by Mac on 2019/9/7.
//  Copyright © 2019 Mac. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <SRWebSocket.h>

typedef NS_ENUM(NSUInteger,WebSocketConnectType){
    WebSocketDefault = 0,   //初始状态,未连接,不需要重新连接
    WebSocketConnect,       //已连接
    WebSocketDisconnect    //连接后断开,需要重新连接
};
@class WebSocketManager;
@protocol WebSocketManagerDelegate <NSObject>

- (void)webSocketManagerDidReceiveMessageWithString:(NSString *_Nonnull)string;
- (void)webSocketManagerDidOpen:(SRWebSocket*_Nonnull)webSocket;
@end

NS_ASSUME_NONNULL_BEGIN

@interface WebSocketManager : NSObject

@property (nonatomic, strong) SRWebSocket *webSocket;
@property(nonatomic,weak)  id<WebSocketManagerDelegate > delegate;
@property (nonatomic, assign)   BOOL isConnect;  //是否连接
@property (nonatomic, assign)   WebSocketConnectType connectType;

+(instancetype)shared;
- (void)connectServer;//建立长连接
- (void)reConnectServer;//重新连接
- (void)RMWebSocketClose;//关闭长连接
- (void)sendDataToServer:(NSString *)data;//发送数据给服务器
@end

NS_ASSUME_NONNULL_END
