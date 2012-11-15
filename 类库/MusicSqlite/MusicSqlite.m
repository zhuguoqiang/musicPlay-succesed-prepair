/***************************************************
 文件名称：MusicSqlite.m
 作   者：朱国强
 备   注：数据库头文件
 创建时间：2012-8-20
 修改历史：
 版权声明：Copyright 2012 . All rights reserved.
 ***************************************************/

#import "MusicSqlite.h"
#import "MusicDb.h"
#import "Music.h"
#import "MusicList.h"

@implementation MusicSqlite

@synthesize db,rs;
@synthesize iMusicDb;

/*******************************************
 函数名称：-(BOOL)initWithMusicDb:(MusicDb*)iMusicDbt;
 函数功能：初始化数据库
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)initWithMusicDb:(MusicDb*)iMusicDbt
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *dbPath =[documentsDirectory stringByAppendingPathComponent:@"music.db"];
    BOOL isExist=[[NSFileManager defaultManager]fileExistsAtPath:dbPath];
    if (!isExist) 
    {
        //如果不存在,将工程中的数据库拷贝到沙河中
        NSString* datePath = [[NSBundle mainBundle]pathForResource:@"music" ofType:@"db"];
        BOOL cp;
        cp = [[NSFileManager defaultManager]copyItemAtPath:datePath toPath:dbPath error:nil];
        if (cp) 
        {
            NSLog(@"copy db successed");
        }else
        {
            NSLog(@"copy db failed");
        }
        [self open];
        //创建表
        [self create:iMusicDbt];
        //插入两条数据
        //并添加两条应用程序中有的项目
        /*
        NSBundle *bundle=[NSBundle mainBundle];
        NSURL *url=[bundle URLForResource:@"七里香 - 周杰伦" withExtension:@"mp3"];
        NSURL *url1=[bundle URLForResource:@"青花瓷 - 周杰伦" withExtension:@"mp3"];
        NSString *lrc=[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"/七里香 - 周杰伦.lrc"];
        NSString *lrc1=[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"/青花瓷 - 周杰伦.lrc"];
        Music *music=[[Music alloc]initUrl:url];
        music.lrcpath=lrc;
        Music *music1=[[Music alloc]initUrl:url1];
        music1.lrcpath=lrc1;
        //写到数据库里面
        [self insert:music];
        [self insert:music1];
        
        [music release];
        [music1 release];
         */
        //并扫描项目中是否还有别的歌曲
        NSString *searchPaths =NSHomeDirectory();
        
        NSArray *array=[[NSFileManager defaultManager]directoryContentsAtPath:searchPaths];
        for (NSString* file in array) {
            if([file hasSuffix:@"mp3"]){
                NSURL *url=[[NSURL alloc]initFileURLWithPath:[NSString stringWithFormat:@"%@/%@",searchPaths,file]];
                Music *music=[[Music alloc]initUrl:url];
                music.name=[file substringToIndex:[file length]-4];
                NSLog(@"name%@",music.name);
                //如果是音乐文件就写到数据库里面
                [self insert:music];
                [music release];
            }
        }
        [self close];
    }
    return 1;
}

