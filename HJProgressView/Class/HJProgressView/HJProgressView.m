//
//  HJProgressView.m
//  BezierPathLearn
//
//  Created by luo.h on 16/4/5.
//  Copyright © 2016年 appledev. All rights reserved.
//

#import "HJProgressView.h"

#define HJRGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface HJProgressView ()

@end

@implementation HJProgressView
{
    CAShapeLayer   *_progressLayer;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.backgroundColor=HJRGBCOLOR(231, 233, 238);//默认颜色
        self.layer.cornerRadius=self.bounds.size.height/2;
        self.layer.masksToBounds=YES;
        
        _progressTintColor=[UIColor blueColor];
        
        [self initBackgroundView];
    }
    return self;
}

//创建背景
- (void)initBackgroundView
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0,self.bounds.size.height/2)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width,self.bounds.size.height/2)];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.strokeColor = _progressTintColor.CGColor;
    lineLayer.lineWidth = self.bounds.size.height;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.strokeStart=0.0;
    lineLayer.strokeEnd=0.0;
    [self.layer addSublayer:lineLayer];
    _progressLayer=lineLayer;
}


-(void)setProgressTintColor:(UIColor *)progressTintColor
{
    if (_progressTintColor == progressTintColor||!progressTintColor)return;
    _progressTintColor=progressTintColor;
    _progressLayer.strokeColor = _progressTintColor.CGColor;
}

#pragma mark ----animations
- (void)setProgress:(float)progress
{
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)newProgress animated:(BOOL)animated;
{
    if (_progress == newProgress)return;
    
    if (animated){
        CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = @(_progress);
        animation.toValue = @(newProgress);
        animation.duration = 0.38f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.delegate = self;
        // 设置动画结束时保持最终状态
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        _progressLayer.strokeEnd = newProgress;
        [_progressLayer addAnimation:animation forKey:@"animationStrokeStart"];
    }else{
        _progressLayer.strokeEnd=newProgress;
    }
    _progress =newProgress;
}

@end
