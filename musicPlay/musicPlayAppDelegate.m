
#import "musicPlayAppDelegate.h"

#import "FirstMusicTableView.h"
#import "MusicPlay.h"
#import "onlineMusicViewController.h"
#import "MusicDb.h"
#import "MusicSqlite.h"
#define DBName @"/musicDb.db"
@implementation musicPlayAppDelegate

@synthesize tab;
@synthesize window = _window;

@synthesize iMusicPlay;
@synthesize viewController;
@synthesize iFirstMusicTableView;

@synthesize iMusicDb;
@synthesize iMusicSqlite;
@synthesize path;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 在线播放功能
    self.viewController = [[onlineMusicViewController alloc]init]; 
    self.viewController.title = @"在线播放";
    UINavigationController* nav1 = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    nav1.title = @"在线播放";
    
    //播放器界面
    self.iMusicPlay = [[MusicPlay alloc]init];
    self.iMusicPlay.title = @"播放器";
    UINavigationController* nav2 = [[UINavigationController alloc]initWithRootViewController:self.iMusicPlay];
    nav2.title = @"播放器";
    
    //我的音乐界面
    self.iFirstMusicTableView = [[FirstMusicTableView alloc]init];
    self.iFirstMusicTableView.title = @"我的音乐";
    //self.iFirstMusicTableView.musicplay = self.iMusicPlay;
    UINavigationController* nav3 = [[UINavigationController alloc]initWithRootViewController:self.iFirstMusicTableView];
    nav3.title = @"我的音乐";

    
    NSArray* tmp = [NSArray arrayWithObjects:nav1,nav2,nav3, nil];
    self.tab = [[[UITabBarController alloc]init]autorelease];
    self.tab.viewControllers = tmp;
 
    
    self.window.rootViewController = self.tab;
    [self.window makeKeyAndVisible];
    [nav1 release];
    [nav2 release];
    [nav3 release];
    return YES;
}
/*
-(void)selectDb
{
    //把数据库里所有的数据都查询出来
    [self.iMusicDb removeALLMusic];
    self.iMusicDb=[self.iMusicSqlite selecteAll];
}
- (void)searchMusics
{
    NSString *searchPaths =NSHomeDirectory();
    NSLog(@"%@",searchPaths);
    NSArray *array=[[NSFileManager defaultManager]directoryContentsAtPath:searchPaths];
    NSLog(@"%@",array);
    for (NSString* file in array)
    {
        if([file hasSuffix:@"mp3"])
        {
            NSLog(@"%@是音乐文件",file);
            NSURL *url=[[NSURL alloc]initFileURLWithPath:[NSString stringWithFormat:@"%@/%@",searchPaths,file]];
            NSLog(@"url===%@",url);
            
            Music *music=[[Music alloc]initUrl:url];
            music.name=[file substringToIndex:[file length]-4];
            NSLog(@"name%@",music.name);
            //如果是音乐文件就写到数据库里面
            [self.iMusicSqlite insert:music];
        }
    }
}
 */
- (void)dealloc
{
    self.tab=nil;
    self.path=nil;
    self.iMusicDb=nil;
    self.iMusicSqlite=nil;
    [_window release];
    [super dealloc];
}
@end
