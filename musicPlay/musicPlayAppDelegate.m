
#import "musicPlayAppDelegate.h"

#import "FirstMusicTableView.h"
#import "musicPlayerViewController.h"
#import "onlineMusicViewController.h"

#import "MusicDb.h"
#import "MusicSqlite.h"

#define DBName @"/musicDb.db"

@interface musicPlayAppDelegate()
{
    musicPlayerViewController *_musicPlayController;  //播放器
    onlineMusicViewController *_onLineMusicController; //在线播放
    FirstMusicTableView *_firstMusicTableView;         //我的音乐
    
    MusicDb *_musicDb;
    MusicSqlite *_musicSqlite;
    NSString *_path;
}

@property (nonatomic, strong) UITabBarController *tabBarController;
@property (strong, nonatomic) onlineMusicViewController *onLineMusicController;
@property (strong, nonatomic) musicPlayerViewController *musicPlayerController;
@property (strong, nonatomic) FirstMusicTableView *firstMusicTableView;

@property (nonatomic,retain) MusicDb *musicDb;
@property (nonatomic,retain) MusicSqlite *musicSqlite;
@property (nonatomic,retain) NSString *path;

@end


@implementation musicPlayAppDelegate

@synthesize window = _window;

@synthesize musicPlayerController = _musicPlayController;
@synthesize onLineMusicController = _onLineMusicController;
@synthesize firstMusicTableView = _firstMusicTableView;

@synthesize musicDb = _musicDb;
@synthesize musicSqlite = _musicSqlite;
@synthesize path = _path;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 在线播放
    self.onLineMusicController = [[onlineMusicViewController alloc]init];
    self.onLineMusicController.title = @"在线播放";
    UINavigationController* nav1 = [[UINavigationController alloc]initWithRootViewController:self.onLineMusicController];
    
    // 播放器
    self.musicPlayerController = [[musicPlayerViewController alloc]init];
    self.musicPlayerController.title = @"播放器";
    UINavigationController* nav2 = [[UINavigationController alloc]initWithRootViewController:self.musicPlayerController];
    
    // 我的音乐
    self.firstMusicTableView = [[FirstMusicTableView alloc]init];
    self.firstMusicTableView.title = @"我的音乐";
    UINavigationController* nav3 = [[UINavigationController alloc]initWithRootViewController:self.firstMusicTableView];

    NSArray* tmp = [NSArray arrayWithObjects:nav1, nav2, nav3, nil];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = tmp;
 
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    [nav1 release];
    [nav2 release];
    [nav3 release];
    return YES;
}


-(void)selectDb
{
    //把数据库里所有的数据都查询出来
    [self.musicDb removeALLMusic];
    self.musicDb = [self.musicSqlite selecteAll];
}

- (void)searchMusics
{
    NSString *searchPaths = NSHomeDirectory();
    
    NSArray *array = [[NSFileManager defaultManager]directoryContentsAtPath:searchPaths];
   
    for (NSString* file in array)
    {
        if([file hasSuffix:@"mp3"])
        {
            NSURL *url = [[NSURL alloc]initFileURLWithPath:[NSString stringWithFormat:@"%@/%@",searchPaths,file]];
            
            Music *music = [[Music alloc]initWithUrl:url];
            
            music.name = [file substringToIndex:[file length]-4];
            
            //如果是音乐文件就写到数据库里面
            [self.musicSqlite insert:music];
        }
    }
}


- (void)dealloc
{
    self.tabBarController = nil;
    self.path = nil;
    self.musicDb = nil;
    self.musicSqlite = nil;
    [_window release];
    [super dealloc];
}

@end
