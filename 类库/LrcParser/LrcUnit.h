/***************************************************
 文件名称：LrcUnit.h
 作   者：周晓栋
 备   注：歌词头文件
 创建时间：2012-6-6
 修改历史：
 版权声明：Copyright 2012 . All rights reserved.
 ***************************************************/
#import <Foundation/Foundation.h>

@interface LrcUnit : NSObject
@property (assign, nonatomic) double startTime;
@property (assign, nonatomic) double endTime;
@property (strong, nonatomic) NSMutableString *lrcUnitContent;
@end
