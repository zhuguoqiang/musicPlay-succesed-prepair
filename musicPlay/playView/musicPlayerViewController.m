//
//  musicPlayerViewController.m
//  MusicPlay
//
//  Created by student on 12-8-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "musicPlayerViewController.h"
#import "LrcParser.h"
#import "LrcUnit.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "MyView.h"
#import "MusicDb.h"
#import "Music.h"
#import "VolVIew.h"

@implementation musicPlayerViewController

@synthesize table = _table;
@synthesize lrc = _lrc;
@synthesize player = _player;
@synthesize slider = _slider;
@synthesize playbutton = _playbutton;
@synthesize rightLabel = _rightLabel;
@synthesize leftLabel = _leftLabel;
@synthesize imageview = _imageview;
@synthesize slider_volum = _slider_volum;
@synthesize gecilabel1 = _gecilabel1;
@synthesize gecilabel2 = _gecilabel2;
@synthesize scrollview = _scrollview;
@synthesize barbutton = _barbutton;
@synthesize shoucang = _shoucang;
@synthesize music = _music;
@synthesize musicdb = _musicdb;
@synthesize imageone = _imageone;
@synthesize imagetwo = _imagetwo;
@synthesize imagethree = _imagethree;
@synthesize imagefour = _imagefour;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [super viewDidLoad];
    
    //背景图片
    UIImageView *imvie = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    imvie.image = [UIImage imageNamed:@"蓝天.jpg"];
    [self.view addSubview:imvie];
    [imvie release];

    //滑动界面
    self.scrollview = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
    self.scrollview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollview];
    [self.scrollview setContentSize:CGSizeMake(960, 480)];
    [self.scrollview setContentOffset:CGPointMake(320, 0)];
    self.scrollview.delegate = self;
    self.scrollview.pagingEnabled = YES;
    
    
    //流行模式
    UIView *imagefrist = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    imagefrist.backgroundColor = [UIColor clearColor];
    //****one**********
    self.imageone = [[[UIImageView alloc] initWithFrame:CGRectMake(120, 120, 80, 80)] autorelease];
    self.imageone.image = [UIImage imageNamed:@"发光彩环-圈.png"];
    self.imageone.backgroundColor = [UIColor clearColor];
    [imagefrist addSubview:self.imageone];
    //****two**********
    self.imagetwo = [[[UIImageView alloc] initWithFrame:CGRectMake(80, 80, 160, 160)] autorelease];
    self.imagetwo.image = [UIImage imageNamed:@"发光彩环-圈.png"];
    self.imageone.backgroundColor = [UIColor clearColor];
    [imagefrist addSubview:self.imagetwo];
    //****three**********
    self.imagethree = [[[UIImageView alloc] initWithFrame:CGRectMake(40, 40, 240, 240)] autorelease];
    self.imagethree.image = [UIImage imageNamed:@"发光彩环-圈.png"];
    self.imageone.backgroundColor = [UIColor clearColor];
    [imagefrist addSubview:self.imagethree];
    //****four**********
    self.imagefour = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)] autorelease];
    self.imagefour.image = [UIImage imageNamed:@"发光彩环-圈.png"];
    self.imageone.backgroundColor = [UIColor clearColor];
    [imagefrist addSubview:self.imagefour];
    
    [self.scrollview addSubview:imagefrist];
    [imagefrist release];
    
    
    
    //歌词图片
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(365, 20, 230, 230)];
    iv.layer.cornerRadius = 10;//设置那个圆角的有多圆
    iv.layer.borderWidth = 10;//设置边框的宽度，当然可以不要
    iv.layer.masksToBounds = YES;
    iv.layer.borderColor = [[UIColor whiteColor] CGColor];//设置边框的颜色
    [self.scrollview addSubview:iv];
    self.imageview = [[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 220, 220)] autorelease];
    [iv addSubview:self.imageview];
    [iv release];
    
    
    //经典模式歌词
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(330, 270, 300, 28)];
    self.gecilabel1 = [[[MyView alloc]initWithFrame:CGRectMake(0, 0, 300, 28)] autorelease];
    [self.gecilabel1 setFgcolor:[UIColor redColor]];
    [self.gecilabel1 setBgcolor:[UIColor greenColor]];
    [view addSubview:self.gecilabel1];
    [self.scrollview addSubview:view];
    [view release];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(360, 298, 300, 28)];
    self.gecilabel2 = [[[MyView alloc]initWithFrame:CGRectMake(0, 0, 300, 28)] autorelease];
    [self.gecilabel2 setFgcolor:[UIColor redColor]];
    [self.gecilabel2 setBgcolor:[UIColor greenColor]];
    [view addSubview:self.gecilabel2];
    [self.scrollview addSubview:view];
    [view release];
    
    
    //歌词table
    self.table = [[[UITableView alloc] initWithFrame:CGRectMake(650, 20, 300, 310)] autorelease];
    [self.table setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.table setBounces:NO];
    [self.table setBackgroundColor:[UIColor clearColor]];
    self.table.delegate = self;
    self.table.dataSource = self;
    ((UIScrollView *)self.table).delegate = self;
    [self.scrollview addSubview:self.table];
    
    
    //收藏按钮
    self.shoucang = [[[UIButton alloc] initWithFrame:CGRectMake(280, 5, 32, 32)] autorelease];
    [self.shoucang addTarget:self action:@selector(doshoucang) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.shoucang];
    
    
    //播放模式
    self.barbutton = [[[UIButton alloc] init] autorelease];
    [self.barbutton setFrame:CGRectMake(265, 373, 30, 25)];
    self.barbutton.backgroundColor = [UIColor clearColor];
    [self.barbutton addTarget:self action:@selector(changeplaymodel) forControlEvents:(UIControlEventTouchUpInside)];
    [self.barbutton setBackgroundImage:[UIImage imageNamed:@"单曲循环.png"] forState:0];

    [self.view addSubview:self.barbutton];
    self.barbutton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    //self.view_Play.layer.borderWidth = 10;//设置边框的宽度，当然可以不要
    self.barbutton.layer.borderColor = [[UIColor redColor] CGColor];//设置边框的颜色
    self.barbutton.layer.masksToBounds = YES;//设为NO去试试
    
    // 播放按钮
    self.playbutton = [[[UIButton alloc] init] autorelease];
    [self.playbutton setFrame:CGRectMake(145, 370, 30, 30)];
    self.playbutton.backgroundColor = [UIColor clearColor];
    [self.playbutton addTarget:self action:@selector(play) forControlEvents:(UIControlEventTouchUpInside)];
    [self.playbutton setBackgroundImage:[UIImage imageNamed:@"播放.png"] forState:0];
    [self.view addSubview:self.playbutton];
    
    // 上一首按钮
    UIButton *button = [[UIButton alloc] init];
    [button setFrame:CGRectMake(85, 370, 30, 30)];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(upplay) forControlEvents:(UIControlEventTouchUpInside)];
    [button setBackgroundImage:[UIImage imageNamed:@"上一曲.png"] forState:0];
    [self.view addSubview:button];
    [button release];
    
    // 下一曲按钮
    button = [[UIButton alloc] init];
    [button setFrame:CGRectMake(205, 370, 30, 30)];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(nextplay) forControlEvents:(UIControlEventTouchUpInside)];
    [button setBackgroundImage:[UIImage imageNamed:@"下一曲.png"] forState:0];
    [self.view addSubview:button];
    [button release];
    
    //音量调节
    UIButton *butt = [[UIButton alloc] init];
    [butt setFrame:CGRectMake(25, 370, 28, 28)];
    [butt addTarget:self action:@selector(changevolumebutton) forControlEvents:(UIControlEventTouchUpInside)];
    [butt setBackgroundImage:[UIImage imageNamed:@"声音1.png"] forState:0];
    [self.view addSubview:butt];
    [butt release];
    
    self.slider_volum=[[[VolVIew alloc]initWithFrame:CGRectMake(35, 268, 8, 100)]autorelease];
    [self.slider_volum addTarget:self action:@selector(changeVolum:)];
    self.slider_volum.backgroundColor=[UIColor clearColor];
    //定义音量图像
    [self.slider_volum setMaximumTrackImage:[UIImage imageNamed:@"Tracker2.jpg"]];
    [self.slider_volum setMinimumTrackImage:[UIImage imageNamed:@"Tracker1.jpg"]];
    self.slider_volum.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"volume"];
