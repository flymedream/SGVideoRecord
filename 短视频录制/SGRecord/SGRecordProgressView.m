//
//  SGRecordProgressView.m
//  短视频录制
//
//  Created by lihaohao on 2017/5/23.
//  Copyright © 2017年 低调的魅力. All rights reserved.
//

#import "SGRecordProgressView.h"
#define SG_LINE_WIDTH 4
#define SPRING_DAMPING  50
#define SPRING_VELOCITY 29
@interface SGRecordProgressView()
@property (nonatomic ,strong) CALayer *centerlayer;
@end
@implementation SGRecordProgressView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    
    self.layer.cornerRadius = self.bounds.size.height / 2;
    self.clipsToBounds = YES;
    
    // 中间的白圆
    self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.24];
    CALayer *centerlayer = [CALayer layer];
    centerlayer.backgroundColor = [UIColor whiteColor].CGColor;
    centerlayer.position = self.center;
    centerlayer.bounds = CGRectMake(0, 0, 116/2, 116/2);
    centerlayer.cornerRadius = 116/4;
    centerlayer.masksToBounds = YES;
    [self.layer addSublayer:centerlayer];
    _centerlayer = centerlayer;
}
- (void)resetScale{
    [UIView animateWithDuration:0.25 animations:^{
        _centerlayer.transform = CATransform3DIdentity;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)setScale{
    [UIView animateWithDuration:0.25 animations:^{
        _centerlayer.transform = CATransform3DScale(_centerlayer.transform, 30/58.0, 30/58.0, 1);
        self.transform = CGAffineTransformScale(self.transform, 172/156.0, 172/156.0);
    }];
}
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef contexRef = UIGraphicsGetCurrentContext();// 获取上下文
    CGPoint ceterPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2); // 设置圆心
    CGFloat radius = self.bounds.size.height / 2  - SG_LINE_WIDTH/2;// 设置半径
    CGFloat startA = -M_PI_2; // 设置起始点
    CGFloat endA = -M_PI_2 + M_PI * 2 *_progress; // 设置结束点
    
    // 贝塞尔曲线(圆)
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:ceterPoint radius:radius startAngle:startA endAngle:endA clockwise:YES];
    CGContextSetLineWidth(contexRef, SG_LINE_WIDTH);// 设置线宽度
    [[UIColor colorWithRed:255/255.0 green:214/255.0 blue:34/255.0 alpha:1] setStroke];// 设置线颜色
    CGContextAddPath(contexRef, path.CGPath);// 把贝塞尔曲线添加到上下问题
    CGContextStrokePath(contexRef);// 渲染
}

@end
