# HJProgressView
http://stackoverflow.com/questions/22311516/uiprogressview-custom-track-and-progress-images-in-ios-7-1          

### 一、主要功能：    
`UIProgressView+Radius`  使用分类实现以下功能

1、修复UIProgressView在iOS7，iOS8.3上设置trackimage和ProgressImage无效Bug                      

2、UIProgressView设置进度圆角

3、快速简单设置UIProgressView高度，进度颜色等

`HJProgressView`  自定义ProgressView进度条，与系统使用方法，动画等一致，功能如上



![](https://github.com/huluo666/HJProgressView/blob/master/HJProgressView/2016_03_25_032636.png)

### 二、用法示例
```objectivec
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //方式一 系统UIProgressView
        UIProgressView *progressView=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2-150, 60, 300, 20);
    [self.view addSubview:progressView];//由于使用AutoLayout需先addSubview然后设置高度等参数
    
    progressView.progressHeigt=20;
    [progressView setRadiusTrackColor:RGBCOLOR(231, 233, 238) progressColor:RGBCOLOR(255, 153,0)];
    [progressView setProgress:0.68 animated:YES];
    
   
   //PS：使用transform改变高度，出现动画不自然，在iOS7.xx系统出现高度不准等Bug，改用AutoLayout实现
   //progressView.transform=CGAffineTransformMakeScale(1.0, 8.0);//默认为2px，无法通过frame设置高度


    
    
    
    //方式二 自定义HJProgressView  注意：#import "HJProgressView.h"
    HJProgressView *progressView2=[[HJProgressView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-150, 100, 300,16)];
    progressView2.progressTintColor=RGBCOLOR(255, 153,0);
    [progressView2 setProgress:0.8 animated:YES];
    [self.view addSubview:progressView2];
}
```
