//
//  HMCloudCorePlayer.h
//  HMCloudCore
//
//  Created by Apple on 2018/5/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HMCloudCoreMarco.h"
#import "HMCCPayloadData.h"
#import "HMCloudCorePlayerViewController.h"

typedef NS_ENUM(NSInteger, CloudCorePlayerNetStatus) {
    NetStatusUnknown          = -1,
    NetStatusNotReachable     = 0,
    NetStatusReachableViaWWAN = 1,
    NetStatusReachableViaWiFi = 2,
};

typedef NS_ENUM(NSInteger, CloudCorePlayerStatus) {
    PlayerStatusNone            = 0x0,
    PlayerStatusPreparing       = 0x1,
    PlayerStatusPrepared        = PlayerStatusPreparing<<1,
    PlayerStatusStarted         = PlayerStatusPrepared<<1,
    PlayerStatusPlaying         = PlayerStatusStarted<<1,
    PlayerStatusPaused          = PlayerStatusPlaying<<1,
    PlayerStatusStopped         = PlayerStatusPaused<<1,
    PlayerStatusCanResume       = (PlayerStatusStarted|PlayerStatusPlaying),
};

@interface HMCloudCorePlayer : NSObject

const extern NSString *CloudGameOptionKeyId;            //ganmeId: 游戏ID
const extern NSString *CloudGameOptionKeyOrientation;   //gameOrientation:游戏横竖屏 0-横屏 1-竖屏
const extern NSString *CloudGameOptionKeyUserId;        //userId:用户ID
const extern NSString *CloudGameOptionKeyUserToken;     //userToken:用户Token
const extern NSString *CloudGameOptionKeyCToken;        //cToken:
const extern NSString *CloudGameOptionKeyExtraId;       //extraId:

+ (instancetype) sharedCloudPlayer;

@property (nonatomic, copy)             NSString *accessKeyId;      //开发者注册的appID
@property (nonatomic, copy)             NSString *channelId;        //渠道号
@property (nonatomic, strong)           NSDictionary *launchOptions;

@property (nonatomic, strong)           NSNumber *deviceId;         //全局唯一的did
@property (nonatomic, copy)             NSString *eventTransId;     //客户端事件流水号-上报使用
@property (nonatomic, copy)             NSString *clientTransId;    //客户端事件流水ID
@property (nonatomic, assign)           NSInteger clientTransSeq;   //客户端事件序号
@property (nonatomic, copy)             NSString *serverTimestamp;  //客户端事件记录的服务器时间戳
@property (nonatomic, copy)             NSString *countlyUrl;
@property (nonatomic, copy)             NSString *countlyAppkey;

@property (nonatomic, copy)             NSString *packageName;      //游戏包名
@property (nonatomic, copy)             NSString *userId;
@property (nonatomic, copy)             NSString *userToken;
@property (nonatomic, copy)             NSString *cToken;
@property (nonatomic, copy)             NSString *extraId;
@property (nonatomic, assign)           HMCloudCorePlayerOrientation orientation;

@property (nonatomic, copy)             NSString *cloudId;
@property (nonatomic, copy)             NSString *sign;

@property (nonatomic, assign)           int64_t stasticReportPostFailedCount;

@property (nonatomic, assign)           CloudCorePlayerStatus playerStatus;

/**
 向海马云端注册

 @param accessKeyID 接入商ID
 @param channelId 接入商渠道ID
 @param launchOptions AppLauchuOptions
 @return 是否正常进行注册，最终注册结果异步返回
 */
- (BOOL) registCloudPlayer:(NSString *)accessKeyID
                 channelId:(NSString *)channelId
                   options:(NSDictionary *)launchOptions;

/**
 准备游戏

 @param options 游戏参数
 @return 云游戏ViewController
 */
- (UIViewController *) prepare:(NSDictionary *)options;

- (BOOL) checkPlayerOptions;

- (void) playWithVideoUrl:(NSString *)videoUrl
                 audioUrl:(NSString *)audioUrl
                 inputUrl:(NSString *)inputUrl
         switchBRDuration:(int)switchBRDuration
           detectInterval:(int)detectInterval
  delayTimeSinceLastCheck:(int)delayTimeSinceLastCheck
         switBRFrozenTime:(int)switBRFrozenTime
       isReportDetailInfo:(int)isReportDetailInfo
      delaySampleInterval:(int)delaySampleInterval
           startDelayTime:(int)startDelayTime
                   hidden:(BOOL)hidden;

