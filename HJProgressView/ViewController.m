//
//  ViewController.m
//  HJProgressView
//
//  Created by luo.h on 16/3/25.
//  Copyright © 2016年 appledev. All rights reserved.
//

#import "ViewController.h"
#import "UIProgressView+Radius.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIProgressView *progressView=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2-150, 50, 300, 50);
    [progressView setProgress:0.68 animated:YES];
    progressView.transform=CGAffineTransformMakeScale(1.0, 8.0);
    [self.view addSubview:progressView];
    [progressView setRadiusTrackColor:RGBCOLOR(231, 233, 238) progressColor:RGBCOLOR(255, 153,0)];
}

@end