//    CGAffineTransform trans=CGAffineTransformMakeRotation( M_PI * 1.5);
//    self.slider_volum.transform=trans;
    self.slider_volum.alpha = 0;
    [self.view addSubview:self.slider_volum];
    
    
    /*
    self.slider_volum=[[[UISlider alloc]initWithFrame:CGRectMake(-30, 290, 140, 20)]autorelease];
    [self.slider_volum addTarget:self action:@selector(changeVolum:) forControlEvents:UIControlEventValueChanged];
    self.slider_volum.backgroundColor=[UIColor clearColor];
    self.slider_volum.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"volume"];
    CGAffineTransform trans=CGAffineTransformMakeRotation( M_PI * 1.5);
    self.slider_volum.transform=trans;
    self.slider_volum.alpha = 0;
    [self.view addSubview:self.slider_volum];
    //自定义音量图像
    [self.slider_volum setMaximumTrackImage:[UIImage imageNamed:@"Tracker2.jpg"] forState:(UIControlStateNormal)];
    [self.slider_volum setMinimumTrackImage:[UIImage imageNamed:@"Tracker1.jpg"] forState:(UIControlStateNormal)];
    [self.slider_volum setThumbImage:nil forState:(UIControlStateHighlighted)];
    [self.slider_volum setThumbImage:nil forState:(UIControlStateNormal)];
    [self.slider_volum setThumbTintColor:[UIColor clearColor]];
    */
    
    
    
    //播放进度
    self.slider = [[[UISlider alloc] initWithFrame:CGRectMake(80, 333, 160, 23)] autorelease];
    [self.slider setBackgroundColor:[UIColor clearColor]];
    [self.slider addTarget:self action:@selector(sliderchang) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.slider];
    
    
    //***********************
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    
    
    //当前播放时间
    self.leftLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 333, 60, 23)] autorelease];
    [self.leftLabel setTextAlignment:(UITextAlignmentCenter)];
    [self.leftLabel setFont:[UIFont systemFontOfSize:17]];
    [self.leftLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.leftLabel];
    self.leftLabel.text = @"00:00";
    
    //歌曲总时间
    self.rightLabel = [[[UILabel alloc] initWithFrame:CGRectMake(240, 333, 60, 23)] autorelease];
    [self.rightLabel setTextAlignment:(UITextAlignmentCenter)];
    [self.rightLabel setFont:[UIFont systemFontOfSize:17]];
    [self.rightLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.rightLabel];
    self.rightLabel.text = @"00:00";
    [pool drain];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"七里香 - 周杰伦" ofType:@"mp3"];
    NSLog(@"path = %@",path);
    NSString *lrcpath = [[NSBundle mainBundle]pathForResource:@"七里香 - 周杰伦" ofType:@"lrc"];
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path ] error:nil];
    self.music = [[Music alloc]initWithUrl:[NSURL fileURLWithPath:path ] andLrcPath:lrcpath];
    if (!self.music) {
        NSString *musicpath;
        NSString *musiclrcpath;
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"url"]) 
        {
            musicpath = [[NSUserDefaults standardUserDefaults] valueForKey:@"url"];
           //musicpath = [[NSBundle mainBundle] pathForResource:@"凤凰传奇 - 御龙归字谣" ofType:@"mp3"];
            if ([[NSUserDefaults standardUserDefaults] valueForKey:@"lrcpath"]) {
                musiclrcpath = [[NSUserDefaults standardUserDefaults] valueForKey:@"lrcpath"];
            }
            if ([[NSUserDefaults standardUserDefaults] valueForKey:@"name"]) {
                self.music.name = [[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
            }else self.music.name = @"未知";
            if ([[NSUserDefaults standardUserDefaults] floatForKey:@"currentTime"]) {
                currentTime = [[NSUserDefaults standardUserDefaults] floatForKey:@"currentTime"];
            }
            
            NSURL *url = [[NSURL alloc]initFileURLWithPath:musicpath];         
            self.music = [[[Music alloc] initUrl:url andLrcPath:musiclrcpath] autorelease];
            [self photobyPath:musicpath];
            [url release];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = YES;
    if (self.music.love) 
    {
        [self.shoucang.imageView setHighlighted:YES];
        [self.shoucang setImage:[UIImage imageNamed:@"桃心2.png"] forState:0];
    }else
    {
        [self.shoucang.imageView setHighlighted:NO];
        [self.shoucang setImage:[UIImage imageNamed:@"桃心1.png"] forState:0];
    }
    
    [self play];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setFloat:self.slider_volum.value forKey:@"volume"];
    [[NSUserDefaults standardUserDefaults] setValue:[self.music.url path] forKey:@"url"];
    [[NSUserDefaults standardUserDefaults] setValue:self.music.lrcpath forKey:@"lrcpath"];
    [[NSUserDefaults standardUserDefaults] setValue:self.music.name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.player.currentTime forKey:@"currentTime"];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark My action--------------

- (void)changeplaymodel
{
    playmodel ++;
    playmodel = playmodel % 4;    NSLog(@"playmodel = %d",playmodel);
    switch (playmodel) {
        case 0:
            [self.barbutton setBackgroundImage:[UIImage imageNamed:@"单曲循环.png"] forState:0];
            break;
        case 1:
            [self.barbutton setBackgroundImage:[UIImage imageNamed:@"列表循环.png"] forState:0];
            break;
        case 2:
            [self.barbutton setBackgroundImage:[UIImage imageNamed:@"顺序播放.png"] forState:0];
            break;
        case 3:
            [self.barbutton setBackgroundImage:[UIImage imageNamed:@"随机播放.png"] forState:0];
            break;
            
        default:
            break;
    }
}

- (void)play
{
    if (!self.music) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提升" message:@"请选择歌曲" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if (![filemanager fileExistsAtPath:[self.music.url path]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"歌曲不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    if (!self.player.playing) 
    {
        if (!self.player) 
        {
            self.title = self.music.name;
            if (self.music.love) {
                [self.shoucang.imageView setHighlighted:YES];
                [self.shoucang setImage:[UIImage imageNamed:@"桃心2.png"] forState:0];
            }else
            {
                [self.shoucang.imageView setHighlighted:NO];
                [self.shoucang setImage:[UIImage imageNamed:@"桃心1.png"] forState:0];
            }
            
            self.imageview.image = self.music.image;
            AVAudioPlayer * t = [[AVAudioPlayer alloc] initWithContentsOfURL:self.music.url error:nil];
            t.currentTime = currentTime;
            currentTime = 0;
            t.meteringEnabled = YES;
            self.player = t;
            [t release];
            //解析
            if ([filemanager fileExistsAtPath:self.music.lrcpath]) {
                self.lrc = [[[LrcParser alloc] init] autorelease];
                [self.lrc setLrcPath:[NSMutableString stringWithFormat:@"%@", self.music.lrcpath]];
                [self.lrc parser];
            }
            if (self.slider_volum.value) {
                self.player.volume = self.slider_volum.value;
            } else self.player.volume = 0.6;
            self.player.delegate = self;
            [self.player prepareToPlay];
            if (![self.player play]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"播放错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                [alert release];
                self.player = nil;
                return;
            }
            self.rightLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)self.player.duration / 60,(int)self.player.duration % 60];
            [self.playbutton setBackgroundImage:[UIImage imageNamed:@"暂停.png"] forState:0];
        }else 
        {
            [self.player play];
            [self.playbutton setBackgroundImage:[UIImage imageNamed:@"暂停.png"] forState:0];
        }
    } else 
    {
        [self.player pause];
        [self.playbutton setBackgroundImage:[UIImage imageNamed:@"播放.png"] forState:0];
    }
}

