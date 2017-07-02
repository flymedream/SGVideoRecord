//
//  SGRecordProgressView.h
//  短视频录制
//
//  Created by lihaohao on 2017/5/23.
//  Copyright © 2017年 低调的魅力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGRecordProgressView : UIButton
@property (nonatomic ,assign) CGFloat progress;
- (void)resetScale;
- (void)setScale;
@end
