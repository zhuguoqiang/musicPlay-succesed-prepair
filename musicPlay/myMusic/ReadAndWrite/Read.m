/***************************************************
 文件名称：Read.m
 作   者：侯层层
 创建时间：2012-5-30
 修改历史：2012-6-13
 版权声明：3g csdn班
 ***************************************************/

#import "Read.h"

@implementation Read
@synthesize _array=__array,resultData;
@synthesize read;


/*******************************************
 函数名称：-(id)init;
 函数功能：初始化函数
 传入参数：无
 返回 值 ：无
 ********************************************/
-(id)init{
    
    self=[super init];
    if (!self) {
        return nil;
    }
    self._array = [[[NSMutableArray alloc]init]autorelease];
    resultData= [[NSMutableData alloc]init];
    return self;
}

/*******************************************
 函数名称：-(id)initWithPath:(NSString*)_parentDirectoryPath;
 函数功能：构造函数
 传入参数：无
 返回 值 ：无
 ********************************************/
-(id)initWithPath:(NSString*)_parentDirectoryPath {
    
    self=[super init];
    if (!self) {
        return nil;
    }
    
    parentDirectoryPath=_parentDirectoryPath;
    
    return self;
}

/*******************************************
 函数名称：- (void)resdstream;
 函数功能：读取数据
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)resdstream
{    
    read = @"NO";
    NSMutableData *data = [[NSMutableData alloc]init];
    [self.resultData setData:data];
    [data release];
    [asyncInputStream release];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    
    
    //NSLog(@"%@",documentPath);
    parentDirectoryPath = [documentPath stringByAppendingPathComponent:@"All.txt"];
    
	// open a stream to filePath
	asyncInputStream =
	[[NSInputStream alloc] initWithFileAtPath: parentDirectoryPath];
	[asyncInputStream setDelegate: self];
	[asyncInputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
								forMode:NSDefaultRunLoopMode];
	[asyncInputStream open];
    
}

/*******************************************
 函数名称：- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent 
 函数功能：回调方法，不停的执行 读取数据
 传入参数：theStream ，streamEvent
 返回 值 ：无
 ********************************************/
- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent 
{
	NSInputStream *inputStream = (NSInputStream*) theStream;
    
	switch (streamEvent) 
    {
		case NSStreamEventHasBytesAvailable: 
		{ 			
            NSInteger maxLength = 128; 
			uint8_t readBuffer [maxLength]; 
			NSInteger bytesRead = [inputStream read: readBuffer 
										  maxLength:maxLength];
			if (bytesRead > 0) 
			{
				NSData *bufferData = [[NSData alloc]
									  initWithBytesNoCopy:readBuffer 
									  length:bytesRead 
									  freeWhenDone:NO];
				
				[self appendData:bufferData];
				
				[bufferData release];
			}
			break;
		} 
		case NSStreamEventErrorOccurred: 
		{
			
			NSError *error = [theStream streamError];
			if (error != NULL) 
			{
				UIAlertView *errorAlert = [[UIAlertView alloc]
										   initWithTitle: [error localizedDescription]
										   message: [error localizedFailureReason]
										   delegate:nil
										   cancelButtonTitle:@"OK"
										   otherButtonTitles:nil];
				[errorAlert show];
				[errorAlert release];
			}
			
			[inputStream removeFromRunLoop: [NSRunLoop currentRunLoop] 
								   forMode:NSDefaultRunLoopMode];
			[theStream close];
			break;
		}
		case NSStreamEventEndEncountered: 
		{
			[inputStream removeFromRunLoop: [NSRunLoop currentRunLoop] 
								   forMode:NSDefaultRunLoopMode];
			
			[self good];
            read = @"YES";
			
			[theStream close];
		}
	}
}

/*******************************************
 函数名称：- (void)good;
 函数功能：数据类型转换
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)good
{
    self._array=[NSKeyedUnarchiver unarchiveObjectWithData:resultData];
}

/*******************************************
 函数名称：- (NoteDb*)getNoteDb;
 函数功能：返回NoteDb对象
 传入参数：无
 返回 值 ：无
 ********************************************/
- (NSMutableArray*)getNoteDb{ 
    return self._array;
}

/*******************************************
 函数名称：- (void)appendData:(NSData*)_data;
 函数功能：读出来的数据追加到resultData上
 传入参数：_data
 返回 值 ：无
 ********************************************/
- (void)appendData:(NSData*)_data
{
    [resultData appendData:_data];
}

/*******************************************
 函数名称：-(void)dealloc
 函数功能：析构函数
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)dealloc
{
    [self._array release];
    [resultData release];
    [super dealloc];
}
@end
