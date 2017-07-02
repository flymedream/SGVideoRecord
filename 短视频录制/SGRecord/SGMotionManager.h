//
//  SGMotionManager.h
//  短视频录制
//
//  Created by lihaohao on 2017/5/24.
//  Copyright © 2017年 低调的魅力. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@protocol SGMotionManagerDeviceOrientationDelegate<NSObject>
@optional
- (void)motionManagerDeviceOrientation:(UIDeviceOrientation)deviceOrientation;
@end
@interface SGMotionManager : NSObject
@property (nonatomic ,assign) UIDeviceOrientation deviceOrientation;
@property (nonatomic ,assign) AVCaptureVideoOrientation videoOrientation;
@property (nonatomic ,weak) id<SGMotionManagerDeviceOrientationDelegate>delegate;

/**
 获取SGMotionManager实例

 @return 返回SGMotionManager实例
 */
+ (instancetype)sharedManager;

/**
 开始方向监测
 */
- (void)startDeviceMotionUpdates;

/**
 结束方向监测
 */
- (void)stopDeviceMotionUpdates;

/**
 设置设备取向

 @return 返回视频捕捉方向
 */
- (AVCaptureVideoOrientation)currentVideoOrientation;
@end
