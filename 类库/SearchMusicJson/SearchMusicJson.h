//
//  SearchMusicJson.h
//  OnlineMusicThree
//
//  Created by Blue on 12-6-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface SearchMusicJson : NSObject
//根据传过来的搜索请求,返回Json数据,重点解决了GBK和UTF8的转换问题
+(NSString*)jsonResult:(NSString*)url;
@end
