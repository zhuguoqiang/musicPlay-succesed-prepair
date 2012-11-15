//
//  MyView.h
//  UIViewDemo
//
//  Created by  on 12-6-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyView : UIView 

@property (retain,nonatomic) NSString * text;

@property (retain,nonatomic) UIColor * bgcolor;

@property (retain,nonatomic) UIColor *fgcolor;

@property (retain,nonatomic) UIFont * font;

@property (retain,nonatomic) NSTimer * t;

@property (nonatomic) CGImageRef  bgimage;

@property (nonatomic) CGImageRef  fgimage;

@property (nonatomic) CGImageRef secondBgImage; //二级缓存
@property (nonatomic) CGImageRef secondFgImage;

@property (nonatomic) CGRect bgRect;
@property (nonatomic) CGRect fgRect;


//进度为浮点， 百分比。 尽量跟宽度没有关系,他的最大值为1
@property (nonatomic) CGFloat plan;

@property (nonatomic) CGFloat step;

//动画的控制由他的父类来完成，由AVMusic等方法的回调来修改当前的歌词

-(void)player;
-(void)stop;
-(void)timerFunc;

-(void)make;
-(void)secondLevelCache;
@end
