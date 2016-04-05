# HJProgressView
http://stackoverflow.com/questions/22311516/uiprogressview-custom-track-and-progress-images-in-ios-7-1          

### 一、主要功能：    
1.修复UIProgressView在iOS7，iOS8.3上设置trackimage和ProgressImage无效Bug                      
2.UIProgressView设置进度圆角

![](https://github.com/huluo666/HJProgressView/blob/master/HJProgressView/2016_03_25_032636.png)

### 二、用法示例
```objectivec
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //方式一 系统UIProgressView
    UIProgressView *progressView=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2-150, 50, 300, 50);
    [progressView setProgress:0.68 animated:YES];
    
    progressView.transform=CGAffineTransformMakeScale(1.0, 8.0);//默认为2px，无法通过frame设置高度
    [self.view addSubview:progressView];
    [progressView setRadiusTrackColor:RGBCOLOR(231, 233, 238) progressColor:RGBCOLOR(255, 153,0)];
    
    
    //方式二 自定义HJProgressView  注意：#import "HJProgressView.h"
    HJProgressView *progressView2=[[HJProgressView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-150, 100, 300,16)];
    progressView2.progressTintColor=RGBCOLOR(255, 153,0);
    [progressView2 setProgress:0.8 animated:YES];
    [self.view addSubview:progressView2];
}

```
