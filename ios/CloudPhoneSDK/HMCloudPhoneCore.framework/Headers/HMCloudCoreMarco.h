//
//  HMCloudCoreMarco.h
//  HMCloudCore
//
//  Created by Apple on 2018/5/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#ifndef HMCloudCoreMarco_h
#define HMCloudCoreMarco_h

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
    block();\
} else {\
    dispatch_async(dispatch_get_main_queue(), block);\
}

#ifndef DEBUG
#define NSLog(FORMAT, ...) nil
#endif

typedef NS_ENUM(NSInteger, HMCloudCorePlayerOrientation) {
    HMCloudCorePlayerOrientationLandscape   = 0,    //横屏
    HMCloudCorePlayerOrientationPortrait    = 1,    //竖屏
};

#endif /* HMCloudCoreMarco_h */
