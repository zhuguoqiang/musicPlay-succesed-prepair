/***************************************************
 文件名称：MusicList.m
 作   者：任海丽
 备   注：音乐实现文件
 创建时间：2012-6-6
 修改历史：
 版权声明：Copyright 2012 . All rights reserved.
 ***************************************************/

#import "MusicList.h"
#import "Music.h"
@implementation MusicList
@synthesize musicArray;
/*******************************************
 函数名称：-(id)init
 函数功能：音乐列表初始化方法
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(id)init{
    self=[super init];
    if(!self){
        [self release];
        return nil;
    }
    musicArray=[[NSMutableArray alloc]init];
    return self;
}
/*******************************************
 函数名称：-(void)addMusic:(Music*)aMusic
 函数功能：音乐列表添加音乐
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)addMusic:(Music*)aMusic{
    [self.musicArray addObject:aMusic];
}
/*******************************************
 函数名称：-(void)removeALLMusic
 函数功能：音乐列表移除所有音乐
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)removeALLMusic{
    [self.musicArray removeAllObjects];
}
/*******************************************
 函数名称：-(void)removeMusic:(Music*)aMusic
 函数功能：音乐列表移除音乐
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)removeMusic:(Music*)aMusic{
    [self.musicArray removeObject:aMusic];
}
/*******************************************
 函数名称：-(void)removeAtIndex:(NSUInteger)index
 函数功能：音乐列表移除音乐
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)removeAtIndex:(NSUInteger)index{
    [self.musicArray removeObjectAtIndex:index];
}
/*******************************************
 函数名称：-(NSUInteger)count
 函数功能：音乐列表总大小
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSUInteger)count{
    return [self.musicArray count];
}
/*******************************************
 函数名称：-(Music*)musicAtIndex:(NSUInteger)index
 函数功能：音乐列表里的音乐返回
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(Music*)musicAtIndex:(NSUInteger)index{
    return [self.musicArray objectAtIndex:index];
}
/*******************************************
 函数名称：-(NSUInteger)indexOfMusic:(Music*)aMusic
 函数功能：音乐列表里的音乐返回
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSUInteger)indexOfMusic:(Music*)aMusic{
    return [self.musicArray indexOfObject:aMusic];
}
/*******************************************
 函数名称：-(void)sortName
 函数功能：name排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)sortName{
    [self.musicArray sortUsingSelector:@selector(compareName:)];
}
/*******************************************
 函数名称：-(void)sortAlbum
 函数功能：Album排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)sortAlbum{
    [self.musicArray sortUsingSelector:@selector(compareAlbum:)];
}
/*******************************************
 函数名称：-(void)sortArtist
 函数功能：Artist排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)sortArtist{
    [self.musicArray sortUsingSelector:@selector(compareArtist:)];
}
#pragma mark NSCopying
-(id)copyWithZone:(NSZone *)zone{
    MusicList *newMusicList=[[MusicList allocWithZone:zone]init];
    newMusicList.musicArray=self.musicArray;
    return newMusicList;
}    
#pragma mark NSCoding
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.musicArray forKey:@"musicArray"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if(!self){
        [self release];
        return nil;
    }
    self.musicArray=[aDecoder decodeObjectForKey:@"musicArray"];
    return self;
}
/*******************************************
 函数名称：-(NSString *)description
 函数功能：打印语句
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSString *)description{
    return [self.musicArray description];
}
/*******************************************
 函数名称：-(void)dealloc
 函数功能：析构方法
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)dealloc{
    [musicArray release];
    [super dealloc];
}
@end
