//
//  HJProgressView.m
//  BezierPathLearn
//
//  Created by luo.h on 16/4/5.
//  Copyright © 2016年 appledev. All rights reserved.
//

#import "HJProgressView.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@implementation HJProgressView
{
    NSTimer *_progressTimer;
    CGFloat _targetProgress;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.backgroundColor=RGBCOLOR(231, 233, 238);//默认颜色
        self.layer.cornerRadius=self.bounds.size.height/2;
        self.layer.masksToBounds=YES;
        
        _progressTintColor=[UIColor blueColor];
    }
    return self;
}

//当视图显示的时候会调用,但是默认只会调用一次
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, _progressTintColor.CGColor);
    CGContextSetLineWidth(ctx,self.bounds.size.height); // 设置线段的宽度
    CGContextSetLineJoin(ctx, kCGLineJoinRound); // 设置线段起点和终点的样式都为圆角
    CGContextSetLineCap(ctx, kCGLineCapRound);   // 设置线段的转角样式为圆角
    
    //开始画线, x，y为开始点的坐标
    CGContextMoveToPoint(ctx, 0,self.bounds.size.height/2);
    //画直线, x，y为线条结束点的坐标
    CGContextAddLineToPoint(ctx,_progress*self.bounds.size.width,self.bounds.size.height/2);
    CGContextStrokePath(ctx);//渲染，绘制出一条空心的线断
}


- (void)setProgress:(float)progress
{
    _progress = progress;
    //每次传进来进度的时候,重绘
    //在view上做一个重绘的标记,当下次屏幕刷新的时候,就会调用drawRect方法
    [self setNeedsDisplay];
}



- (void)setProgress:(CGFloat)newProgress animated:(BOOL)animated;
{
    if (animated){
        _targetProgress = newProgress;
        if (_progressTimer == nil)
        {
            _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveProgress) userInfo:nil repeats:YES];
        }
    }
    else{
        self.progress = newProgress;
    }
}



- (void) moveProgress
{
    if (self.progress < _targetProgress){
        self.progress = MIN(self.progress + 0.01, _targetProgress);
    }
    else if(self.progress > _progress){
        self.progress = MAX(self.progress - 0.01, _targetProgress);
    }
    else{
        [_progressTimer invalidate];
        _progressTimer = nil;
    }
}

@end
