//
//  onlineMusicViewController.m
//  onlineMusic
//
//  Created by student on 12-8-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "onlineMusicViewController.h"
#import "musicPlayAppDelegate.h"
#import "TableCell.h"
#import "MusicJsonParser.h"
#import "AudioStreamer.h"
#import "LrcParser.h"
#import "LrcUnit.h"
#import "ASIHTTPRequest.h"
#import "MusicSqlite.h"
#import "MusicListViewController.h"

@implementation onlineMusicViewController
@synthesize huancun;
@synthesize delegate;
@synthesize searchView;
@synthesize playView;
@synthesize listTable;
@synthesize onlineMusicProgress;
@synthesize onlineMusicProgressLabel;
@synthesize playImageView;
@synthesize MusicTitle;
@synthesize MusicArtist;
@synthesize playSlider;
@synthesize playVolum;
@synthesize playVolumLabel;
@synthesize playButton;
@synthesize tmpCell;
@synthesize lrc;

@synthesize tmpParser;
@synthesize audio;
@synthesize currentMusic;
@synthesize songlist;
@synthesize path;
@synthesize tick;

@synthesize progresstitle;
@synthesize progressview;
@synthesize httpRequest;
@synthesize progresslabel;
@synthesize baifen;
@synthesize progressBack;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //沙河路径
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentPath = [searchPaths objectAtIndex:0];
    self.path = documentPath;
    NSLog(@"沙河路径 is %@",self.path);
    self.searchView = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320,40)];
    self.searchView.tintColor = [UIColor blueColor];
    self.searchView.text = @"歌曲名";
    //self.searchView.showsCancelButton = YES;
    self.searchView.delegate = self;
    
    UIImage* image = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"back" ofType:@"jpg"]];
    UIImageView* imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:imageView];
    
    self.playView = [[UIView alloc]initWithFrame:CGRectMake(7,50,300,80)];
    //[self.playView setBackgroundColor:[UIColor clearColor]];
    
    self.playImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search.png"]];
    self.playImageView.frame = CGRectMake(5, 10, 60, 60);
    [self.playView addSubview:self.playImageView];
    
    self.MusicTitle = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 100, 20)];
    [self.MusicTitle setBackgroundColor:[UIColor clearColor]];
    self.MusicTitle.text = @"曲名";
    self.MusicArtist = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, 100, 20)];
    [self.MusicArtist setBackgroundColor:[UIColor clearColor]];
    self.MusicArtist.text = @"作者";
    [self.playView addSubview:self.MusicTitle];
    [self.playView addSubview:self.MusicArtist];
    
    self.playVolum = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"music.png"]];
    self.playVolum.frame = CGRectMake(170, 60, 30,30);
    [self.playView addSubview:self.playVolum];
    
    self.playSlider = [[UISlider alloc]initWithFrame:CGRectMake(205, 57, 90, 20)];
    [self.playSlider addTarget:self action:@selector(changeValum) forControlEvents:UIControlEventValueChanged];
    self.playSlider.value = 100;
    [self.playView addSubview:self.playSlider];
    
    self.playButton = [[UIButton alloc]initWithFrame:CGRectMake(220, 5, 30, 30)];
    [self.playButton setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    self.playButton.tag = 0;
    [self.playButton addTarget:self action:@selector(buttonChange) forControlEvents:UIControlEventTouchUpInside];
    [self.playView addSubview:self.playButton];
    
    self.onlineMusicProgress = [[UISlider alloc]initWithFrame:CGRectMake(5, 310, 150, 20)];
    
    self.onlineMusicProgressLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 310, 80, 20)];
    [self.onlineMusicProgressLabel setBackgroundColor:[UIColor clearColor]];
    self.onlineMusicProgressLabel.text = @"00/00";
    //listTabel
    self.listTable = [[UITableView alloc]initWithFrame:CGRectMake(5,130,300,150)];
    [self.listTable setBackgroundColor:[UIColor clearColor]];
    self.listTable.delegate = self;
    self.listTable.dataSource = self;
    
    //[self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.playView];
    [self.view addSubview:self.listTable];
    [self.view addSubview:self.onlineMusicProgress];
    [self.view addSubview:self.onlineMusicProgressLabel];
}

