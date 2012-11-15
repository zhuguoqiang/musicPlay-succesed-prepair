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

@interface MusicListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate>
{
    NSUInteger row;
    NSString *tmpMusicName;
    NSString *tmpMusicPath;
}
@property(nonatomic, retain)UITableView *MusicListTable;
@property(nonatomic, retain)MusicListTableCell *musicListTableCell;
@property(nonatomic, retain)UIButton *playbutton;
@property(nonatomic, retain)UIButton *paussbutton;
@property(nonatomic, retain)UILabel *musicName;
@property(nonatomic, retain)UILabel *musicArtist;
@property(nonatomic, retain)UILabel *upAndAllTime;
@property(nonatomic, retain)UIImageView *musicImage;
//...............
@property(nonatomic, retain)NSMutableArray *listData;
@property(nonatomic, retain)NSString *musicpath;
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
 传入参数：无
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
//-(void)reloadView;
-(void)jumpPlayView;

/*******************************************
 函数名称：-(void)musicMessageAction
 函数功能：关闭歌曲信息界面
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)musicMessageAction;


@end
