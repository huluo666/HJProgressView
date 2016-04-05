//
//  HJProgressView.h
//  BezierPathLearn
//
//  Created by luo.h on 16/4/5.
//  Copyright © 2016年 appledev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJProgressView : UIView

@property(nonatomic, strong) UIColor* progressTintColor;//进度条颜色
@property(nonatomic, assign) float progress;            //进度值

- (void)setProgress:(CGFloat)newProgress animated:(BOOL)animated;

@end
