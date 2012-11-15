/***************************************************
 文件名称：LrcParser.m
 作   者：周晓栋
 备   注：解析歌词实现文件
 创建时间：2012-6-6
 修改历史：
 版权声明：Copyright 2012 . All rights reserved.
 ***************************************************/

/****************************使用方法*************************************************
 *      1)如果解析本地歌词,首先创建LrcParse对象,然后,设置lrcPath路径                        *
 *      2)执行parse方法解析歌词                                                        *
 *      3)根据标量finish判断是否解析完成,如果没有,外线程空转等待                             *
 *      (如果解析网络歌词,调用parserFoUrl方法,传递Url和保存路径)                            *
 ***********************************************************************************/

#import "LrcParser.h"
#import "LrcUnit.h"

@implementation LrcParser
@synthesize ti=_ti;//歌曲名
@synthesize ar=_ar;//歌手名
@synthesize al=_al;//所属专辑
@synthesize by=_by;//歌词编辑者
@synthesize offset=_offset;//整体偏移量,单位毫秒
@synthesize encoding=_encoding;//=编码方式
@synthesize la=_la;//语言
@synthesize fm=_fm;//音乐格式,文件类型说明
@synthesize wl=_wl;//作词
@synthesize wm=_wm;//作曲
@synthesize co=_co;//所属唱片公司
@synthesize ad=_ad;//国家和地区说明

@synthesize lrcs=_lrcs;//歌词单元s
@synthesize lrcsTmp=_lrcsTmp;//临时
@synthesize lrcPath=_lrcPath;//歌词的本地路径
@synthesize finish=_finish;//判断是否解析完成

@synthesize lrcUrlPath=_lrcUrlPath;

@synthesize tmpLrcData=_tmpLrcData;

//初始化方法
-(id)init{
    self=[super init];
    if (self) {
        _ti=[[NSMutableString alloc]init];
        _ar=[[NSMutableString alloc]init];
        _al=[[NSMutableString alloc]init];
        _by=[[NSMutableString alloc]init];
        _offset=[[NSMutableString alloc]init];
        _encoding=[[NSMutableString alloc]init];
        _la=[[NSMutableString alloc]init];
        _fm=[[NSMutableString alloc]init];
        _wl=[[NSMutableString alloc]init];
        _wm=[[NSMutableString alloc]init];
        _co=[[NSMutableString alloc]init];
        _ad=[[NSMutableString alloc]init];
        
        _lrcs=[[NSMutableArray alloc]init];
        _lrcsTmp=[[NSMutableArray alloc]init];
        _lrcPath=[[NSMutableString alloc]init];
        [_lrcPath setString:@""];
        
        _lrcUrlPath=[[NSMutableString alloc]init];
        
        _tmpLrcData=[[NSMutableData alloc]init];//歌词数据临时存储
        
        _finish=NO;
        
        return self;
    }
    return nil;
}
/*******************************************
 函数名称：-(NSInteger)lrcUnitIndex:(double)lrcUnit;
 函数功能：歌词所在位置
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSInteger)lrcUnitIndex:(double)lrcUnit{
    int gaga=0;
    for (int i=0;i<[self.lrcs count];i++) {
        if (((LrcUnit*)[self.lrcs objectAtIndex:i]).startTime<([self.offset doubleValue]/1000)+lrcUnit&&((LrcUnit*)[self.lrcs objectAtIndex:i]).endTime>([self.offset doubleValue]/1000)+lrcUnit) {
            gaga=i;
        }
    }
    return gaga;
}
/*******************************************
 函数名称：-(NSString*)lrcUnitContent:(double)lrcUnit;
 函数功能：所在位置的歌词
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSString*)lrcUnitContent:(double)lrcUnit{
    for (int i=0;i<[self.lrcs count];i++) {
        if (((LrcUnit*)[self.lrcs objectAtIndex:i]).startTime<([self.offset doubleValue]/1000)+lrcUnit&&((LrcUnit*)[self.lrcs objectAtIndex:i]).endTime>([self.offset doubleValue]/1000)+lrcUnit) {
            return ((LrcUnit*)[self.lrcs objectAtIndex:i]).lrcUnitContent;
        }
    }
    return @"";
}
/*******************************************
 函数名称：downLrc:(NSString*)lrcPath
 函数功能：下载歌词开始
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)downLrc:(NSString*)lrcPath{
    NSURL *url=[[NSURL alloc]initWithString:[lrcPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *req=[[NSURLRequest alloc]initWithURL:url];
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:req delegate:self];
    
    [url release];
    [req release];
    [connection release];
}
//要接收数据了,嘎嘎
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.tmpLrcData=nil;
    self.tmpLrcData=[[[NSMutableData alloc]init]autorelease];
}
//从网络上下载的数据,直到数据全部下载完成
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSMutableData *)data
{
	[self.tmpLrcData appendData:data];
}

//http交互正常，完成。
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.tmpLrcData writeToFile:self.lrcPath atomically:YES];
    NSLog(@"下载到歌词数据");
    
    self.offset=0;
    [self readLrc];//根据路径读取歌词文件
    [self tidy];//整理歌词文件,初步解析为array
    [self sort];//为整理之后的array排序
    [self setEndTime];//设置结束时间
}

//网络连接不成功，出现异常。
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"尼玛的,网络失败");
}
/*******************************************
 函数名称：-(void)parserFoUrl:(NSString*)url AndPath:(NSString*)path;
 函数功能：根据歌词路径下载歌词
 传入参数：url
 返回 值 ： N/A
 ********************************************/
