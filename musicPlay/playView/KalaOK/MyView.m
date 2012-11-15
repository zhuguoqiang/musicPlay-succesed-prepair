//
//  MyView.m
//  UIViewDemo
//
//  Created by  on 12-6-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyView.h"

#include <math.h>

#import <glob.h>

static inline double radians (double degrees) {return degrees * M_PI/180;}
@implementation MyView

@synthesize text = _text;

@synthesize bgcolor = _bgcolor;

@synthesize fgcolor = _fgcolor;

@synthesize font = _font;

@synthesize bgimage = _bgimage;

@synthesize fgimage = _fgimage;

@synthesize plan = _plan;

@synthesize t = _t;

@synthesize step = _step;

@synthesize secondBgImage = _secondBgImage;
@synthesize secondFgImage = _secondFgImage;
@synthesize bgRect = _bgRect;
@synthesize fgRect = _fgRect;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:20];
        self.backgroundColor = [UIColor clearColor];
        self.plan = 0.0;
        self.fgimage = NULL;
        self.bgimage = NULL;
    
    }
    return self;
}



-(void)player
{
    self.t = [[[NSTimer alloc]initWithFireDate:[NSDate date] interval:0.1 target:self selector:@selector(timerFunc) userInfo:nil repeats:YES] autorelease];
    
    [[NSRunLoop currentRunLoop]addTimer:self.t forMode:NSDefaultRunLoopMode];

}

-(void)stop
{
    [self.t invalidate];
}

-(void)timerFunc
{
    if(self.plan > 1.0)
        [self stop];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
  
 
    
    
    //初始化
    

    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM (context, 0, self.frame.size.height);
    
    CGContextScaleCTM(context, 1, -1);
    
    
    //清除绘图
    
    CGContextClearRect(context, rect);
    
    //绘制前景色
    
    //计算当前绘制前景色的宽度
    
    if(self.plan != 0)
    {
        /*CGSize singleWidth = [self.text sizeWithFont:self.font];
    
        CGFloat width = ceil(singleWidth.width * self.plan); 
    
        NSLog(@"singleWidth = %f , width = %f , length = %d",singleWidth.width,width,[self.text length]);
    
        self.plan += self.plan ;
    
        CGRect myRect = CGRectMake(0, 0, width, singleWidth.height);
    */
        
        CGContextDrawImage(context, self.bgRect  , self.secondBgImage);
        CGContextDrawImage(context, self.fgRect , self.secondFgImage);
    
        /*myRect.origin.x = myRect.size.width;
    
        myRect.size.width = singleWidth.width - myRect.origin.x;
  */  
        
    
        //[super drawRect:rect];
    }
    else
    {
        CGSize size = [self.text sizeWithFont:self.font];
        
        CGRect rect = CGRectMake(0, 0, size.width
                                 , size.height);
        
        CGContextDrawImage(context, rect ,self.fgimage);
        
    }
  
    UIGraphicsEndImageContext();
}

- (void)setText:(NSString *)text
{
    if (![_text isEqualToString:text]) {
        [_text release];
        _text = [text retain];
        [self setNeedsDisplay];
        [self make];
    }
}

