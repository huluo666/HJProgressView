//
//  UIProgressView+Radius.h
//  CustomProgressView
//
//  Created by luo.h on 16/3/22.
//  Copyright © 2016年 appledev. All rights reserved.
//  设置圆角

#import <UIKit/UIKit.h>

@interface UIProgressView (Radius)

- (void)setRadiusTrackColor:(UIColor *)trackColor ;
- (void)setRadiusProgressColor:(UIColor *)progressColor;
- (void)setRadiusTrackColor:(UIColor *)trackColor
              progressColor:(UIColor *)progressColor;

@end
