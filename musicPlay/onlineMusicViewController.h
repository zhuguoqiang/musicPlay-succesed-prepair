//
//  onlineMusicViewController.h
//  onlineMusic
//
//  Created by student on 12-8-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "TableCell.h"
#import "Music.h"

@class TableCell;
@class MusicJsonParser;
@class AudioStreamer;
@class JsonMusicMode;
@class LrcParser;
@class AudioStreamer;
@class ASIHTTPRequest;
@class MusicListViewController;


@protocol pauseMusicDelegate <NSObject>

-(void)pause;

@end

@interface onlineMusicViewController : UIViewController<donwMusicDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    MusicListViewController *huancun;
    //主界面下的视图
    UISearchBar* searchView;
    UIView* playView;
    UITableView* listTable;
    UISlider* onlineMusicProgress;
    UILabel* onlineMusicProgressLabel;
    //playview 上的视图；
    UILabel* MusicTitle;
    UILabel* MusicArtist;
    UIImageView* playImageView;
    UIImageView* playVolum;
    UISlider* playSlider;
    UILabel* playVolumLabel;
    UIButton* playButton;
    
    TableCell* tmpCell;
    LrcParser* lrc;
    AVAudioPlayer* player;
    NSString* path;//沙盒路径，用于网络解析的歌词存储的
    AudioStreamer* iAudioStreamer;
    NSTimer *tick;
    
    UIView *progressBack;
    UILabel *progresstitle;
    UIProgressView* progressview;
    ASIHTTPRequest* httpRequest;
    UILabel *progresslabel;
    UILabel *baifen;
    
}

@property (nonatomic,assign)MusicListViewController *huancun;
@property (nonatomic,assign)id<pauseMusicDelegate>delegate;
@property (nonatomic,retain)UISearchBar* searchView;
@property (nonatomic,retain)UIView* playView;
@property (nonatomic,retain)UITableView* listTable;
//@property (nonatomic,retain)UIView* listView;
@property (nonatomic,retain)UISlider* onlineMusicProgress;
@property (nonatomic,retain)UILabel* onlineMusicProgressLabel;
@property (nonatomic,retain)UILabel* MusicTitle;
@property (nonatomic,retain)UILabel* MusicArtist;
@property (nonatomic,retain)UIImageView* playImageView;
@property (nonatomic,retain)UIImageView* playVolum;
@property (nonatomic,retain)UISlider* playSlider;
@property (nonatomic,retain)UILabel* playVolumLabel;
@property (nonatomic,retain)UIButton* playButton;
@property (nonatomic,retain)TableCell* tmpCell;
@property (nonatomic,retain)LrcParser* lrc;


@property (nonatomic,retain)MusicJsonParser *tmpParser;
@property (nonatomic,retain)AudioStreamer *audio;
@property (nonatomic,retain)JsonMusicMode *currentMusic;
@property (nonatomic,retain)NSMutableArray *songlist;
@property (nonatomic,retain)NSString *path;
@property (nonatomic,retain)NSTimer *tick;

@property (nonatomic,retain)UIView *progressBack;
@property (nonatomic,retain)UILabel *progresstitle;
@property (nonatomic,retain)UIProgressView *progressview;
@property (nonatomic,retain)ASIHTTPRequest* httpRequest;
@property (nonatomic,retain)UILabel *progresslabel;
@property (nonatomic,retain)UILabel *baifen;


-(void)buttonChange;
-(int)timeToInt:(double)tmptime;
-(NSString*)doubleToString:(double)tmptime;
-(void)nextMusic;
-(void)changeValum;
-(void)playMusic:(NSInteger)index;
-(void)downMusic:(UIButton*)sender;
-(void)tickit;
-(void)tickitPlay;
@end
