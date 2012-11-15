//
//  JsonMusicMode.m
//  OnlineMusicThree
//
//  Created by Blue on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "JsonMusicMode.h"
#import "ASIHTTPRequest.h"

@implementation JsonMusicMode
/*
 idx: "1",
 song_id: "1264666",
 song_name: "发如雪",
 album_name: "聆听发烧 纯美女声",
 singer_name: "雷丽",
 location: "6",
 singer_id: "6149",
 album_id: "104586",
 price: "250"
 */
@synthesize idx=_idx;
@synthesize song_id=_song_id;
@synthesize song_name=_song_name;
@synthesize album_name=_album_name;
@synthesize singer_name=_singer_name;
@synthesize location=_location;
@synthesize singer_id=_singer_id;
@synthesize album_id=_album_id;
@synthesize price=_price;

@synthesize musicPath=_musicPath;
@synthesize lrcPath=_lrcPath;
@synthesize albumPath=_albumPath;

-(id)init{
    if (self=[super init]) {
        _idx=[[NSMutableString alloc]init];
        _song_id=[[NSMutableString alloc]init];
        _song_name=[[NSMutableString alloc]init];
        _album_name=[[NSMutableString alloc]init];
        _singer_name=[[NSMutableString alloc]init];
        _location=[[NSMutableString alloc]init];
        _singer_id=[[NSMutableString alloc]init];
        _album_id=[[NSMutableString alloc]init];
        _price=[[NSMutableString alloc]init];
        
        _musicPath=[[NSMutableString alloc]init];
        _lrcPath=[[NSMutableString alloc]init];
        _albumPath=[[NSMutableString alloc]init];
        return self;
    }
    return nil;
}

-(void)dealloc{
    [_idx release];
    [_song_id release];
    [_song_name release];
    [_album_name release];
    [_singer_name release];
    [_location release];
    [_singer_id release];
    [_album_id release];
    [_price release];
    
    [_musicPath release];
    [_lrcPath release];
    [_albumPath release];
    [super dealloc];
}

-(NSString *)description{
    /*
     *idx;//当前歌曲在搜索列表中的索引
     *song_id;//当前歌曲的ID
     *song_name;//当前歌曲的名字
     *album_name;//歌曲所属专辑的名字
     *singer_name;//歌手名
     *location;//歌曲所在服务器的位置
     *singer_id;//歌手ID
     *album_id;//专辑ID
     *price;//未知,一个标量
     */
    return [NSString stringWithFormat:@"\n列表中的索引:\t%@\n歌曲ID:\t%@\n歌曲名字:\t%@\n所属专辑名:\t%@\n歌手名:\t%@\n在服务器上的位置:\t%@\n歌手ID:\t%@\n专辑ID:\t%@\n一个标量:\t%@\n歌曲路径:\t%@\n歌词路径:\t%@\n封面路径:\t%@",
            self.idx,self.song_id,self.song_name,self.album_name,self.singer_name,self.location,self.singer_id,self.album_id,self.price,self.musicPath,self.lrcPath,self.albumPath];
}

-(void)createPath{
    [self.musicPath setString:[NSString stringWithFormat:@"http://stream%@.qqmusic.qq.com/3%@.mp3",self.location.length==1?[NSString stringWithFormat:@"1%@",self.location]:[NSString stringWithFormat:@"%@",self.location],self.song_id.length==7?self.song_id:[NSString stringWithFormat:@"0%@",self.song_id]]];
    [self.lrcPath setString:[NSString stringWithFormat:@"http://music.qq.com/miniportal/static/lyric/%d/%@.xml",[self.song_id intValue]%100,self.song_id]];      

    [self.albumPath setString:[NSString stringWithFormat:@"http://imgcache.qq.com/music/photo/album/%d/albumpic_%@_0.jpg",[self.album_id intValue]%100,self.album_id]];
}

-(void)downLrcAndAlbumImage{
    NSString *tmpLrcPath=[NSString stringWithFormat:@"%@/tmp/%@.lrc",NSHomeDirectory(),self.song_id];
    if(![[NSFileManager defaultManager]isExecutableFileAtPath:tmpLrcPath]){
        ASIHTTPRequest *requestLrc=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:self.lrcPath]];
        [requestLrc setDownloadDestinationPath:tmpLrcPath];
        requestLrc.useCookiePersistence=YES;
        [requestLrc startSynchronous];
    }
    
    NSString *tmpAlbumPath=[NSString stringWithFormat:@"%@/tmp/%@.jpg",NSHomeDirectory(),self.album_id];
    if(![[NSFileManager defaultManager]isExecutableFileAtPath:tmpAlbumPath]){
        ASIHTTPRequest *requestAlbum=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:self.albumPath]];
        [requestAlbum setDownloadDestinationPath:tmpAlbumPath];
        requestAlbum.useCookiePersistence=YES;
        [requestAlbum startSynchronous];
    }
}

@end
