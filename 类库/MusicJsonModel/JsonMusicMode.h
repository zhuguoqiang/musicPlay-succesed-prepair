//
//  JsonMusicMode.h
//  OnlineMusicThree
//
//  Created by Blue on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonMusicMode : NSObject
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
@property (strong, nonatomic) NSMutableString *idx;//当前歌曲在搜索列表中的索引
@property (strong, nonatomic) NSMutableString *song_id;//当前歌曲的ID
@property (strong, nonatomic) NSMutableString *song_name;//当前歌曲的名字
@property (strong, nonatomic) NSMutableString *album_name;//歌曲所属专辑的名字
@property (strong, nonatomic) NSMutableString *singer_name;//歌手名
@property (strong, nonatomic) NSMutableString *location;//歌曲所在服务器的位置
@property (strong, nonatomic) NSMutableString *singer_id;//歌手ID
@property (strong, nonatomic) NSMutableString *album_id;//专辑ID
@property (strong, nonatomic) NSMutableString *price;//未知,一个标量

@property (strong, nonatomic) NSMutableString *musicPath;//歌曲路径
@property (strong, nonatomic) NSMutableString *lrcPath;//歌词路径
@property (strong, nonatomic) NSMutableString *albumPath;//专辑封面

-(void)createPath;
-(void)downLrcAndAlbumImage;
@end
