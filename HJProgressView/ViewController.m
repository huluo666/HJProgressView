//
//  ViewController.m
//  HJProgressView
//
//  Created by luo.h on 16/3/25.
//  Copyright © 2016年 appledev. All rights reserved.
//http://www.cnblogs.com/YouXianMing/p/3678709.html

#import "ViewController.h"
#import "UIProgressView+Radius.h"

#import "HJProgressView.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIProgressView *progressView=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2-150, 60, 300, 20);
    [self.view addSubview:progressView];//由于使用AutoLayout需先addSubview然后设置高度等参数
    
    progressView.progressHeigt=20;
    [progressView setRadiusTrackColor:RGBCOLOR(231, 233, 238) progressColor:RGBCOLOR(255, 153,0)];
    [progressView setProgress:0.3 animated:NO];

 

    
    //方式二
    HJProgressView *progressView2=[[HJProgressView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-150, 100, 300,16)];
    progressView2.progressTintColor=RGBCOLOR(255, 153,0);
    [progressView2 setProgress:0.8 animated:YES];
    [self.view addSubview:progressView2];
}

@end