-(void)buttonChange
{
    switch (self.playButton.tag) {
        case 0:
            [self.playButton setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
            self.playButton.tag = 1;
            [self.audio pause];
            break;
        case 1:
            [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop.tiff"] forState:UIControlStateNormal];
            [self.audio start];
            self.playButton.tag = 0;
        default:
            break;
    }
}
/*******************************************
 函数名称：-(int)timeToInt:(double)time
 函数功能：返回歌曲时间
 传入参数：sender
 返回 值 ： N/A
 ********************************************/
-(int)timeToInt:(double)tmptime{   
    
    LrcUnit *tmp=(LrcUnit*)[self.lrc.lrcs objectAtIndex:[self.lrc lrcUnitIndex:tmptime]];
    return (25*([self.lrc lrcUnitIndex:tmptime]-4)+(tmptime-tmp.startTime)/(tmp.endTime-tmp.startTime)*25);
    
}
/*******************************************
 函数名称：doubleToString:
 函数功能：计算时间
 传入参数：time
 返回 值 ： N/A
 ********************************************/
-(NSString*)doubleToString:(double)tmptime{
    if (tmptime<60) {
        if (tmptime<10) {
            return [NSString stringWithFormat:@"00:0%d",(int)tmptime];
        }else {
            return [NSString stringWithFormat:@"00:%d",(int)tmptime];
        }        
    }else {
        if (((int)tmptime)%60<10) {
            return [NSString stringWithFormat:@"%d:0%d",(int)(tmptime/60),((int)tmptime)%60];
        }else {
            return [NSString stringWithFormat:@"%d:%d",(int)(tmptime/60),((int)tmptime)%60];
        } 
    }
}
/*******************************************
 函数名称：-(void)nextMusic
 函数功能：下一首歌曲
 传入参数：sender
 返回 值 ： N/A
 ********************************************/
-(void)nextMusic{
    int index=[self.songlist indexOfObject:self.currentMusic]+1;
    if (index>[self.songlist count]) {
        index=0;
    }
    if (self.currentMusic) {
        self.currentMusic=nil;
    }
    self.currentMusic=[self.songlist objectAtIndex:index];
    [self playMusic:index];
    NSIndexPath *ip=[NSIndexPath indexPathForRow:index inSection:0];
    [self.listTable selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
}
-(void)changeValum
{
    if (self.audio) {
        [self.audio setVolume:self.playSlider.value];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchView resignFirstResponder];
    if ([self.searchView.text isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"不允许为空" message:@"搜索内容为空，请重新输入！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }else{   
        if (self.tmpParser) {
            self.tmpParser=nil;
        }
        self.tmpParser=[[MusicJsonParser alloc]init];
        [self.tmpParser Parser:self.searchView.text];
        self.songlist=self.tmpParser.musicsJson.songlist;
        NSLog(@"%d",[self.songlist count]);
        [self.listTable reloadData];  
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.songlist count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        self.tmpCell=[[[TableCell alloc]init]autorelease];
        cell = self.tmpCell;
        self.tmpCell.delegate=self;
    }   
    if ([self.songlist count]==0) {
        self.tmpCell.xu.text=@"0";
        self.tmpCell.name.text=@"无";
    }else{
        JsonMusicMode *tmp=((JsonMusicMode*)[self.songlist objectAtIndex:indexPath.row]);
        self.tmpCell.xu.text=[NSString stringWithFormat:@"%d",(indexPath.row+1)];
        self.tmpCell.name.text=tmp.song_name;
        self.tmpCell.aritst.text=tmp.singer_name;
        self.tmpCell.alubm.text=tmp.album_name;
    }
    [self.tmpCell.downImage setImage:[UIImage imageNamed:@"34149.png"] forState:UIControlStateNormal];
    self.tmpCell.downImage.tag=indexPath.row;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180/3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop.tiff"] forState:UIControlStateNormal];
    self.playButton.tag = 1;
    [self buttonChange];
    self.currentMusic=((JsonMusicMode*)[self.songlist objectAtIndex:indexPath.row]);
    [self.currentMusic downLrcAndAlbumImage];
    [self playMusic:indexPath.row];
}
-(void)playMusic:(NSInteger)index{
    [self.audio pause];
    NSString *image=[NSString stringWithFormat:@"%@/tmp/%@.jpg",NSHomeDirectory(),self.currentMusic.album_id];
    NSLog(@"%@",image);
    self.playImageView.image=[UIImage imageWithContentsOfFile:image];
    self.MusicTitle.text=self.currentMusic.song_name;
    self.MusicArtist.text=self.currentMusic.singer_name;
    if (self.audio) {
        [self.audio stop];
        self.audio=nil;
    }
    self.audio=[[AudioStreamer alloc]initWithURL:[NSURL URLWithString:((JsonMusicMode*)[self.tmpParser.musicsJson.songlist objectAtIndex:index]).musicPath]];
    [self.audio start];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tickitPlay) userInfo:nil repeats:YES];
}
-(void)downMusic:(UIButton*)sender{
    UIButton *button=(UIButton*)sender;
    NSLog(@"%d",button.tag);
    
    NSDictionary *properties1 = [[NSMutableDictionary alloc] init];
    [properties1 setValue:@"12" forKey:NSHTTPCookieValue];
    [properties1 setValue:@"qqmusic_fromtag" forKey:NSHTTPCookieName];
    [properties1 setValue:@".qq.com" forKey:NSHTTPCookieDomain];
    [properties1 setValue:[NSDate dateWithTimeIntervalSinceNow:60*60] forKey:NSHTTPCookieExpires];
    [properties1 setValue:@"/asi-http-request/tests" forKey:NSHTTPCookiePath];
    NSHTTPCookie *cookie1 = [[NSHTTPCookie alloc] initWithProperties:properties1];
    
    NSDictionary *properties2 = [[NSMutableDictionary alloc] init];
    [properties2 setValue:@"34567890" forKey:NSHTTPCookieValue];
    [properties2 setValue:@"qqmusic_key" forKey:NSHTTPCookieName];
    [properties2 setValue:@".qq.com" forKey:NSHTTPCookieDomain];
    [properties2 setValue:[NSDate dateWithTimeIntervalSinceNow:60*60] forKey:NSHTTPCookieExpires];
    [properties2 setValue:@"/asi-http-request/tests" forKey:NSHTTPCookiePath];
    NSHTTPCookie *cookie2 = [[NSHTTPCookie alloc] initWithProperties:properties2];
    
    NSDictionary *properties3 = [[NSMutableDictionary alloc] init];
    [properties3 setValue:@"34567890" forKey:NSHTTPCookieValue];
    [properties3 setValue:@"qqmusic_uin" forKey:NSHTTPCookieName];
    [properties3 setValue:@".qq.com" forKey:NSHTTPCookieDomain];
    [properties3 setValue:[NSDate dateWithTimeIntervalSinceNow:60*60] forKey:NSHTTPCookieExpires];
    [properties3 setValue:@"/asi-http-request/tests" forKey:NSHTTPCookiePath];
    NSHTTPCookie *cookie3 = [[NSHTTPCookie alloc] initWithProperties:properties3];
    
    NSArray *array=[[NSArray alloc]initWithObjects:cookie1,cookie2,cookie3,nil];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:((JsonMusicMode*)[self.songlist objectAtIndex:button.tag]).musicPath]];  
    self.httpRequest = request;
    //NSHomeDirectory() 改为self.path
    NSString *musicName=[NSString stringWithFormat:@"%@/%@_%@.mp3",NSHomeDirectory(),((JsonMusicMode*)[self.songlist objectAtIndex:button.tag]).song_name,((JsonMusicMode*)[self.songlist objectAtIndex:button.tag]).song_id];
    NSLog(@"*************musicName  %@",musicName);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:musicName]) 
    {
        [self.httpRequest setDownloadDestinationPath:musicName];
        self.httpRequest.useCookiePersistence=NO;
        [self.httpRequest setRequestCookies:[NSMutableArray arrayWithArray:array]];
        
        [self.httpRequest startAsynchronous];
        self.huancun = [[MusicListViewController alloc]init];
        self.progressBack = [[UIView alloc]initWithFrame:CGRectMake(5, 100, 315, 100)];
        [self.progressBack setBackgroundColor:[UIColor lightGrayColor]];
        
        self.progresstitle = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 200, 40)];
        self.progresstitle.text = @"正在下载 莫着急哦亲";
        [self.progressBack addSubview:self.progresstitle];
        
        self.progressview = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        [self.progressview setFrame:CGRectMake(30, 70, 200, 20)];
        [self.progressview setBackgroundColor:[UIColor lightGrayColor]];
        [self.progressBack addSubview:self.progressview];
        self.progresslabel = [[UILabel alloc]initWithFrame:CGRectMake(260, 70, 30, 20)];
        [self.progresslabel setBackgroundColor:[UIColor greenColor]];
        
        self.baifen = [[UILabel alloc]initWithFrame:CGRectMake(290, 70, 200, 20)];
        self.baifen.text = @"%";
        [self.baifen setBackgroundColor:[UIColor greenColor]];
        [self.progressBack addSubview:self.progresslabel];
        [self.progressBack addSubview:self.baifen];
        [self.huancun.view addSubview:self.progressBack];
        [self presentModalViewController:self.huancun animated:YES];
        self.tick = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tickit) userInfo:nil repeats:YES];
    } 
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"该文件已经存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    /*
     //当下载完以后写入数据库
     NSURL *url=[[NSURL alloc]initFileURLWithPath:musicName];
     Music *tmpMusci=[[Music alloc]initUrl:url];
     //初始化路径
     onlineMusicAppDelegate *appDelegate = (onlineMusicAppDelegate*)[UIApplication sharedApplication].delegate;
     [appDelegate.iMusicSqlite insert:tmpMusci];
     [url release];
     [tmpMusci release];
     [cookie1 release];
     [properties1 release];
     [cookie2 release];
     [properties2 release];
     [cookie3 release];
     [properties3 release];
     [array release];
     */
}
- (void) tickit
{
    
    if (self.httpRequest.totalBytesRead < self.httpRequest.contentLength) {
        int t = 100*self.httpRequest.totalBytesRead/self.httpRequest.contentLength;
        self.progresslabel.text = [NSString stringWithFormat:@"%d",t];
        self.progressview.progress = t/100.00;
    }
    else if(self.httpRequest.totalBytesRead == self.httpRequest.contentLength)
    {
        [self.tick invalidate];
        [self.progressview removeFromSuperview];
        [self.progresslabel removeFromSuperview];
        [self.baifen removeFromSuperview];
        [self.progressBack removeFromSuperview];
        [self.progressview release];
        [self.progresslabel release];
        [self.baifen release];
        [self.progressBack release];
        [self.huancun AddMusic];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"已经下载到缓存文件夹" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [self.huancun dismissModalViewControllerAnimated:YES];
        [alert release];
    }
}
-(void)tickitPlay
{
    self.onlineMusicProgress.maximumValue=self.audio.duration;
    self.onlineMusicProgressLabel.text=[NSString stringWithFormat:@"%@",[self doubleToString:self.audio.progress]];
    self.onlineMusicProgress.value=self.audio.progress;
}
- (void)dealloc
{
    self.huancun = nil;
    self.searchView=nil;
    self.playView = nil;
    self.listTable = nil;
    self.playImageView = nil;
    self.MusicTitle = nil;
    self.MusicArtist = nil;
    self.playSlider = nil;
    self.playVolum = nil;
    self.playVolumLabel = nil;
    self.tmpCell = nil;
    [super dealloc];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
