//
//  SearchMusicJson.m
//  OnlineMusicThree
//
//  Created by Blue on 12-6-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchMusicJson.h"

@implementation SearchMusicJson
//根据传过来的搜索请求,返回Json数据,重点解决了GBK和UTF8的转换问题
+(NSString*)jsonResult:(NSString*)url{
    
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:
                                      [NSURL URLWithString:
            [url stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]]];
    
    NSLog(@"请求搜索的链接%@",[NSURL URLWithString:
 [url stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]]);
    
    [request startSynchronous];
    if (![request error]) {
        NSString *response = [request responseString];
        char tmpResponse[([response length] + 1)];
        [response getCString:tmpResponse maxLength:([response length] + 1) encoding: NSISOLatin1StringEncoding];    

        //NSLog(@"\nJson数据%@\n",[[NSString stringWithCString:tmpResponse encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]  substringWithRange:NSMakeRange(15, [[NSString stringWithCString:tmpResponse encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]length]-17)]);
        
        return [[NSString stringWithCString:tmpResponse encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]  substringWithRange:NSMakeRange(15, [[NSString stringWithCString:tmpResponse encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]length]-17)];
    }
return [request error].description;
}
@end
