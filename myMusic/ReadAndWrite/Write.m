/***************************************************
 文件名称：Write.m
 作   者：侯层层
 创建时间：2012-5-30
 修改历史：2012-6-13
 版权声明：3g csdn班
 ***************************************************/

#import "Write.h"

@implementation Write
@synthesize showarray,outputData;

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
    
    outputData=[[NSData alloc]init];
    showarray=[[NSMutableArray alloc]init];
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
 函数名称：- (void)resData;
 函数功能：写入数据
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)resData
{
    [asyncOutputStream release];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    

    //NSLog(@"%@",documentPath);
    parentDirectoryPath = [documentPath stringByAppendingPathComponent:@"All.txt"];
    
	NSData *tmpdata = [NSKeyedArchiver archivedDataWithRootObject:self.showarray];
        
	outputData = [[NSData alloc]init];
	
    self.outputData = tmpdata;	
    
	outputRange.location = 0; 
	NSLog(@"parentDirectoryPath is %@",parentDirectoryPath);
	
	[[NSFileManager defaultManager] createFileAtPath:parentDirectoryPath
											contents:nil attributes:nil];
	
	asyncOutputStream =	[[NSOutputStream alloc] initToFileAtPath: parentDirectoryPath append: NO];
    
	[asyncOutputStream setDelegate: self]; 
	[asyncOutputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] 
								 forMode:NSDefaultRunLoopMode];
    
	[asyncOutputStream open]; 
}

/*******************************************
 函数名称：- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent 
 函数功能：回调方法，不停的执行 写入数据
 传入参数：theStream ，streamEvent
 返回 值 ：无
 ********************************************/
//START:code.FilesystemExplorer.async-file-save-delegate
- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent 
{
    NSOutputStream *outputStream = (NSOutputStream*) theStream;
    BOOL shouldClose = NO;
    switch (streamEvent) 
    {
        case NSStreamEventHasSpaceAvailable:
        {
            uint8_t outputBuf [1]; 
            outputRange.length = 1;
            [outputData getBytes:&outputBuf range:outputRange]; 
            [outputStream write: outputBuf maxLength: 1]; 
            if (++outputRange.location == [outputData length]) 
            {  
                shouldClose = YES;
            }
            break;
        }
        case NSStreamEventErrorOccurred:
        {
            // dialog the error
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
            shouldClose = YES;
            break;
        }
        case NSStreamEventEndEncountered:
            shouldClose = YES;
    }
    if (shouldClose)
    {
        [outputStream removeFromRunLoop: [NSRunLoop currentRunLoop]                                  forMode:NSDefaultRunLoopMode];
        [theStream close];     
    }
}

/*******************************************
 函数名称：-(void)dealloc 
 函数功能：析构函数
 传入参数：theStream ，streamEvent
 返回 值 ：无
 ********************************************/
-(void)dealloc{
    [outputData release];
    [showarray release];
    [super dealloc];
}   

@end
