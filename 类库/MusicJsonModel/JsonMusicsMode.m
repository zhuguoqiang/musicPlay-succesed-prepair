//
//  JsonMusicsMode.m
//  OnlineMusicThree
//
//  Created by Blue on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "JsonMusicsMode.h"

@implementation JsonMusicsMode
/*
 *result;//未知
 *msg;//未知
 *totalnum;//未知
 *curnum;//搜索结果数量
 *search;//搜索的内容
 *songlist;//歌曲列表
 */
@synthesize result=_result;
@synthesize msg=_msg;
@synthesize totalnum=_totalnum;
@synthesize curnum=_curnum;
@synthesize search=_search;
@synthesize songlist=_songlist;

-(id)init{
    if (self=[super init]) {
        _result=[[NSMutableString alloc]init];
        _msg=[[NSMutableString alloc]init];
        _totalnum=[[NSMutableString alloc]init];
        _curnum=[[NSMutableString alloc]init];
        _search=[[NSMutableString alloc]init];
        _songlist=[[NSMutableArray alloc]init];
        return self;
    }
    return nil;
}

-(void)dealloc{
    [_result release];
    [_msg release];
    [_totalnum release];
    [_curnum release];
    [_search release];
    [_songlist release];
    [super dealloc];
    
}

-(NSString *)description{
    NSLog(@"\n搜索列表的详情\n");
    NSLog(@"搜索内容为:\t%@\n",self.search);
    NSLog(@"共搜索到\t%@条结果\n",self.curnum);
    for (JsonMusicMode *tmp in self.songlist) {
        NSLog(@"%@",tmp.description);
    }
    return [NSString stringWithFormat:@"\n搜索列表的详情输出完毕\n"];
}
@end