- (void)nextplay
{
    if ([self.musicdb count] != 0) {
        int a = [self.musicdb indexOfMusic:self.music];
        if (a == [self.musicdb count] - 1) {
            a = -1;
        }
        self.music = [self.musicdb musicAtIndex:a + 1];
    } 
    self.player = nil;;
    [self play];
}

- (void)upplay
{
    if ([self.musicdb count] != 0) {
        int a = [self.musicdb indexOfMusic:self.music];
        if (a == 0) {
            a = [self.musicdb count];
        }
        self.music = [self.musicdb musicAtIndex:a - 1];
    }
    self.player = nil;
    [self play];
}

- (void)sliderchang
{
    self.player.currentTime = self.slider.value * self.player.duration;
}

- (void)onTimer
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    double a = self.player.duration;
    double b = self.player.currentTime;
    
    if (self.player.playing) {
        [self.player updateMeters];
        int a = ([self.player averagePowerForChannel:0] + 15) / 3;NSLog(@"a = %f",[self.player averagePowerForChannel:0]);
       // int a = rand() % 5;
        switch (a) {
            case 0:
                self.imageone.hidden = YES;
                self.imagetwo.hidden = YES;
                self.imagethree.hidden = YES;
                self.imagefour.hidden = YES;
                break;
            case 1:
                self.imageone.hidden = NO;
                self.imagetwo.hidden = YES;
                self.imagethree.hidden = YES;
                self.imagefour.hidden = YES;
                break;
            case 2:
                self.imageone.hidden = NO;
                self.imagetwo.hidden = NO;
                self.imagethree.hidden = YES;
                self.imagefour.hidden = YES;
                break;
            case 3:
                self.imageone.hidden = NO;
                self.imagetwo.hidden = NO;
                self.imagethree.hidden = NO;
                self.imagefour.hidden = YES;
                break;
            case 4:
                self.imageone.hidden = NO;
                self.imagetwo.hidden = NO;
                self.imagethree.hidden = NO;
                self.imagefour.hidden = NO;
                break;
                
            default:
                break;
        }
    }
    
    if ((!self.player.playing) && doplay) {
        [self.player play];
        doplay = NO;
    }
    if (a) 
    {
        self.slider.value = self.player.currentTime / a;
    }
    self.leftLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)b / 60,(int)b % 60];
    for (int i = 0; i < [self.lrc.lrcs count]; i++) 
    {
        LrcUnit *temp = ((LrcUnit *)[self.lrc.lrcs objectAtIndex:i]);
        if (temp.startTime < b + 0.1 && b + 0.1 < temp.endTime) 
        {
            
//经典模式（中间的）的播放字幕   卡啦ok效果
            if (!(i % 2)) {
                self.gecilabel1.text = temp.lrcUnitContent;
                [self.gecilabel1 setNeedsDisplay];
                float dx = self.player.currentTime - temp.startTime + 0.199;
                float dy = temp.endTime - temp.startTime;
                float d = (dx / dy);
                self.gecilabel1.plan = MIN(d, 1.0);
                [self.gecilabel1 secondLevelCache];
                //延缓0.3 * dx秒钟再刷新第2条的歌词
                if (self.player.currentTime - temp.startTime > 0.3 * dx) {
                    if (i != ([self.lrc.lrcs count] - 1 )) 
                    {
                        self.gecilabel2.plan = 0.000001;
                        self.gecilabel2.text = ((LrcUnit *)[self.lrc.lrcs objectAtIndex:i + 1]).lrcUnitContent;
                        [self.gecilabel2 secondLevelCache];
                    } else self.gecilabel2.text = @"";
                }
            } else
            {
                self.gecilabel2.text = temp.lrcUnitContent;
                [self.gecilabel2 setNeedsDisplay];
                float dx = self.player.currentTime - temp.startTime + 0.199;
                float dy = temp.endTime - temp.startTime;
                float d = (dx / dy);
                self.gecilabel2.plan = MIN(d, 1.0);
                [self.gecilabel2 secondLevelCache];
                
                //延缓0.3 * dx秒钟再刷新第一条歌词
                if (self.player.currentTime - temp.startTime > 0.3 * dx) {
                    if (i != ([self.lrc.lrcs count] - 1 )) 
                    {
                        //初始化第二条
                        self.gecilabel1.plan = 0.000001;
                        self.gecilabel1.text = ((LrcUnit *)[self.lrc.lrcs objectAtIndex:i + 1]).lrcUnitContent;
                        [self.gecilabel1 secondLevelCache];
                    } else self.gecilabel1.text = @"";
                }
            }
  
            
            
            
//查看歌词模式（右边的）table向上移动显示
            if (!self.table.decelerating) {
                ishandorsys = 2;
                [self.table setContentOffset:CGPointMake(0, (i + [self timetoint:i]) * 31)];
                [self.table reloadData];
            }
            break;
        }
    }
    [pool drain];
}