- (void) setPingPongParams:(NSInteger)interval
                 delayTime:(NSInteger)delayTime
            traceRouteTime:(NSInteger)traceRouteTime;

- (void) startStastics:(int)fpsInterval
          bandInterval:(int)bandInterval
            frameCount:(int)frameCount
        decodeInterval:(int)decodeInterval;

/**
 暂停游戏
 */
- (void) pause;

- (BOOL) resume;

/**
 停止游戏
 */
- (void) stop;
/**
 停止游戏，退出游戏界面

 @param animated 和presentViewController 的 animated 值一致
 */
- (void) stopAndDismiss:(BOOL)animated;

- (void) showPlayer;

- (void) connectWebSocket:(NSString *)url;
- (BOOL) reconnectWebSocket;
- (void) disconnectWebSocket;

/**
 获取视频帧延迟

 @return 视频延迟，单位ms
 */
- (NSInteger) getVideoLatency;

/**
 设置背景图
 */
- (void) setBackgroundImage:(UIImage *)bgImage;

/**
 发送消息

 @param message 消息内容
 */
- (void) sendMessage:(NSString *)message;
- (void) sendKeycode:(NSInteger)keycode;

- (void) addSubView:(UIView *)view;

- (void) centerSubView:(UIView *)view style:(HMCloudCorePlayerSubViewCenterStyle)style;

/**
 开始网络状态监控

 @param block 回调通知
 */
- (void) startNetMonitor:(void (^)(CloudCorePlayerNetStatus status))block;

/**
 停止网络状态监控
 */
- (void) stopNetMonitor;

@end

typedef NS_ENUM (NSInteger, CloudPlayerStopReason) {
    CloudPlayerStopReasonInternalError = -1,   //未知内部错误
    CloudPlayerStopReasonNormal,               //正常结束
    CloudPlayerStopReasonTimeout,              //游戏时间到
    CloudPlayerStopReasonNoInputTimeout,       //无操作超时被踢
    CloudPlayerStopReasonInstanceError,        //实例出错
    CloudPlayerStopReasonQueueForbidden,        //排队人数过多，禁止排队
    CloudPlayerStopReasonCrashed,               //实例崩溃
    CloudPlayerStopReasonMaintance,             //维护中
    CloudPlayerStopReasonMultiInstance,         //多开
    CloudPlayerStopReasonTokenExpired,          //token失效
    CloudPlayerStopReasonLowSpeed,              //低于服务下限
    CloudPlayerStopReasonUrlTimeout,            //获取流地址超时
};

@interface HMCloudCorePlayerStopInfo : NSObject

@property (nonatomic, assign) CloudPlayerStopReason reason;
@property (nonatomic, copy)   NSString              *errorCode;
@property (nonatomic, copy)   NSString              *errorMsg;
@property (nonatomic, strong) NSArray               *queues;

+ (instancetype) stopInfo:(CloudPlayerStopReason)reason errorCode:(NSString *)errorCode errorMsg:(NSString *)errorMsg;
+ (instancetype) stopInfo:(CloudPlayerStopReason)reason queues:(NSArray *)queues errorCode:(NSString *)errorCode errorMsg:(NSString *)errorMsg;

@end

@protocol HMCloudCorePlayerProtocol <NSObject>

- (void) saasWebSockectStartConnect;
- (void) saasWebSocketDidConnected;
- (void) saasWebSocketDisconnected:(NSError *)error;

- (void) streamUrlGot:(HMCCPayloadData *)data;

- (void) queueConfirmTip:(HMCCPayloadData *)data;
- (void) queueStatesUpdate:(HMCCPayloadData *)data;
- (void) queueEntering;
- (void) instancePrepared;

- (void) playerTimeout:(HMCCPayloadData *)data;

- (void) messageReceived:(NSString *)msg;
- (void) recordWSMessage:(NSString *)msg;

- (void) maintanceWillStart:(HMCCPayloadData *)data;
- (void) maintanceDone;
- (void) maintanceForbidPlay:(HMCCPayloadData *)data;
- (void) maintanceInProgress:(HMCCPayloadData *)data;

- (void) playingTimeNotification:(HMCCPayloadData *)data;
- (void) playingTimeUpdated:(HMCCPayloadData *)data;
- (void) playingTimeShowToast:(HMCCPayloadData *)data;

- (void) cloudPlayerStopped:(HMCloudCorePlayerStopInfo *)info;

@end


