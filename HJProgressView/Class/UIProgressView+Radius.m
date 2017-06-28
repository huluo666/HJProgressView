//
//  UIProgressView+Radius.m
//  CustomProgressView
//
//  Created by luo.h on 16/3/22.
//  Copyright © 2016年 appledev. All rights reserved.
//

#import "UIProgressView+Radius.h"
#import <objc/runtime.h>

@implementation UIProgressView (Radius)
@dynamic progressHeigt;

-(void)setProgressHeigt:(CGFloat)progressHeigt
{
    if (self.superview) {
        [self addConstraintWithHeigt:progressHeigt];
    }
    objc_setAssociatedObject(self, @selector(progressHeigt), @(progressHeigt), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
   
}

- (CGFloat)progressHeigt{
    NSNumber *number = objc_getAssociatedObject(self, @selector(progressHeigt));
    return number.floatValue;
}


- (void)setRadiusTrackColor:(UIColor *)trackColor
{
    CGFloat progressHeight = self.frame.size.height;
    if (self.frame.size.height<3) {
        progressHeight=self.progressHeigt;
    }
    
    UIImage *trackImage = [self imageWithColor:trackColor cornerRadius:progressHeight/2.0];
    [self setTrackImage:trackImage];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] <= 9.0) {
        UIImageView *trackImageView = self.subviews.firstObject;
        trackImageView.image=trackImage;
    }
}

- (void)setRadiusProgressColor:(UIColor *)progressColor
{
    CGFloat progressHeight = self.frame.size.height;
    if (self.frame.size.height<3) {
        progressHeight=self.progressHeigt;
    }
    UIImage *progressImage = [self imageWithColor:progressColor cornerRadius:progressHeight/2.0];
    [self setProgressImage:progressImage];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] <= 9.0) {
        UIImageView *progressImageView = self.subviews.lastObject;
        progressImageView.image=progressImage;
    }
}


- (void)setRadiusTrackColor:(UIColor *)trackColor
              progressColor:(UIColor *)progressColor
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self setRadiusTrackColor:trackColor];
    [self setRadiusProgressColor:progressColor];
}


//修复系统Bug（iOS8.3）设置ProgressImage与trackImage无效问题
+ (void)load;
{
    // iOS 9.0 以后系统没问题
    if ([[[UIDevice currentDevice] systemVersion] floatValue] <= 9.0) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class c = [UIProgressView class];
            method_exchangeImplementations(class_getInstanceMethod(c, @selector(layoutSubviews)),class_getInstanceMethod(c, @selector(hjProgress_layoutSubviews)));
        });
    }
}


-(void)hjProgress_layoutSubviews
{
    UIImageView *trackImageView = self.subviews.firstObject;
    UIImageView *progressImageView = self.subviews.lastObject;
    if (!trackImageView || !progressImageView){
    
    }else{
        CGRect bounds = self.bounds;
        CGFloat boundsTop = CGRectGetMinY(bounds);
        UIImage *trackImage = self.trackImage;
        if (trackImage)
        {
            CGFloat trackHeight = trackImage.size.height;
            trackImageView.frame = (CGRect){
                .origin.x = CGRectGetMinX(trackImageView.frame),
                .origin.y = (boundsTop
                             + ((CGRectGetHeight(bounds) - trackHeight) * 0.5f)),
                .size.width = CGRectGetWidth(trackImageView.frame),
                .size.height = trackHeight
            };
        }
        
        UIImage *progressImage = self.progressImage;
        if (progressImage)
        {
            progressImageView.frame = (CGRect){
                .origin.x = CGRectGetMinX(progressImageView.frame),
                .origin.y = (boundsTop
                             + ((CGRectGetHeight(bounds) - progressImage.size.height) * 0.5f)),
                .size.width = CGRectGetWidth(progressImageView.frame),
                .size.height = progressImage.size.height
            };
        }
    }
      [self hjProgress_layoutSubviews];
}


-(void)addConstraintWithHeigt:(CGFloat)heigt
{
    CGFloat w = self.bounds.size.width;
    CGFloat h = heigt;
    CGFloat X = self.frame.origin.x;
    CGFloat Y = self.frame.origin.y;
    [self removeConstraints:self.constraints];

    
    //    //宽
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:0 toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:w]];
    
    //高
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:0 toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:h]];
    
    UIView *superview = self.superview;
    //--Left-X
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:superview
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:X];
    [superview  addConstraint:leftConstraint];
    
    //--Top-Y
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:superview
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:Y];
    [superview  addConstraint:topConstraint];
}


#pragma mark - Creat cornerRadiusImage
//最小尺寸---1px
static CGFloat edgeSizeWithRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}

- (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = edgeSizeWithRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

@end
