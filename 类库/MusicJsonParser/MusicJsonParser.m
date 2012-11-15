//
//  MusicJsonParser.m
//  OnlineMusicThree
//
//  Created by Blue on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
/*
 {
 result: "0",
 msg: "",
 totalnum: "28",
 curnum: "25",
 search: "发如雪",
 songlist: [
 {
 idx: "1",
 song_id: "1264666",
 song_name: "发如雪",
 album_name: "聆听发烧 纯美女声",
 singer_name: "雷丽",
 location: "6",
 singer_id: "6149",
 album_id: "104586",
 price: "250"
 },
 
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

#import "MusicJsonParser.h"

@implementation MusicJsonParser
/*
 SearchMusicJson *searchMusic;
 JsonMusicsMode *MusicsJson;
 NSDictionary *JsonDic;
*/
@synthesize searchMusic=_searchMusic;//发送请求,返回Json
@synthesize JsonDic=_JsonDic;//Json生成字典
@synthesize musicsJson=_musicsJson;//Json的模型数据
-(id)init{
    if (self=[super init]) {
        _searchMusic=[[SearchMusicJson alloc]init];
        _musicsJson=[[JsonMusicsMode alloc]init];
        return self;
    }
    return nil;
}

-(void)dealloc{
    [_searchMusic release];
    [_musicsJson release];
    [super dealloc];
}

-(void)Parser:(NSString*)search{
    NSString *tmpString=[[NSString alloc]initWithString:[SearchMusicJson jsonResult:[NSString stringWithFormat:@"http://shopcgi.qqmusic.qq.com/fcgi-bin/shopsearch.fcg?value=%@",search]]];
    tmpString=[tmpString stringByReplacingOccurrencesOfString:@"{" withString:@"{\""];
    tmpString=[tmpString stringByReplacingOccurrencesOfString:@"\"," withString:@"\",\""];
    tmpString=[tmpString stringByReplacingOccurrencesOfString:@":\"" withString:@"\":\""];
    tmpString=[tmpString stringByReplacingOccurrencesOfString:@":[" withString:@"\":["];
    self.JsonDic=[tmpString objectFromJSONString];
    //[tmpString release];
    
    [self.musicsJson.result setString:[self.JsonDic objectForKey:@"result"]];
    [self.musicsJson.msg setString:[self.JsonDic objectForKey:@"msg"]];
    [self.musicsJson.totalnum setString:[self.JsonDic objectForKey:@"totalnum"]];
    [self.musicsJson.curnum setString:[self.JsonDic objectForKey:@"curnum"]];
    [self.musicsJson.search setString:[self.JsonDic objectForKey:@"search"]];
    
    for (NSDictionary *tmp in [self.JsonDic objectForKey:@"songlist"]) {
        JsonMusicMode *tmpJsonMusicMode=[[JsonMusicMode alloc]init];
        [tmpJsonMusicMode.idx setString:[tmp objectForKey:@"idx"]];
        [tmpJsonMusicMode.song_id setString:[tmp objectForKey:@"song_id"]];
        [tmpJsonMusicMode.song_name setString:[tmp objectForKey:@"song_name"]];
        [tmpJsonMusicMode.album_name setString:[tmp objectForKey:@"album_name"]];
        [tmpJsonMusicMode.singer_name setString:[tmp objectForKey:@"singer_name"]];
        [tmpJsonMusicMode.location setString:[tmp objectForKey:@"location"]];
        [tmpJsonMusicMode.singer_id setString:[tmp objectForKey:@"singer_id"]];
        [tmpJsonMusicMode.album_id setString:[tmp objectForKey:@"album_id"]];
        [tmpJsonMusicMode.price setString:[tmp objectForKey:@"price"]];
        [tmpJsonMusicMode createPath];
        [self.musicsJson.songlist addObject:tmpJsonMusicMode];
        [tmpJsonMusicMode release];
    }
    NSLog(@"\n详细数据%@\n",self.musicsJson);
}
@end
