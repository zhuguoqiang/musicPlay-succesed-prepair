/***************************************************
 文件名称：LrcUnit.m
 作   者：周晓栋
 备   注：歌词实现文件
 创建时间：2012-6-6
 修改历史：
 版权声明：Copyright 2012 . All rights reserved.
 ***************************************************/
#import "LrcUnit.h"

@implementation LrcUnit
@synthesize startTime=_startTime;
@synthesize endTime=_endTime;
@synthesize lrcUnitContent=_lrcUnitContent;
-(id)init{
    self=[super init];
    if (self) {
        _lrcUnitContent=[[NSMutableString alloc]init];
        return self;
    }
    return nil;
}
-(void)dealloc{
    if (_lrcUnitContent) {
        [_lrcUnitContent release];
    }
    [super dealloc];
}
@end
