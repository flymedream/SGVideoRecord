//
//  SGMotionManager.m
//  短视频录制
//
//  Created by lihaohao on 2017/5/24.
//  Copyright © 2017年 低调的魅力. All rights reserved.
//

#import "SGMotionManager.h"
#import <CoreMotion/CoreMotion.h>
#define MOTION_UPDATE_INTERVAL 1/15.0
@interface SGMotionManager()
@property (nonatomic ,strong) CMMotionManager *motionManager;
@end
@implementation SGMotionManager
+ (instancetype)sharedManager{
    static SGMotionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SGMotionManager alloc]init];
    });
    return manager;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self motionManager];
    }
    return self;
}
- (CMMotionManager *)motionManager{
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc]init];
        _motionManager.deviceMotionUpdateInterval = MOTION_UPDATE_INTERVAL;
    }
    return _motionManager;
}
// 开始
- (void)startDeviceMotionUpdates{
    if (_motionManager.deviceMotionAvailable) {
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            [self performSelectorOnMainThread:@selector(handleDeviceMotion:) withObject:motion waitUntilDone:YES];
        }];
    }
}
// 结束
- (void)stopDeviceMotionUpdates{
    [_motionManager stopDeviceMotionUpdates];
}
- (void)handleDeviceMotion:(CMDeviceMotion *)deviceMotion{
    double x = deviceMotion.gravity.x;
    double y = deviceMotion.gravity.y;
    if (fabs(y) >= fabs(x))
    {
        if (y >= 0){
            _deviceOrientation = UIDeviceOrientationPortraitUpsideDown;
            _videoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
            //NSLog(@"UIDeviceOrientationPortraitUpsideDown--AVCaptureVideoOrientationPortraitUpsideDown");
        }
        else{
            _deviceOrientation = UIDeviceOrientationPortrait;
            _videoOrientation = AVCaptureVideoOrientationPortrait;
            //NSLog(@"UIDeviceOrientationPortrait--AVCaptureVideoOrientationPortrait");
        }
    }
    else{
        if (x >= 0){
            _deviceOrientation = UIDeviceOrientationLandscapeRight;
            _videoOrientation = AVCaptureVideoOrientationLandscapeRight;
            //NSLog(@"UIDeviceOrientationLandscapeRight--AVCaptureVideoOrientationLandscapeRight");
        }
        else{
            _deviceOrientation = UIDeviceOrientationLandscapeLeft;
            _videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
           // NSLog(@"UIDeviceOrientationLandscapeLeft--AVCaptureVideoOrientationLandscapeLeft");
        }
    }
    ;
    if (_delegate && [_delegate respondsToSelector:@selector(motionManagerDeviceOrientation:)]) {
        [_delegate motionManagerDeviceOrientation:_deviceOrientation];
    }
}
// 调整设备取向
- (AVCaptureVideoOrientation)currentVideoOrientation{
    AVCaptureVideoOrientation orientation;
    switch ([SGMotionManager sharedManager].deviceOrientation) {
        case UIDeviceOrientationPortrait:
            orientation = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationLandscapeRight:
            orientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            orientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        default:
            orientation = AVCaptureVideoOrientationLandscapeRight;
            break;
    }
    return orientation;
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
