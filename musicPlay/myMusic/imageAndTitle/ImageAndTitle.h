/***************************************************
    文件名称：ImageAndTitle.h
    作   者：刘玉锋
    备   注：存放九宫格图片和文字头文件
    创建时间：2011-11-1
    修改历史：
    版权声明：Copyright 2011 . All rights reserved.
 ***************************************************/

#import <Foundation/Foundation.h>


@interface ImageAndTitle : NSObject 
{
	NSString* Image; //图片文件名
	NSString* Title; //文字文件名
}


/*******************************************
    函数名称：(id)InitWithImage:(NSString *)image 
                  AndTitle:(NSString *)title  
    函数功能：初始化九宫格的文字和图片
    传入参数：N/A
    返回 值： N/A
 ********************************************/
- (id)InitWithImage:(NSString *)image 
           AndTitle:(NSString *)title;

@property (nonatomic ,retain) NSString * Image;
@property (nonatomic ,retain) NSString * Title;

@end