- (float)timetoint:(int)i
{
    float a = self.player.currentTime - ((LrcUnit *)[self.lrc.lrcs objectAtIndex:i]).startTime;
    float b = ((LrcUnit *)[self.lrc.lrcs objectAtIndex:i]).endTime - ((LrcUnit *)[self.lrc.lrcs objectAtIndex:i]).startTime;
    if (b == 0) {
        return 0;
    }
    return a / b;
}

//图片解析
- (void)photobyPath:(NSString *)path
{
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    AVURLAsset *a = [AVURLAsset URLAssetWithURL:url options:nil];
    [url release];
    //图片解析
    NSArray *k = [NSArray arrayWithObjects:@"commonMetadata", nil];
    [a loadValuesAsynchronouslyForKeys:k completionHandler:^
     {
         NSArray *artworks = [AVMetadataItem metadataItemsFromArray:a.commonMetadata withKey:AVMetadataCommonKeyArtwork keySpace:AVMetadataKeySpaceCommon];
         
         NSMutableArray *artworkImages = [NSMutableArray array];
         for (AVMetadataItem *i in artworks)
         {
             NSString *keySpace = i.keySpace;
             UIImage *im = nil;
             
             if ([keySpace isEqualToString:AVMetadataKeySpaceID3])
             {
                 NSDictionary *d = [[i.value copyWithZone:nil]autorelease];
                 im = [UIImage imageWithData:[d objectForKey:@"data"]];
             }
             else if ([keySpace isEqualToString:AVMetadataKeySpaceiTunes])
                 im = [UIImage imageWithData:[[i.value copyWithZone:nil]autorelease]];
             
             if (im)
                 [artworkImages addObject:im];
         }
         if ([artworkImages count]>0) {
             self.music.image = (UIImage *)[artworkImages objectAtIndex:0];
         }
     }];
}