/*******************************************
 函数名称：-(BOOL)open
 函数功能：打开数据库
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)open
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *dbPath =[documentsDirectory stringByAppendingPathComponent:@"music.db"];
    self.db = [FMDatabase databaseWithPath:dbPath];
    if([self.db open])
    {
        NSLog(@"open db ok");
        return YES;
    }else
    {
        NSLog(@"open db not ok");
        return NO;
    }
}
/*******************************************
 函数名称：-(BOOL)open:(NSString*)path andMusicDb:(MusicDb*)iMusicDb
 函数功能：打开数据库
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)open:(MusicDb*)iMusicDbt
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSLog(@"document = %@",documentsDirectory);
        NSString *dbPath =[documentsDirectory stringByAppendingPathComponent:@"music.db"];
    BOOL isExist=[[NSFileManager defaultManager]fileExistsAtPath:dbPath];

    //NSLog(@"-------%@",dbPath);
    if (!isExist) 
    {
        
        NSString* datePath = [[NSBundle mainBundle]pathForResource:@"music" ofType:@"db"];
        BOOL cp;
        cp = [[NSFileManager defaultManager]copyItemAtPath:datePath toPath:dbPath error:nil];
        if (cp) 
        {
            NSLog(@"copy db successed");
        }else
        {
            NSLog(@"copy db failed");
        }

        self.db=[FMDatabase databaseWithPath:dbPath];
        BOOL isOpen=[self.db open];
        if (!isOpen) 
        {
            NSLog(@"Could not open db.");    
            return YES;
        }
        //如果不存在，创建表
        [self create:iMusicDbt];
        //插入两条数据
        //并添加两条应用程序中有的项目
        NSBundle *bundle=[NSBundle mainBundle];
        NSURL *url=[bundle URLForResource:@"七里香 - 周杰伦" withExtension:@"mp3"];
        NSURL *url1=[bundle URLForResource:@"青花瓷 - 周杰伦" withExtension:@"mp3"];
        NSString *lrc=[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"/七里香 - 周杰伦.lrc"];
        NSString *lrc1=[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"/青花瓷 - 周杰伦.lrc"];
        Music *music=[[Music alloc]initUrl:url];
        music.lrcpath=lrc;
        Music *music1=[[Music alloc]initUrl:url1];
        music1.lrcpath=lrc1;
        /*
         [self.iMusicDb addMusic:music];
         [self.iMusicDb addMusic:music1];
         */
        [self insert:music];
        [self insert:music1];
        [music release];
        [music1 release];
        //并扫描项目中是否还有别的歌曲
        NSString *searchPaths =NSHomeDirectory();
        
        NSArray *array=[[NSFileManager defaultManager]directoryContentsAtPath:searchPaths];
        for (NSString* file in array) {
            if([file hasSuffix:@"mp3"]){
                NSURL *url=[[NSURL alloc]initFileURLWithPath:[NSString stringWithFormat:@"%@/%@",searchPaths,file]];
                Music *music=[[Music alloc]initUrl:url];
                music.name=[file substringToIndex:[file length]-4];
                NSLog(@"name%@",music.name);
                //如果是音乐文件就写到数据库里面
                [self insert:music];
                [music release];
            }
        }
        [self close];
    }else{
        
        self.db=[FMDatabase databaseWithPath:dbPath];
        BOOL isOpen=[self.db open];
        if (!isOpen) {
            NSLog(@"Could not open db.");    
            return YES;
        }
        NSLog(@"数据库和表已经存在");
    }
    self.iMusicDb=[[[MusicDb alloc]init]autorelease];
  return YES;
}
/*******************************************
 函数名称：-(BOOL)create:(MusicDb*)iMusicDb
 函数功能：创建表
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)create:(MusicDb*)iMusicDbt{
    //是否最近播放和收藏，如果是的话就是1,不是话就是0;
    [self.db  executeUpdate:@"CREATE TABLE music (url text,lrcpath text,number integer,recently integer,love integer)"];
    //新创建的表应该插入两条默认的数据
     for (Music *iMusic in iMusicDbt.musicList.musicArray){
         [self insert:iMusic];
     }    
    return YES;
}
/*******************************************
 函数名称：-(BOOL)insert:(Music*)aMusic
 函数功能：添加数据
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)insert:(Music*)aMusic{
    int recently=0;
    int love=0;
    if (aMusic.recently) {
        recently=1;
    }
    if (aMusic.love) {
        love=1;
    }
    
    [self.db executeUpdate:@"INSERT INTO music (url,lrcpath,number,recently,love) VALUES (?,?,?,?,?)",[NSString stringWithFormat:@"%@",aMusic.url],[NSString stringWithFormat:@"%@",aMusic.lrcpath],aMusic.number,[NSNumber numberWithInt: recently],[NSNumber numberWithInt:love]];
    //NSLog(@"添加成功");
    return YES;
}
/*******************************************
  函数名称：-(void)updateLove:(NSInteger)index andMusic:(Music* )aMusic
  函数功能：更改love值
  传入参数：N/A
  返回 值 ： N/A
  ********************************************/
-(void)updateLove:(NSInteger)index andMusic:(Music* )aMusic
{
    [self open];
    if ([self.db executeUpdate:@"update music set love = ? where url = ?",index,[NSString stringWithFormat:@"%@",aMusic.url]]) {
        NSLog(@"updateLove successed");
    }else
    {
        NSLog(@"updateLove failed");
    }
    [self close];
}


