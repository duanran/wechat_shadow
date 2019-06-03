//
//  HMCloudCorePlayerViewController.h
//  HMCloudCore
//
//  Created by Apple on 2018/5/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCloudCoreMarco.h"

typedef NS_ENUM(NSInteger, HMCloudCorePlayerEvent) {
    HMCloudCorePlayerEventAudioConnectionStarted,
    HMCloudCorePlayerEventAudioConnectionSuccessed,
    HMCloudCorePlayerEventAudioConnectionFailed,

    HMCloudCorePlayerEventVideoConnectionStarted,
    HMCloudCorePlayerEventVideoConnectionSuccessed,
    HMCloudCorePlayerEventVideoConnectionFailed,

    HMCloudCorePlayerEventInputConnectionStarted,
    HMCloudCorePlayerEventInputConnectionSuccessed,
    HMCloudCorePlayerEventInputConnectionFailed,
    HMCloudCorePlayerEventInputConnectionClosed,

    HMCloudCorePlayerEventPacketDelayInfoReport,
    HMCloudCorePlayerEventPacketDecodeTime,
    HMCloudCorePlayerEventPingPongTime,
    HMCloudCorePlayerEventPingPongDelay,
    HMCloudCorePlayerEventPingPongTraceRoute
};

typedef NS_ENUM(NSInteger, HMCloudCorePlayerSubViewCenterStyle) {
    SubViewCenterStyleHorizitional  =                               0x01,
    SubViewCenterStyleVertical      = SubViewCenterStyleHorizitional<<1,
    SubViewCenterStyleBoth          = (SubViewCenterStyleHorizitional|SubViewCenterStyleVertical),
};

@protocol HMCloudCorePlayerViewControllerDelegate <NSObject>
@optional

/**
 播放器出错
 */
- (void) cloudCorePlayerError;

/**
收到视频第一帧
 */
- (void) cloudCorePlayerFirstVideoFrameArrival;

/**
 检测到帧延迟，需要切换清晰度

 @param percent 帧延迟百分比
 */
- (void) cloudCorePlayerPacketDelayOccured:(NSString *)percent;

/**
 收到统计信息

 @param type 信息类型 0-bandwidth 1-frames 2-decodetime
 @param value 对应的统计值
 @param detail 最大Bytes的帧列表，仅对type==0有效
 */
- (void) cloudCorePlayerStasticInfoArrival:(int)type value:(int64_t)value detail:(NSArray *)detail;

/**
 系统音量发生变化

 @param up true:音量+ false:音量-
 */
- (void) systemVolumeChanged:(BOOL)up;

/**
 点击事件触发
 */
- (void) cloudCorePlayerTouchBegan;

/**
 有事件需要上报

 @param event 事件类型
 @param data 扩展数据
 */
- (void) cloudCorePlayerEventReport:(HMCloudCorePlayerEvent)event data:(NSString *)data;

@end

@interface HMCloudCorePlayerViewController : UIViewController

@property (nonatomic, assign) id<HMCloudCorePlayerViewControllerDelegate> delegate;
@property (nonatomic, assign) HMCloudCorePlayerOrientation playerOrientation;

/**
 启动Player

 @param videoUrl 视频流地址，rtmp协议
 @param audioUrl 音频流地址，rtmp协议
 @param inputUrl 操作连接地址，ws协议
 @param switchBRDuration 每次监测持续时间，单位秒
 @param detectInterval 采样时间间隔时间，单位毫秒
 @param delayTimeSinceLastCheck 相邻两帧间隔时间阀值，超过则通知帧延迟事件，单位毫秒
 @param switBRFrozenTime 发生自动切换后，不监测时间，单位秒
 @param isReportDetailInfo 是否上报延迟详细数据
 @param delaySampleInterval 延迟检测采样周期
 @param startDelayTime 起播后，不检测帧延迟时长，单位秒
 @param hidden 是否隐藏Player（池化重启，为true）
 */
- (void) startPlayerWithVideoUrl:(NSString *)videoUrl
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

/**
 视频画面可见（池化重启）
 */
- (void) makePlayerVisible;

/**
 停止Player

 @param showLastFrame 是否显示最后一帧画面
 */
- (void) stopPlayer:(BOOL)showLastFrame;

/**
 播流过程中数据统计参数

 @param fpsInterval 帧数统计周期，单位秒
 @param bandInterval 流量统计周期，单位秒
 @param frameCount 流量统计周期内记录的最大Bytes帧数
 @param decodeInterval 平均解码耗时统计周期
 */
- (void) startStastics:(int)fpsInterval
          bandInterval:(int)bandInterval
            frameCount:(int)frameCount
        decodeInterval:(int)decodeInterval;

/**
 设置PingPong定时器参数

 @param interval 定时器周期
 @param delayTime 上报PingPong延迟上限，单位ms
 @param traceRouteTime 上报traceRout延迟上限，单位ms
 */
- (void) setPingPongParams:(NSInteger)interval
                 delayTime:(NSInteger)delayTime
            traceRouteTime:(NSInteger)traceRouteTime;

/**
 设置Player背景图

 @param image 背景图UIImage实例
 */
- (void) setBackgroundImage:(UIImage *)image;

/**
 前置同一层级view
 */
- (void) bringViewToFront:(UIView *)view;

/**
 添加子视图
*/
- (void) addSubView:(UIView *)view;

/**
 子视图居中
 */
- (void) centerSubView:(UIView *)view style:(HMCloudCorePlayerSubViewCenterStyle)style;

/**
 获取视频帧延迟

 @return 帧延迟，单位ms
 */
- (NSInteger) getVideoLatency;

/**
 发送按键

 @param keycode <#keycode description#>
 */
- (void) sendKeycode:(NSInteger)keycode;

- (void) sendCommand:(NSString *)cmd;

@end