- (void)changeVolum:(UISlider *)slider
{
    self.player.volume = slider.value;
}

- (void)changevolumebutton
{
    if (!self.slider_volum.alpha) 
    {
        [UIView beginAnimations:nil context:self.slider_volum];
        self.slider_volum.alpha = 1.0;
        [UIView setAnimationDuration:1.0];
        [UIView commitAnimations];
    }else 
    {
        [UIView beginAnimations:nil context:self.slider_volum];
        self.slider_volum.alpha = 0;
        [UIView setAnimationDuration:1.0];
        [UIView commitAnimations];
    }
}

- (int)timewithcintentoffset
{
    float a1 = ((LrcUnit *)([self.lrc.lrcs objectAtIndex:((self.table.contentOffset.y)/31)])).startTime;
    float b1 = ((LrcUnit *)([self.lrc.lrcs objectAtIndex:((self.table.contentOffset.y)/31)])).endTime;
    int d = (int)self.table.contentOffset.y % 31;
    return a1 + d * (b1 -a1) / 31;
}

- (void)doshoucang
{
    if (self.shoucang.imageView.isHighlighted) {
        [self.shoucang.imageView setHighlighted:NO];
        [self.shoucang setImage:[UIImage imageNamed:@"桃心1.png"] forState:0];
        self.music.love = NO;
    }else 
    {
        [self.shoucang.imageView setHighlighted:YES];
        [self.shoucang setImage:[UIImage imageNamed:@"桃心2.png"] forState:0];
        self.music.love = YES;
    }
}

