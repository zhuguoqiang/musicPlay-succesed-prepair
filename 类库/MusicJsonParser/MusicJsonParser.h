//
//  MusicJsonParser.h
//  OnlineMusicThree
//
//  Created by Blue on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonMusicsMode.h"
#import "SearchMusicJson.h"
#import "JSONKit.h"

@interface MusicJsonParser : NSObject
@property (strong, nonatomic) SearchMusicJson *searchMusic;//搜索音乐对象
@property (strong, nonatomic) JsonMusicsMode *musicsJson;//Json模型对象
@property (strong, nonatomic) NSDictionary *JsonDic;//Json字典对象

-(void)Parser:(NSString*)search;//搜索并解析
@end
