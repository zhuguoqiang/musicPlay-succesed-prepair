//
//  MusicListViewController.h
//  MusicPlayer2
//
//  Created by student on 12-8-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class MusicListTableCell;
@class FirstMusicTableView;
@class allTheMusicTable;
@class MusicDb;
@class Music;
@class MusicSqlite;
@interface MusicListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate>
{
    NSUInteger row; 
    MusicDb* imusicDb; 
}
@property(nonatomic, retain)UITableView *MusicListTable; //歌曲列表
@property(nonatomic, retain)MusicListTableCell *musicListTableCell; //自定义cell
@property(nonatomic, retain)UIButton *playbutton; //播放按钮
@property(nonatomic, retain)UIButton *paussbutton; //暂停按钮
@property(nonatomic, retain)UILabel *musicName; //歌曲名称
@property(nonatomic, retain)UILabel *musicArtist; //播放按钮
@property(nonatomic, retain)UILabel *upAndAllTime; //播放按钮
@property(nonatomic, retain)UIImageView *musicImage; //歌曲图片
//...............
@property(nonatomic, retain)NSMutableArray *listData; 
@property(nonatomic, retain)NSURL *musicpath; //歌曲地址
@property(nonatomic, retain)NSMutableArray *tmpPath;

//..............
@property(nonatomic, retain)AVAudioPlayer *musicPlayer;
@property(nonatomic, retain)FirstMusicTableView *iFirstMusicTableView;
@property(nonatomic, retain)UITableView *moreActionTable;
@property(nonatomic, retain)UILabel *titlelabel;
@property(nonatomic, retain)NSMutableArray *moreActionArray;
@property(nonatomic, retain)UIView *MusicMessageView;
@property(nonatomic, retain)UILabel *musicNameLabel;
@property(nonatomic, retain)UILabel *musicTimeLabel;
@property(nonatomic, retain)UILabel *musicPathLabel;
@property(nonatomic, retain)UILabel *musicArtistLabel;
@property(nonatomic, retain)UILabel *musicAlbumLabel;

@property(nonatomic)NSInteger tmpIndex;

@property(nonatomic, retain)allTheMusicTable *iallTheMusicTable;
@property(nonatomic, retain)MusicDb* imusicDb;
@property(nonatomic, retain)Music* tmpMusic;
@property(nonatomic, retain)MusicSqlite* ms;

/*******************************************
 函数名称：-(void)play
 函数功能：播放按钮 调用的方法
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)play;

/*******************************************
 函数名称：-(void)playAction
 函数功能：实现播放功能
 传入参数/Users/student/Desktop/MusicPlayer2.0/MusicPlayer2/MusicListViewController.m：无
 返回 值 ：无
 ********************************************/
-(void)playAction;

/*******************************************
 函数名称：-(void)pauss
 函数功能：暂停按钮，实现暂停
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)pauss;

/*******************************************
 函数名称：-(void)jumpUp
 函数功能：上一首按钮，实现跳转
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)jumpUp;

/*******************************************
 函数名称：-(void)jumpDown
 函数功能：下一首按钮，实现跳转
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)jumpDown;

/*******************************************
 函数名称：-(void)backFirstView
 函数功能：返回（九宫格）界面，实现跳转
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)backFirstView;

/*******************************************
 函数名称：-(void)jumpPlayView
 函数功能：跳转到播放界面
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)jumpPlayView;

/*******************************************
 函数名称：-(void)sortMusic
 函数功能：歌曲排序
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)sortMusic;

/*******************************************
 函数名称：-(void)reloadView
 函数功能：刷新界面
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)reloadView;

/*******************************************
 函数名称：-(void)AddMusic
 函数功能：添加音乐
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)AddMusic;

/*******************************************
 函数名称：-(void)jumpPlayView;
 函数功能：跳转到播放界面
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)jumpPlayView;

/*******************************************
 函数名称：-(void)musicMessageAction
 函数功能：关闭歌曲信息界面
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)musicMessageAction;


@end