/*******************************************
 函数名称：-(MusicDb*)selecteLove
 函数功能：查询love
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(MusicDb*)selecteLove
{
    [self open];
    MusicDb* tmpMusicDb = [[MusicDb alloc]init];
    self.rs = [self.db executeQuery:@"select * from music where love = 1"];
    while ([self.rs next]) {
        
        NSString* urlstr = [self.rs stringForColumn:@"url"];
        NSURL* url = [NSURL URLWithString:urlstr];
        Music* tmpMusic = [[Music alloc]initUrl:url];
        //tmpMusic.url = [NSURL URLWithString:[self.rs stringForColumn:@"url"] ];
        tmpMusic.lrcpath = [self.rs stringForColumn:@"lrcpath"];
        tmpMusic.number = [NSNumber numberWithInt:[self.rs intForColumn:@"number"] ];
        if (1 == [self.rs intForColumn:@"recently"]) {
            tmpMusic.recently = YES;
        }else
        {
            tmpMusic.recently = NO;
        }
        //tmpMusic.recently = [self.rs intForColumn:@"recently"];
        if (1 == [self.rs intForColumn:@"love"]) {
            tmpMusic.love = YES;
        }else
        {
            tmpMusic.love = NO;
        }
        //tmpMusic.love = [self.rs intForColumn:@"love"];
        [tmpMusicDb addMusic:tmpMusic];
        [tmpMusic release];
    }
    return tmpMusicDb;
    [tmpMusicDb release];
    [self close];
}
/*******************************************
 函数名称：-(BOOL)insertLove:(Music*)aMusic
 函数功能：添加数据
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)insertLove:(Music*)aMusic
{
    [self open];    
    NSLog(@"%@",aMusic.url);
    
    if( [self.db executeUpdate:@"update  music set love = 1 where url = ?",[NSString stringWithFormat:@"%@",aMusic.url]])
    {
        NSLog(@"insert love seccessed");
        return YES;
    }else
    {
        NSLog(@"insert love failed");
        NSLog(@"%@",[self.db lastError]);
        return NO;
    }
    [self close];
    
}


/*******************************************
 函数名称：-(BOOL)deleteaNote:(Music*)aMusic
 函数功能：删除数据
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)deleteaNote:(Music*)aMusic
{
    [self open];
    [self.db executeUpdate:@"DELETE FROM music WHERE url = ?",[NSString stringWithFormat:@"%@",aMusic.url]]; 
    NSLog(@"删除成功");
    return YES;
    [self close];
}



/*******************************************
 函数名称：-(BOOL)deleteaAll
 函数功能：删除数据
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)deleteaAll
{
    
    [self open];    
    
    if ([self.db executeUpdate:@"drop  table music"]) {
        NSLog(@"delete all ok");
        
    }else
    {
        NSLog(@"delete all not ok");
    }
     [self close]; 
    return YES;
}
/*******************************************
 函数名称：-(BOOL)update:(Music*)aMusic
 函数功能：更新数据
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)update:(Music*)aMusic{
    int recently=0;
    int love=0;
    if (aMusic.recently==YES) {
        recently=1;
    }
    if (aMusic.love==YES) {
        love=1;
    }
    [self open];
    [self.db executeUpdate:@"UPDATE music SET recently=?, love=? WHERE url = ? ",[NSNumber numberWithInt: recently],[NSNumber numberWithInt:love],[aMusic.url absoluteString]]; 
    //[NSString stringWithFormat:@"%@",aMusic.url];
    //NSLog(@"%@",[NSString stringWithFormat:@"%@",aMusic.url]);
   // NSLog(@"sdf%@",[aMusic.url absoluteString]);
    //NSLog(@"更新成功");
    [self close];
    return YES;
}
/*******************************************
 函数名称：-(MusicDb*)selecteAll
 函数功能：查询所有数据
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(MusicDb*)selecteAll
{
    
    [self open];
    
   // NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];//建立一个自动释放池 pool
    //self.rs= [[FMResultSet alloc]init];
    self.rs=[self.db executeQuery:@"SELECT * FROM music"];
    MusicDb *musicDb=[[[MusicDb alloc]init]autorelease];
   // NSLog(@"----------%@",self.rs);

    while ([self.rs next])
    {
        NSString *urlSt=[self.rs stringForColumn:@"url"];
        NSString *lrcpathStr=[self.rs stringForColumn:@"lrcpath"];
        NSInteger number=[[self.rs stringForColumn:@"number"] integerValue];
        NSInteger recently=[[self.rs stringForColumn:@"recently"] integerValue];
        NSInteger love=[[self.rs stringForColumn:@"love"] integerValue];
        
        NSURL *url=[NSURL URLWithString:urlSt];
        
        Music *tmpMusic=[[Music alloc]initUrl:url];
        tmpMusic.lrcpath=lrcpathStr;
        tmpMusic.number=[NSNumber numberWithInteger:number];
        if (recently==1) {
            tmpMusic.recently=YES;
        }else{
            tmpMusic.recently=NO;
        }
        if (love==1) {
            tmpMusic.love=YES;
            //NSLog(@"该歌曲是被收藏的");
        }else{
            tmpMusic.love=NO;
        }
        //self.iMusicDb = [[MusicDb alloc]init];
        [musicDb addMusic:tmpMusic];   
        //NSLog(@"tmpMusic=%@",tmpMusic);
        [tmpMusic release];
        tmpMusic=nil;
    }
    
    NSLog(@"&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&%@",musicDb);
    
    return musicDb;
    //[pool drain];//开始销毁自动释放池
    [self close];
}

/*******************************************
 函数名称：-(BOOL)createNewTable:(NSString*)table
 函数功能：新建列表
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)createNewTable:(NSString*)table
{
       if ( [self.db  executeUpdate:@"CREATE TABLE new_table (key integer not null primary key autoincrement unique,url text,lrcpath text)"])
       {
           NSLog(@"create table ok");
           
       }else
       {
           NSLog(@"%@",[self.db lastErrorMessage]);
           NSLog(@"create not ok");
       }
    if ([self.db executeUpdate:@"alter table new_table rename to ?",table]) {
        NSLog(@"rename seccessed");
        return YES;
    }else
    {
         NSLog(@"%@",[self.db lastErrorMessage]);
        NSLog(@"rename failed");
    }
    return 1;
}

/*******************************************
 函数名称：-(BOOL)close
 函数功能：关闭数据库
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(BOOL)close
{
    return [self.db close];
    
}

/*******************************************
 函数名称：-(void)dealloc
 函数功能：析构方法
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
- (void)dealloc {
    [db release];
    [rs release];
    [iMusicDb release];
    [super dealloc];
}
@end