-(void)make
{
    //绘图验证  
        //保存当前状态
        
        //定义rect
        
        CGSize size = [self.text sizeWithFont:self.font];
        
        CGRect rect = CGRectMake(0, 0, size.width
                                 , size.height);
        
        //初始化一些模块
        
        void *data;
        
        int width,heigh;
        
        width = rect.size.width;
        heigh = rect.size.height;
        
        NSLog(@"%d,%d",width,heigh);
        
        data = malloc(width * heigh * 4);
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
        CGContextRef context = CGBitmapContextCreate(data, width, heigh, 8, width *4, colorSpace, kCGImageAlphaPremultipliedLast);
        
        
        
        UIGraphicsPushContext(context);
        
        
        
        //反转坐标
        
        CGContextTranslateCTM(context, 0, heigh);
        CGContextScaleCTM(context, 1, -1);
        
        
        
        if(context == NULL)
            NSLog(@"非drawRect不允许获取CGContextRef");
        
        float * red, * green , * blue, * alpha;
        
        red = malloc(sizeof(float));
        
        green = malloc(sizeof(float));
        
        blue = malloc(sizeof(float));
        
        alpha = malloc(sizeof(float));
        
        
        
        CGContextClearRect(context, rect);
        //加载背景色
        
        [self.bgcolor getRed:red green:green blue:blue alpha:alpha];
        
        CGContextSetRGBFillColor(context, *red, *green, *blue, *alpha);
        
        [self.text drawInRect:self.frame withFont:self.font];
        
        self.bgimage =CGBitmapContextCreateImage(context);
    
        
        CGContextClearRect(context, rect);
        
        //加载前景色
        
        [self.fgcolor getRed:red green:green blue:blue alpha:alpha];
        
        CGContextSetRGBFillColor(context, *red, *green, *blue, *alpha);
        
        [self.text drawInRect:self.frame withFont:self.font];
        
        self.fgimage = CGBitmapContextCreateImage(context);
        
        //返回当期的绘图Context
    UIGraphicsEndImageContext();
        UIGraphicsPopContext();
        
        //释放资源
        
        free(red);
        free(green);
        free(blue);
        free(alpha);
        free(data);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
}

-(void)secondLevelCache
{
    CGSize singleWidth = [self.text sizeWithFont:self.font];
    
    //前景色的宽度
    CGFloat width = ceil(singleWidth.width * self.plan); 
    
   // NSLog(@"singleWidth = %f , width = %f , length = %d",singleWidth.width,width,[self.text length]);
    
    //self.plan += self.plan ;
    
    self.fgRect = CGRectMake(0, 0, width, singleWidth.height);
    
    
    self.secondFgImage =  CGImageCreateWithImageInRect(self.fgimage, self.fgRect);
    
    
    self.bgRect = CGRectMake(self.fgRect.size.width, 0, singleWidth.width-self.fgRect.size.width, singleWidth.height);
    
    
    self.secondBgImage = CGImageCreateWithImageInRect(self.bgimage, self.bgRect);
//    myRect.origin.x = myRect.size.width;
//    
//    myRect.size.width = singleWidth.width - myRect.origin.x;
//    
//    CGContextDrawImage(context, myRect , CGImageCreateWithImageInRect(self.bgimage, myRect));
    
}

- (void)setBgimage:(CGImageRef)bgimage
{
    if (_bgimage) {
        CGImageRelease(_bgimage);
    }
    _bgimage = bgimage;
}

- (CGImageRef)bgimage
{
    return _bgimage;
}

- (void)setFgimage:(CGImageRef)fgimage
{
    if (_fgimage) {
        CGImageRelease(_fgimage);
    }
    _fgimage = fgimage;
}

- (CGImageRef)fgimage
{
    return _fgimage;
}

- (void)setSecondBgImage:(CGImageRef)secondBgImage
{
    if (_secondBgImage) {
        CGImageRelease(_secondBgImage);
    }
    _secondBgImage = secondBgImage;
}

- (CGImageRef)secondBgImage
{
    return _secondBgImage;
}

- (void)setSecondFgImage:(CGImageRef)secondFgImage
{
    if (_secondFgImage) {
        CGImageRelease(_secondFgImage);
    }
    _secondFgImage = secondFgImage;
}

- (CGImageRef)secondFgImage
{
    return _secondFgImage;
}


-(void)dealloc
{
    [self.text release];
    
    [self.bgcolor release];
    
    [self.fgcolor release];
    
    [self.font release];
    
    [self.t release];
    
    self.bgimage = nil;
    self.fgimage = nil;
    self.secondBgImage = nil; //二级缓存
    self.secondFgImage = nil;
    
    [super dealloc];
}

@end
