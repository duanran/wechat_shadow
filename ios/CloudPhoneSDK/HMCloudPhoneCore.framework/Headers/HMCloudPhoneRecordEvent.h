//
//  HMCloudPhoneRecordEvent.h
//  HMCloudPhoneCore
//
//  Created by Apple on 2018/6/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HMCPEventType) {
    HMCEventStartPlay                   = 10012,    //开始启动云玩

    HMCEventGetConfigureStarted         = 12084,    //开始调用getConfig方法
    HMCEventGetConfigureSuccess         = 12080,    //调用getConfig方法成功
    HMCEventGetConfigureFailed          = 12081,    //调用getConfig方法失败

    HMCEventQueryRequestStarted         = 13002,    //开始调用getCloudPoneInfo方法
    HMCEventQueryRequestSuccess         = 13005,    //调用getCloudPoneInfo成功
    HMCEventQueryRequestFailed          = 13006,    //调用getCloudPoneInfo失败

    HMCEventConnectRequestStarted       = 13003,    //开始调用connect方法
    HMCEventConnectRequestSuccess       = 13007,    //调用connect成功
    HMCEventConnectRequestFailed        = 13008,    //调用connect失败

    HMCEventSaasWSConnectStarted        = 12088,    //SaaS-WS连接开始建立
    HMCEventSaasWSConnectSuccess        = 12089,    //SaaS-WS连接成功
    HMCEventSaasWSDisconnected          = 12090,    //SaaS-WS连接断开 失败错误码
    HMCEventSaasWSConnectFailed         = 12050,    //SaaS-WS连接/重连失败

    HMCEventRefreshRequestStarted       = 13004,    //开始调用refresh方法
    HMCEventRefreshRequestSuccess       = 13009,    //调用refresh成功
    HMCEventRefreshRequestFailed        = 13010,    //调用refresh失败

    HMCEventSaaSWSMessage               = 12054,    //收到SaaS-WS消息,WS下发的: 消息类型,消息内容
    HMCEventStreamInfoGot               = 12044,    //流地址获取成功(operation == 5)

    HMCEventInputConnectStarted         = 12085,    //input开始建立链接
    HMCEventInputConnectSuccess         = 10021,    //input操作连接成功
    HMCEventInputConnectFailed          = 10022,    //input操作连接失败
    HMCEventInputDisconnected           = 12049,    //Input连接断开

    HMCEventAudioConnectStarted         = 12086,    //音频流连接开始建立
    HMCEventAudioConnectSuccess         = 12033,    //流链接成功（音频部分）
    HMCEventAudioConnectFailed          = 12035,    //流链接失败（音频部分）

    HMCEventVideoConnectStarted         = 12087,    //视频流连接开始建立
    HMCEventVideoConnectSuccess         = 12034,    //流链接成功（视频部分）
    HMCEventVideoConnectFailed          = 12036,    //流链接失败（视频部分）
    HMCEventVideoPlayRate               = 12039,    //播流启动时，当前码率上报，测速起播、切换码率--包含扩展参数，数据为码率值
    HMCEventVideoFirstFrame             = 12045,    //获取到视频第一帧

    HMCEventInputPingoongDelayTime      = 10050,    //“播流期间每固定周期input ping/pong时间” -- ping-pong间隔时间(ms)
    HMCEventInputPingoongDelayOverload  = 10033,    //每ping-pong间隔达到阀值上报, ping-pong间隔时间(ms)
    HMCEventInputPingoongDelayTraceroute= 10051,    //每ping-pong间隔达到阀值，上报traceroute”

    HMCEventVideoFrameDelayOverload     = 12038,    //播流期间，每帧间隔时间达到阀值上报
    HMCEventVideoFrameDelayPeriodResult = 12042,    //每固定周期帧延迟结果上报
    HMCEventVideoDecodeTimePeriodResult = 12037,    //播流期间每固定周期每帧解码平均耗时

    HMCEventSwResolutionRequestStarted  = 13014,    //开始调用resolution方法
    HMCEventSwResolutionRequestSuccess  = 13015,    //调用resolution成功
    HMCEventSwResolutionRequestFailed   = 13016,    //调用resolution失败

    HMCEventManualResolutionStarted     = 12014,    //开始手动切换,当前码率Id:当前码率值,目标码率Id:目标码率值
    HMCEventManualResolutionSuccess     = 12015,    //手动切换成功,当前码率Id:当前码率值,目标码率Id:目标码率值,切换耗时(ms)
    HMCEventManualResolutionFailed      = 12016,    //手动切换失败,当前码率Id:当前码率值,目标码率Id:目标码率值,失败原因

    HMCEventAutoResolutionStarted       = 12011,    //开始自动切换
    HMCEventAutoResolutionSucceed       = 12012,    //自动切换成功,当前码率Id:当前码率值,目标码率Id:目标码率值,切换耗时(ms)
    HMCEventAutoResolutionFailed        = 12013,    //自动切换失败,当前码率Id:当前码率值,目标码率Id:目标码率值,失败原因

    HMCEventDisconnectReqeustStarted    = 13011,    //开始调用disconnect方法
    HMCEventDisconnectReqeustSuccess    = 13012,    //调用disconnect成功
    HMCEventDisconnectReqeustFailed     = 13013,    //调用disconnect失败

    HMCEventStopCalled                  = 12053,    //stop方法被调用  调用类型 0:App 1:SDK

    HMCEventWIFI2Mobile                 = 12017,    //检测到wifi进入移动网络环境
    HMCEventMobile2WIFI                 = 12018,    //检测到移动网络环境进入wifi环境
    HMCEventMobileConfirm               = 12055,    //进入移动环境后，用户选择继续

    HMCEventAppForceground              = 12040,    //播流应用进入前台
    HMCEventAppBackground               = 12041,    //播流应用进入后台

    HMCEventStasticInfoReport           = 12299,    //配合App性能参数上报

    HMCEventQueueConfirm                = 12019,    //用户选择继续
    HMCEventQueueCancel                 = 10039,    //用户取消入队
    HMCEventBandwidthTooLow             = 12046,    //低于服务下限
};

@interface HMCloudPhoneRecordEvent : NSObject

+ (void) recordEvent:(NSInteger)event;
+ (void) recordEvent:(NSInteger)event eventData:(NSString *)eventData;
+ (void) recordEvent:(NSInteger)event eventData:(NSString *)eventData time:(long long)timeStamp;

@end
