//
//  SGRecordSuccessPreview.h
//  短视频录制
//
//  Created by lihaohao on 2017/5/22.
//  Copyright © 2017年 低调的魅力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface SGRecordSuccessPreview : UIView
@property (nonatomic ,copy) void (^sendBlock) (UIImage *image, NSString *videoPath);
@property (nonatomic ,copy) void (^cancelBlcok) (void);

/**
 设置图片或视频

 @param image 图片
 @param videoPath 视频地址
 @param orientation 方向
 */
- (void)setImage:(UIImage *)image videoPath:(NSString *)videoPath captureVideoOrientation:(AVCaptureVideoOrientation)orientation;
@end
