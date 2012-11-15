/***************************************************
 文件名称：MusicSqlite.h
 作   者：任海丽
 备   注：数据库头文件
 创建时间：2012-6-6
 修改历史：
 版权声明：Copyright 2012 . All rights reserved.
 ***************************************************/

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
@class MusicDb;
@class Music;
@interface MusicSqlite : NSObject{
    FMDatabase *db;
    FMResultSet *rs;
}
@property (nonatomic,retain) MusicDb *iMusicDb;
@property (nonatomic,retain)FMDatabase *db;
@property (nonatomic,retain)FMResultSet *rs;


/*******************************************
 函数名称：-(BOOL)initWithMusicDb:(MusicDb*)iMusicDbt;
 函数功能：初始化数据库
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)initWithMusicDb:(MusicDb*)iMusicDbt;

/*******************************************
 函数名称：-(BOOL)open
 函数功能：打开数据库
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)open;
/*******************************************
 函数名称：-(BOOL)open:(NSString*)path andMusicDb:(MusicDb*)iMusicDb
 函数功能：打开数据库
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)open:(MusicDb*)iMusicDb;
/*******************************************
 函数名称：-(BOOL)create:(MusicDb*)iMusicDb
 函数功能：创建表
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)create:(MusicDb*)iMusicDb;

/*******************************************
 函数名称：-(void)updateLove:(NSInteger)index andMusic:(Music* )aMusic
 函数功能：更改love值
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)updateLove:(NSInteger)index andMusic:(Music* )aMusic;
/*******************************************
 函数名称：-(BOOL)insert:(Music*)aMusic
 函数功能：添加数据
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)insert:(Music*)aMusic;

/*******************************************
 函数名称：-(BOOL)insertLove:(Music*)aMusic
 函数功能：添加数据
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)insertLove:(Music*)aMusic;

/*******************************************
 函数名称：-(*)selecteLove
 函数功能：查询love
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(MusicDb*)selecteLove;

/*******************************************
 函数名称：-(BOOL)deleteaNote:(Music*)aMusic
 函数功能：删除数据
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)deleteaNote:(Music*)aMusic;
/*******************************************
 函数名称：-(BOOL)deleteaAll
 函数功能：删除数据
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)deleteaAll;
/*******************************************
 函数名称：-(BOOL)update:(Music*)aMusic
 函数功能：更新数据
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)update:(Music*)aMusic;
/*******************************************
 函数名称：-(MusicDb*)selecteAll
 函数功能：查询所有数据
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(MusicDb*)selecteAll;

/*******************************************
 函数名称：-(BOOL)createNewTable:(NSString*)table
 函数功能：新建列表
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)createNewTable:(NSString*)table;
/*******************************************
 函数名称：-(BOOL)close
 函数功能：关闭数据库
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)close;

@end
