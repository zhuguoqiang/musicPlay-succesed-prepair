//
//  musicPlayAppDelegate.h
//  musicPlay
//
//  Created by student on 12-8-21.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class onlineMusicViewController;
@class MusicPlay;
@class FirstMusicTableView;
@class MusicDb;
@class MusicSqlite;
@interface musicPlayAppDelegate: NSObject <UIApplicationDelegate>
{
    UITabBarController* tab;
    
    MusicPlay* iMusicPlay;
    onlineMusicViewController *viewController;
    FirstMusicTableView* iFirstMusicTableView;
    
    MusicDb *iMusicDb;
    MusicSqlite *iMusicSqlite;
    NSString *path;
}
@property (nonatomic, retain)UITabBarController* tab;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) onlineMusicViewController *viewController;
@property (strong, nonatomic) MusicPlay* iMusicPlay;
@property (strong, nonatomic) FirstMusicTableView* iFirstMusicTableView;

@property (nonatomic,retain) MusicDb *iMusicDb;
@property (nonatomic,retain) MusicSqlite *iMusicSqlite;
@property (nonatomic,retain) NSString *path;
-(void)selectDb;
-(void)searchMusics;
@end
