/***************************************************
 文件名称：Read.h
 作   者：侯层层
 创建时间：2012-5-30
 修改历史：2012-6-13
 版权声明：3g csdn班
 ***************************************************/

#import <Foundation/Foundation.h>


@interface Read : NSObject<NSStreamDelegate>
{
    //路径
    NSString *parentDirectoryPath;
    
    //返回去的数据 
	NSMutableArray *_array;
    
    //异步输出流
	NSInputStream *asyncInputStream;
    
    //读出来的数据
	NSMutableData *resultData;
    
    //判读是否读完
    NSString *read;
}
@property (nonatomic, retain) NSMutableData *resultData;
@property (nonatomic, retain) NSMutableArray *_array;
@property (nonatomic, retain) NSString *read;

/*******************************************
 函数名称：-(id)init;
 函数功能：初始化函数
 传入参数：无
 返回 值 ：无
 ********************************************/
- (id)init;

/*******************************************
 函数名称：-(id)initWithPath:(NSString*)_parentDirectoryPath;
 函数功能：构造函数
 传入参数：无
 返回 值 ：无
 ********************************************/
- (id)initWithPath:(NSString*)_parentDirectoryPath;

/*******************************************
 函数名称：- (void)good;
 函数功能：数据类型转换
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)good;

/*******************************************
 函数名称：- (void)resdstream;
 函数功能：读取数据
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)resdstream;

/*******************************************
 函数名称：- (void)appendData:(NSData*)_data;
 函数功能：读出来的数据追加到resultData上
 传入参数：_data
 返回 值 ：无
 ********************************************/
- (void)appendData:(NSData*)_data;

/*******************************************
 函数名称：- (NoteDb*)getNoteDb;
 函数功能：返回NoteDb对象
 传入参数：无
 返回 值 ：无
 ********************************************/
- (NSMutableArray*)getNoteDb;
@end
