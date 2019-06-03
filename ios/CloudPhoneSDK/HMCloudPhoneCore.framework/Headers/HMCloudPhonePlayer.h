//
//  HMCloudPhonePlayer.h
//  HMCloudPhoneCore
//
//  Created by Apple on 2018/5/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMCloudCorePlayer.h"

@protocol HMCloudPhoneDelegate;

const extern NSString *CloudGameOptionKeyPhoneID;

const extern NSString *CLOUDPHONE_SDK_VERSION;

@interface HMCloudPhonePlayer : HMCloudCorePlayer

@property (nonatomic, assign) id<HMCloudPhoneDelegate> delegate;

- (BOOL)registCloudPlayer:(NSString *)accessKeyID channelId:(NSString *)channelId options:(NSDictionary *)launchOptions;

- (void) play;

- (void) switchResolution:(NSInteger)resolutionId;

- (void) confirmQueue;

- (NSString *) wifiTo4GTip;

@end


@protocol HMCloudPhoneDelegate <NSObject>

- (void) cloudPhoneSceneChangedCallback:(NSDictionary *)dict;
- (void) cloudPhoneTouchBegan;

@end