#pragma mark Tableviewdelege--------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 31; 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.lrc.lrcs count] + 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.frame = CGRectMake(0, 0, 300, 31);
        cell.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 31)];
        label.backgroundColor = [UIColor clearColor];
        [label setTextAlignment:(UITextAlignmentCenter)];
        label.tag = 1;
        [label setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:17]];
        
        [cell addSubview:label];
        [label release];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        
    }
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    
    if (indexPath.row == (int)(self.table.contentOffset.y) / 31 + 4) {
        label.textColor = [UIColor greenColor];
    } else label.textColor = [UIColor whiteColor];
    
    if (indexPath.row > 3) {
        label.text = ((LrcUnit *)[self.lrc.lrcs objectAtIndex:indexPath.row - 4]).lrcUnitContent;
    } else 
    {
        label.text =@"";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{

}

#pragma mark AVAudioPlayerDelegate--------

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    switch (playmodel) {
        //playmodel:单曲循环 0,列表循环 1,顺序播放 2,随机播放 3
        case 0:
            self.player.currentTime = 0;
            [self.player play];
            break;
        case 1:
            [self nextplay];
            break;
        case 2:
        {
            int a = [self.musicdb indexOfMusic:self.music];
            if (a != [self.musicdb count] - 1) {
                [self nextplay];
            } else self.player = nil;
        }
            break;
        case 3:
        {
            if ([self.musicdb count] != 0) {
                int a = [self.musicdb indexOfMusic:self.music];
                int b;
                if (1 < [self.musicdb count]) {
                    do {
                        b = rand() %[self.musicdb count];
                    } while (b == a);
                }else b = 0;
                
                self.music = [self.musicdb musicAtIndex:b];
            }
            self.player = nil;
            [self play];
        }
            break;
        default:
            break;
    }
}

