/***************************************************
 文件名称：Write.h
 作   者：侯层层
 创建时间：2012-5-30
 修改历史：2012-6-13
 版权声明：3g csdn班
 ***************************************************/

#import <Foundation/Foundation.h>

@interface Write : NSObject <NSStreamDelegate>
{
    //路径
    NSString *parentDirectoryPath;
    
    //异步输出流
	NSOutputStream *asyncOutputStream;  
	
    //读出来的数据
    NSData *outputData; 
    
	NSRange outputRange;
    
    //返回去的数据 
	NSMutableArray *showarray;
    
}
@property (nonatomic, retain) NSMutableArray *showarray;
@property (nonatomic, retain) NSData *outputData;


/*******************************************
 函数名称：-(id)init;
 函数功能：初始化函数
 传入参数：无
 返回 值 ：无
 ********************************************/
-(id)init;

/*******************************************
 函数名称：-(id)initWithPath:(NSString*)_parentDirectoryPath;
 函数功能：构造函数
 传入参数：无
 返回 值 ：无
 ********************************************/
-(id)initWithPath:(NSString*)_parentDirectoryPath;

/*******************************************
 函数名称：- (void)resData;
 函数功能：写入数据
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)resData;
@end
