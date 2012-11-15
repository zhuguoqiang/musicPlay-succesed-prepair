/***************************************************
 文件名称：LrcParser.h
 作   者：周晓栋
 备   注：解析歌词头文件
 创建时间：2012-6-6
 修改历史：
 版权声明：Copyright 2012 . All rights reserved.
 ***************************************************/

/****************************使用方法*************************************************
 *      1)如果解析本地歌词,首先创建LrcParse对象,然后,设置lrcPath路径                        *
 *      2)执行parse方法解析歌词                                                        *
 *      3)根据标量finish判断是否解析完成,如果没有,外线程空转等待                             *
 *      (如果解析网络歌词,调用parserFoUrl方法,传递Url和保存路径)                            *
 ************************************************************************/

#import <Foundation/Foundation.h>

@interface LrcParser : NSObject
@property (strong, nonatomic) NSMutableString *ti;//歌曲名
@property (strong, nonatomic) NSMutableString *ar;//歌手名
@property (strong, nonatomic) NSMutableString *al;//所属专辑
@property (strong, nonatomic) NSMutableString *by;//歌词编辑者
@property (strong, nonatomic) NSMutableString *offset;//整体偏移量,单位毫秒
@property (strong, nonatomic) NSMutableString *encoding;//=编码方式
@property (strong, nonatomic) NSMutableString *la;//语言
@property (strong, nonatomic) NSMutableString *fm;//音乐格式,文件类型说明
@property (strong, nonatomic) NSMutableString *wl;//作词
@property (strong, nonatomic) NSMutableString *wm;//作曲
@property (strong, nonatomic) NSMutableString *co;//所属唱片公司
@property (strong, nonatomic) NSMutableString *ad;//国家和地区说明

@property (strong, nonatomic) NSMutableArray *lrcs;
@property (strong, nonatomic) NSMutableArray *lrcsTmp;
@property (strong, nonatomic) NSMutableString *lrcUrlPath;//如果设置为网络路径,需要先下载
@property (strong, nonatomic) NSMutableString *lrcPath;//歌词的本地路径
@property (nonatomic, assign) BOOL finish;//判断是否解析完成

@property (strong, nonatomic) NSMutableData *tmpLrcData;//歌词数据临时存储
/*******************************************
 函数名称：-(void)parserFoUrl:(NSString*)url AndPath:(NSString*)path;
 函数功能：根据歌词路径下载歌词
 传入参数：url
 返回 值 ： N/A
 ********************************************/
-(void)parserFoUrl:(NSString*)url AndPath:(NSString*)path;
/*******************************************
 函数名称：-(void)readLrc
 函数功能：读取歌词文件
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)readLrc;
/*******************************************
 函数名称：-(void)tidy
 函数功能：整理歌词文件,初步解析为array
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)tidy;
/*******************************************
 函数名称：-(void)timeParser:(NSString*)time AndContent:(NSString*)content;
 函数功能：读取歌词解析歌词内容
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)timeParser:(NSString*)time AndContent:(NSString*)content;
/*******************************************
 函数名称：-(void)sort
 函数功能：歌词排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)sort;
/*******************************************
 函数名称：-(void)setEndTime
 函数功能：设置结束时间
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)setEndTime;
/*******************************************
 函数名称：-(void)parser
 函数功能：歌词解析
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)parser;
/*******************************************
 函数名称：-(NSInteger)lrcUnitIndex:(double)lrcUnit;
 函数功能：歌词所在位置
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSInteger)lrcUnitIndex:(double)lrcUnit;
/*******************************************
 函数名称：-(NSString*)lrcUnitContent:(double)lrcUnit;
 函数功能：所在位置的歌词
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSString*)lrcUnitContent:(double)lrcUnit;
@end