#pragma mark Touches------------------------

CGPoint point;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    point = [[touches anyObject] locationInView:self.view];
}

/*
int a = 1;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    if (!pt.x) {
        pt = [[touches anyObject] locationInView:self.table];
    }
    CGFloat dx = self.scrollview.frame.origin.x + pt.x - point.x;
    switch (a) {
        case -1:
            if (dx > 0) {
                dx = 0;
            }
            self.scrollview.frame = CGRectMake(dx, self.scrollview.frame.origin.y, self.scrollview.frame.size.width, self.scrollview.frame.size.height);
            break;
        case 0:
            self.scrollview.frame = CGRectMake(dx, self.scrollview.frame.origin.y, self.scrollview.frame.size.width, self.scrollview.frame.size.height);
            break;
        case 1:
            if (dx < -640) {
                dx = -640;
            }
            self.scrollview.frame = CGRectMake(dx, self.scrollview.frame.origin.y, self.scrollview.frame.size.width, self.scrollview.frame.size.height);
            break;
            
        default:
            break;
    }
    point = pt;
}
*/

#pragma mark UIScrollViewDelegate
CGPoint p;

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == self.scrollview) 
    {
        NSLog(@"scrollView station = %f",scrollView.contentOffset.x);
    } else 
    {
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollview) {
//        if (p.x) {
//            float a = (scrollView.contentOffset.x - p.x) / 320;
//            if (scrollView.contentOffset.x < 320) {
//                a = -a;
//            } 
//            if (scrollView.contentOffset.x > 0 && scrollView.contentOffset.x < 640) {
//                float x = self.imageview.frame.origin.x - 45 * a;
//                float y = self.imageview.frame.origin.y - 20 * a;
//                float with = self.imageview.frame.size.width + 90 * a;
//                float higth = self.imageview.frame.size.height + 100 *a;
//                self.imageview.frame = CGRectMake(x, y, with, higth);
//            }
//            
//        }
//        p = scrollView.contentOffset;
    } else 
    {
        ishandorsys = ishandorsys - 2;
        if (ishandorsys) {
            doplay = YES;
            //[self.player pause];
            self.player.currentTime = [self timewithcintentoffset];
            self.leftLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)self.player.currentTime / 60,(int)self.player.currentTime % 60];
            self.slider.value = self.player.currentTime / self.player.duration;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollview) 
    {
        p.x = scrollView.contentOffset.x;
    }
}

- (void)dealloc
{
    self.table = nil;
    self.lrc = nil;
    self.player = nil;
    self.slider = nil;
    self.playbutton = nil;
    self.rightLabel = nil;
    self.leftLabel = nil;
    self.imageview = nil;
    self.slider_volum = nil;
    self.gecilabel1 = nil;
    self.gecilabel2 = nil;
    self.scrollview = nil;
    self.musicdb = nil;
    self.music = nil;
    self.barbutton = nil;
    self.shoucang = nil;
    self.imageone = nil;
    self.imagetwo = nil;
    self.imagethree = nil;
    self.imagefour = nil;
    [super dealloc];
}

@end














