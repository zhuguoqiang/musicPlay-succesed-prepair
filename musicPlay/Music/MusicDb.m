/***************************************************
 文件名称：MusicDb.m
 作   者：任海丽
 备   注：音乐实现文件
 创建时间：2012-6-6
 修改历史：
 版权声明：Copyright 2012 . All rights reserved.
 ***************************************************/

#import "MusicDb.h"
#import "Music.h"
#import "MusicList.h"

@implementation MusicDb

@synthesize fileName,musicList;

/*******************************************
 函数名称：-(id)init
 函数功能：音乐初始化方法
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(id)init{
    self = [super init];
    if (!self) {
        [self release];
        return nil;
    }
    fileName = [[NSString alloc]init];
    musicList = [[MusicList alloc] init];
    
    return self;
}
/*******************************************
 函数名称：-(id)initWithFileName:(NSString*)iFileName andMusicList:(MusicList*)iMusicList
 函数功能：音乐db初始化方法
 传入参数：iFileName，iMusicList
 返回 值 ： N/A
 ********************************************/
-(id)initWithFileName:(NSString*)iFileName andMusicList:(MusicList*)iMusicList{
    self=[super init];
    if(!self){
        [self release];
        return nil;
    }
    fileName=[[NSString alloc]initWithString:iFileName];
    musicList=iMusicList;
    return self;
}
/*******************************************
 函数名称：-(void)addMusic:(Music*)aMusic
 函数功能：音乐db添加音乐
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)addMusic:(Music*)aMusic{
    [self.musicList addMusic:aMusic];
}
/*******************************************
 函数名称：-(void)removeALLMusic
 函数功能：音乐列表移除所有音乐
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)removeALLMusic{
    [self.musicList removeALLMusic];
}
/*******************************************
 函数名称：-(void)removeMusic:(Music*)aMusic
 函数功能：音乐列表移除音乐
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)removeMusic:(Music*)aMusic{
    [self.musicList removeMusic:aMusic];
}
/*******************************************
 函数名称：-(void)removeAtIndex:(NSUInteger)index
 函数功能：音乐列表移除音乐
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)removeAtIndex:(NSUInteger)index{
    [self.musicList removeAtIndex:index];
}
/*******************************************
 函数名称：-(NSUInteger)count
 函数功能：音乐列表总大小
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSUInteger)count{
    return [self.musicList count];
}
/*******************************************
 函数名称：-(Music*)musicAtIndex:(NSUInteger)index
 函数功能：音乐列表里的音乐返回
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(Music*)musicAtIndex:(NSUInteger)index{
    return [self.musicList musicAtIndex:index];
}
/*******************************************
 函数名称：-(NSUInteger)indexOfMusic:(Music*)aMusic
 函数功能：音乐列表里的音乐返回
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSUInteger)indexOfMusic:(Music*)aMusic{
    return [self.musicList indexOfMusic:aMusic];
}
/*******************************************
 函数名称：-(void)sortName
 函数功能：name排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)sortName{
    [self.musicList sortName];
}
/*******************************************
 函数名称：-(void)sortAlbum
 函数功能：Album排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)sortAlbum{
    [self.musicList sortAlbum];
}
/*******************************************
 函数名称：-(void)sortArtist
 函数功能：Artist排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)sortArtist{
    [self.musicList sortArtist];
}
/*******************************************
 函数名称：-(void)save
 函数功能：保存文件
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)save{
    [NSKeyedArchiver archiveRootObject:self.musicList toFile:self.fileName];
}
/*******************************************
 函数名称：-(void)read
 函数功能：读取文件
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)read{
    self.musicList=[NSKeyedUnarchiver unarchiveObjectWithFile:self.fileName];
}
#pragma mark NSCoding
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.fileName forKey:@"fileName"];
    [aCoder encodeObject:self.musicList forKey:@"musicList"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if(!self){
        [self release];
        return nil;
    }
    self.fileName=[aDecoder decodeObjectForKey:@"fileName"];
    self.musicList=[aDecoder decodeObjectForKey:@"musicList"];
    return self;
}
/*******************************************
 函数名称：-(NSString *)description
 函数功能：打印语句
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@",self.fileName,[self.musicList description]];
}
/*******************************************
 函数名称：-(void)dealloc
 函数功能：析构方法
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)dealloc{
    [fileName release];
    [musicList release];
    [super dealloc];
}
@end
