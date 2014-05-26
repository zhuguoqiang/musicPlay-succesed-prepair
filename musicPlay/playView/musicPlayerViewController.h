//
//  musicPlayerViewController.h
//  MusicPlay
//
//  Created by student on 12-8-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LrcParser.h"
#import "Music.h"
#import "MusicDb.h"
#import <AVFoundation/AVFoundation.h>

@class OKview;
@class MyView;
@class VolVIew;

@interface musicPlayerViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate,UIScrollViewDelegate>
{
    int ishandorsys;      //判断是 手动滑动的还是代码滑动的
    int playmodel;//单曲循环 0 ，列表循环 1，顺序播放 2，随机播放 3。
    BOOL doplay; //确定当手指滑动完后歌曲是否继续播放
    float currentTime;//最后播放的时间
}

@property (retain, nonatomic) UITableView *table;//右边的歌词
@property (retain, nonatomic) LrcParser *lrc;//歌词解析
@property (retain, nonatomic) AVAudioPlayer *player;//
@property (retain, nonatomic) UISlider *slider;//播放进度
@property (retain, nonatomic) UIButton *playbutton;//播放按钮
@property (retain, nonatomic) UILabel *rightLabel;//音乐时间
@property (retain, nonatomic) UILabel *leftLabel;//当前播放的时间
@property (retain, nonatomic) UIImageView *imageview;//歌曲的图片
@property (retain, nonatomic) VolVIew *slider_volum;//音量
@property (retain, nonatomic) MyView *gecilabel1;//经典模式的第一条歌词
@property (retain, nonatomic) MyView *gecilabel2;//经典模式的第二条歌词
@property (retain, nonatomic) UIScrollView *scrollview;//控制模式的
@property (retain, nonatomic) UIButton *barbutton;//播放模式按钮
@property (retain, nonatomic) UIButton *shoucang;//收藏按钮
@property (retain, nonatomic) Music *music;
@property (retain, nonatomic) MusicDb *musicdb;
@property (retain, nonatomic) UIImageView *imageone;//流行模式图片（左边）
@property (retain, nonatomic) UIImageView *imagetwo;//流行模式图片（左边）
@property (retain, nonatomic) UIImageView *imagethree;//流行模式图片（左边）
@property (retain, nonatomic) UIImageView *imagefour;//流行模式图片（左边）


/*****************************************
    播放音乐
 *****************************************/
- (void)play;

/*****************************************
    播放进度条调节播放进度
 *****************************************/
- (void)sliderchang;

/*****************************************
    由路径获取歌曲图片
 *****************************************/
- (void)photobyPath:(NSString *)path;

/*****************************************
    获取i句歌词的歌曲播放的进度
 *****************************************/
- (float)timetoint:(int)i;

/*****************************************
    通过table的当前地址获得播放进度
 *****************************************/
- (int)timewithcintentoffset;

/*****************************************
    上一曲
 *****************************************/
- (void)upplay;

/*****************************************
    下一曲
 *****************************************/
- (void)nextplay;

/*****************************************
    改变播放的模式
 *****************************************/
- (void)changeplaymodel;

/*****************************************
    收藏
 *****************************************/
- (void)doshoucang;

/*****************************************
    调节音量
 *****************************************/
- (void)changeVolum:(UISlider *)slider;

/*****************************************
    音量按钮
 *****************************************/
- (void)changevolumebutton;

@end
