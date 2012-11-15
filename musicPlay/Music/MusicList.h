/***************************************************
 文件名称：MusicList.h
 作   者：任海丽
 备   注：音乐头文件
 创建时间：2012-6-6
 修改历史：
 版权声明：Copyright 2012 . All rights reserved.
 ***************************************************/

#import <Foundation/Foundation.h>
@class Music;
@interface MusicList : NSObject<NSCopying,NSCoding>{
    NSMutableArray *musicArray;
}
@property(nonatomic,retain)NSMutableArray *musicArray;
/*******************************************
 函数名称：-(id)init
 函数功能：音乐列表初始化方法
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(id)init;
/*******************************************
 函数名称：-(void)addMusic:(Music*)aMusic
 函数功能：音乐列表添加音乐
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)addMusic:(Music*)aMusic;
/*******************************************
 函数名称：-(void)removeALLMusic
 函数功能：音乐列表移除所有音乐
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)removeALLMusic;
/*******************************************
 函数名称：-(void)removeMusic:(Music*)aMusic
 函数功能：音乐列表移除音乐
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)removeMusic:(Music*)aMusic;
/*******************************************
 函数名称：-(void)removeAtIndex:(NSUInteger)index
 函数功能：音乐列表移除音乐
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)removeAtIndex:(NSUInteger)index;
/*******************************************
 函数名称：-(NSUInteger)count
 函数功能：音乐列表总大小
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSUInteger)count;
/*******************************************
 函数名称：-(Music*)musicAtIndex:(NSUInteger)index
 函数功能：音乐列表里的音乐返回
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(Music*)musicAtIndex:(NSUInteger)index;
/*******************************************
 函数名称：-(NSUInteger)indexOfMusic:(Music*)aMusic
 函数功能：音乐列表里的音乐返回
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSUInteger)indexOfMusic:(Music*)aMusic;
/*******************************************
 函数名称：-(void)sortName
 函数功能：name排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)sortName;
/*******************************************
 函数名称：-(void)sortAlbum
 函数功能：Album排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)sortAlbum;
/*******************************************
 函数名称：-(void)sortArtist
 函数功能：Artist排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)sortArtist;

@end
