//
//  JsonMusicsMode.h
//  OnlineMusicThree
//
//  Created by Blue on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonMusicMode.h"

@interface JsonMusicsMode : NSObject
/*
 result: "0",
 msg: "",
 totalnum: "28",
 curnum: "25",
 search: "发如雪",
 songlist: [
 */
@property(strong, nonatomic) NSMutableString *result;//未知
@property(strong, nonatomic) NSMutableString *msg;//未知
@property(strong, nonatomic) NSMutableString *totalnum;//未知
@property(strong, nonatomic) NSMutableString *curnum;//搜索结果数量
@property(strong, nonatomic) NSMutableString *search;//搜索的内容
@property(strong, nonatomic) NSMutableArray  *songlist;//歌曲列表

@end
