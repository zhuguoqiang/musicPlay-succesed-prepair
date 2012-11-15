/***************************************************
    文件名称：ImageAndTitle.m
    作   者：刘玉锋
    备   注：存放九宫格图片和文字实现文件
    创建时间：2011-11-1
    修改历史：
    版权声明：Copyright 2011 . All rights reserved.
 ***************************************************/

#import "ImageAndTitle.h"


@implementation ImageAndTitle

@synthesize Image,Title;

/*******************************************
    函数名称：(id)InitWithImage:(NSString *)image 
                      AndTitle:(NSString *)title  
    函数功能：初始化九宫格的文字和图片
    传入参数：N/A
    返回 值： N/A
 ********************************************/
-(id)InitWithImage:(NSString *)image 
		  AndTitle:(NSString *)title
{
    self = [super init];
	if (self) 
	{
		self->Image=[[NSString alloc]initWithString:image];
		self->Title=[[NSString alloc]initWithString:title];
	}
	return self;
}

@end
