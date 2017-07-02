//
//  SGRecordEncoder.h
//  短视频录制
//
//  Created by lihaohao on 2017/5/19.
//  Copyright © 2017年 低调的魅力. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
@interface SGRecordEncoder : NSObject
@property (nonatomic, readonly) NSString *path;

/**
 SGRecordEncoder遍历构造器

 @param path 媒体存发路径
 @param cy   视频分辨率的高
 @param cx   视频分辨率的宽
 @param ch   音频通道
 @param rate 音频的采样比率
 @return     SGRecordEncoder实例
 */
+ (SGRecordEncoder*)encoderForPath:(NSString*) path Height:(NSInteger) cy width:(NSInteger) cx channels: (int) ch samples:(Float64) rate;

/**
 初始化方法

 @param path 媒体存发路径
 @param cy   视频分辨率的高
 @param cx   视频分辨率的宽
 @param ch   音频通道
 @param rate 音频的采样率
 @return     SGRecordEncoder实例
 */
- (instancetype)initPath:(NSString*)path Height:(NSInteger)cy width:(NSInteger)cx channels: (int)ch samples:(Float64)rate;

/**
  完成视频录制时调用

 @param handler 完成的回调block
 */
- (void)finishWithCompletionHandler:(void (^)(void))handler;

/**
 *  通过这个方法写入数据
 *
 *  @param sampleBuffer 写入的数据
 *  @param isVideo      是否写入的是视频
 *
 *  @return 写入是否成功
 */

/**
 写入数据

 @param sampleBuffer  写入的数据
 @param isVideo       是否写入的是视频
 @return              是否写入成功
 */
- (BOOL)encodeFrame:(CMSampleBufferRef)sampleBuffer isVideo:(BOOL)isVideo;
@end