-(void)parserFoUrl:(NSString*)url AndPath:(NSString*)path{
    [self.lrcPath setString:path];
    [self downLrc:url];
}

/*******************************************
 函数名称：-(void)parser
 函数功能：歌词解析
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)parser{
    self.offset=0;
    [self readLrc];//根据路径读取歌词文件
    [self tidy];//整理歌词文件,初步解析为array
    [self sort];//为整理之后的array排序
    [self setEndTime];//设置结束时间
}
/*******************************************
 函数名称：-(void)readLrc
 函数功能：读取歌词文件
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)readLrc{//读取歌词文件
    FILE *lrcFile=fopen([self.lrcPath UTF8String], "r");
    NSLog(@"读取歌词文件 本地路径 %@",self.lrcPath);
    char lrcUnit[500];
    while (fgets(lrcUnit, 100, lrcFile)) {
        lrcUnit[strlen(lrcUnit)-1]='\0';
        NSString *temp=[[NSString alloc]initWithCString:lrcUnit encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        [self.lrcsTmp addObject:[[[NSMutableString alloc]initWithString:[temp stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]]autorelease]];
        [temp release];
    }
    NSLog(@"11111111111");
    NSLog(@"lrcsTmp count is %d",[self.lrcsTmp count]);
}
/*******************************************
 函数名称：-(void)tidy
 函数功能：整理歌词文件,初步解析为array
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)tidy{//整理歌词文件,初步解析为array
    //解析特殊属性
    for (NSString *tmp in self.lrcsTmp){
        if ((tmp.length>4)&&[[tmp substringWithRange:NSMakeRange(1, 3)]isEqualToString:@"ti:"]) {
            //self.ti=[[NSMutableString alloc]initWithString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
            [self.ti setString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
            
        }
        if ((tmp.length>4)&&[[tmp substringWithRange:NSMakeRange(1, 3)]isEqualToString:@"ar:"]) {
            //self.ar=[[NSMutableString alloc]initWithString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
            [self.ar setString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
            
        }
        if ((tmp.length>4)&&[[tmp substringWithRange:NSMakeRange(1, 3)]isEqualToString:@"al:"]) {
            //self.al=[[NSMutableString alloc]initWithString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
            [self.al setString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
        }
        if ((tmp.length>4)&&[[tmp substringWithRange:NSMakeRange(1, 3)]isEqualToString:@"by:"]) {
            //self.by=[[NSMutableString alloc]initWithString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
            [self.by setString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
        }
        if ((tmp.length>8)&&[[tmp substringWithRange:NSMakeRange(1, 7)]isEqualToString:@"offset:"]) {
            //self.offset=[[NSMutableString alloc]initWithString:[tmp substringWithRange:NSMakeRange(8,tmp.length-9)]];
            [self.offset setString:[tmp substringWithRange:NSMakeRange(8,tmp.length-9)]];
        }
        if ((tmp.length>10)&&[[tmp substringWithRange:NSMakeRange(1, 9)]isEqualToString:@"encoding:"]) {
            //self.encoding=[[NSMutableString alloc]initWithString:[tmp substringWithRange:NSMakeRange(10,tmp.length-11)]];
            [self.encoding setString:[tmp substringWithRange:NSMakeRange(10,tmp.length-11)]];
        }
        if ((tmp.length>4)&&[[tmp substringWithRange:NSMakeRange(1, 3)]isEqualToString:@"la:"]) {
            //self.la=[[NSMutableString alloc]initWithString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
            [self.la setString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
        }
        if ((tmp.length>4)&&[[tmp substringWithRange:NSMakeRange(1, 3)]isEqualToString:@"fm:"]) {
            //self.fm=[[NSMutableString alloc]initWithString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
            [self.fm setString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
        }
        if ((tmp.length>4)&&[[tmp substringWithRange:NSMakeRange(1, 3)]isEqualToString:@"wl:"]) {
            //self.wl=[[NSMutableString alloc]initWithString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
            [self.wl setString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
        }
        if ((tmp.length>4)&&[[tmp substringWithRange:NSMakeRange(1, 3)]isEqualToString:@"wm:"]) {
            //self.wm=[[NSMutableString alloc]initWithString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
            [self.wm setString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
        }
        if ((tmp.length>4)&&[[tmp substringWithRange:NSMakeRange(1, 3)]isEqualToString:@"co:"]) {
            //self.co=[[NSMutableString alloc]initWithString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
            [self.co setString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
        }
        if ((tmp.length>4)&&[[tmp substringWithRange:NSMakeRange(1, 3)]isEqualToString:@"ad:"]) {
            //self.ad=[[NSMutableString alloc]initWithString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
            [self.ad setString:[tmp substringWithRange:NSMakeRange(4,tmp.length-5)]];
        }
    }//特殊属性解析完成
    //分析歌词单元
    NSMutableString *tmp=[[[NSMutableString alloc]init]autorelease];
    for (tmp in self.lrcsTmp){
        if (tmp.length>9&&[[tmp substringWithRange:NSMakeRange(6, 1)]isEqualToString:@"."]) {
            [self timeParser:[tmp substringWithRange:NSMakeRange(0, 10)] AndContent:tmp];
            
            tmp=[NSMutableString stringWithFormat:[tmp substringWithRange:NSMakeRange(10, tmp.length-10)]];
        //---------------------------------------------------------------------------------------------------------------------
            if (tmp.length>9&&[[tmp substringWithRange:NSMakeRange(6, 1)]isEqualToString:@"."]) {
                [self timeParser:[tmp substringWithRange:NSMakeRange(0, 10)] AndContent:tmp];
                
                tmp=[NSMutableString stringWithFormat:[tmp substringWithRange:NSMakeRange(10, tmp.length-10)]];
        //---------------------------------------------------------------------------------------------------------------------
                if (tmp.length>9&&[[tmp substringWithRange:NSMakeRange(6, 1)]isEqualToString:@"."]) {
                    [self timeParser:[tmp substringWithRange:NSMakeRange(0, 10)] AndContent:tmp];
                    
                    tmp=[NSMutableString stringWithFormat:[tmp substringWithRange:NSMakeRange(10, tmp.length-10)]];
        //---------------------------------------------------------------------------------------------------------------------
                    if (tmp.length>9&&[[tmp substringWithRange:NSMakeRange(6, 1)]isEqualToString:@"."]) {
                        [self timeParser:[tmp substringWithRange:NSMakeRange(0, 10)] AndContent:tmp];
                        
                        tmp=[NSMutableString stringWithFormat:[tmp substringWithRange:NSMakeRange(10, tmp.length-10)]];
                    }
                }
            }
        }
    }
    
    
}
/*******************************************
 函数名称：-(void)timeParser:(NSString*)time AndContent:(NSString*)content;
 函数功能：读取歌词解析歌词内容
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)timeParser:(NSString *)time AndContent:(NSString *)content{
    double t=[[time substringWithRange:NSMakeRange(1, 2)]intValue]*60+[[time substringWithRange:NSMakeRange(4, 5)] doubleValue];
    NSMutableString *tmp=[[[NSMutableString alloc]initWithString:content]autorelease];
    do {
        tmp=[NSMutableString stringWithString:[tmp substringWithRange:NSMakeRange(10, tmp.length-10)]];
    } while ([tmp rangeOfString:@"]"].location!=NSNotFound);
    
    LrcUnit *unit=[[LrcUnit alloc]init];
    unit.startTime=t;
    [unit.lrcUnitContent setString:tmp];
    [self.lrcs addObject:unit];
    [unit release];
}
/*******************************************
 函数名称：-(void)sort
 函数功能：歌词排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)sort{
    for (int i=0;i<[self.lrcs count];i++) {
        for (int j=0;j<[self.lrcs count]-1;j++) {
            if (((LrcUnit*)[self.lrcs objectAtIndex:j]).startTime>((LrcUnit*)[self.lrcs objectAtIndex:j+1]).startTime) {
                [self.lrcs exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
}
/*******************************************
 函数名称：-(void)setEndTime
 函数功能：设置结束时间
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)setEndTime{
    NSLog(@"setEndTime count %d",[self.lrcs count]);
    switch ([self.lrcs count]) {
        case 0:
            break;
        default:
            for (int j=0;j<[self.lrcs count]-1;j++) {
                ((LrcUnit*)[self.lrcs objectAtIndex:j]).endTime=((LrcUnit*)[self.lrcs objectAtIndex:j+1]).startTime;
                //NSLog(@"开始时间:%f\t歌词单元:%@",[((LrcUnit*)[self.lrcs objectAtIndex:j]) startTime],[((LrcUnit*)[self.lrcs objectAtIndex:j]) lrcUnitContent]);
            }
            ((LrcUnit*)[self.lrcs objectAtIndex:[self.lrcs count]-1]).endTime=((LrcUnit*)[self.lrcs objectAtIndex:[self.lrcs count]-1]).startTime+10;
            //NSLog(@"设置歌词的结束时间完成");   
            self.finish=YES;
            break;
    }
    
}
-(void)dealloc{
    if (_ti) {
        [_ti release];
    }
    if (_ar) {
        [_ar release];
    }
    if (_al) {
        [_al release];
    }
    if (_by) {
        [_by release];
    }
    if (_offset) {
        [_offset release];
    }
    if (_encoding) {
        [_encoding release];
    }
    if (_la) {
        [_la release];
    }
    if (_fm) {
        [_fm release];
    }
    if (_wl) {
        [_wl release];
    }
    if (_wm) {
        [_wm release];
    }
    if (_co) {
        [_co release];
    }
    if (_ad) {
        [_ad release];
    }
    if (_lrcs) {
        [_lrcs release];
    }
    if (_lrcsTmp) {
        [_lrcsTmp release];
    }
    if (_lrcPath) {
        [_lrcPath release];
    }
    if (_lrcUrlPath) {
        [_lrcUrlPath release];
    }
    if (_tmpLrcData) {
        [_tmpLrcData release];
    }
    
    [super dealloc];   
}
@end
