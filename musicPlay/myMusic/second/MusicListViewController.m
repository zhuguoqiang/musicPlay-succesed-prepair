//
//  MusicListViewController.m
//  MusicPlayer2
//
//  Created by student on 12-8-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicListViewController.h"
#import "MusicListTableCell.h"
#import "FirstMusicTableView.h"
#import "allTheMusicTable.h"
#import "MusicDb.h"
#import "MusicSqlite.h"
#import "Music.h"
@implementation MusicListViewController

@synthesize MusicListTable;
@synthesize musicListTableCell;
@synthesize playbutton;
@synthesize paussbutton;
@synthesize musicName;
@synthesize musicArtist;
@synthesize upAndAllTime;
@synthesize musicImage;
@synthesize musicPlayer;
@synthesize listData;
@synthesize musicpath;
@synthesize tmpPath;
@synthesize iFirstMusicTableView;
@synthesize moreActionTable;
@synthesize titlelabel;
@synthesize moreActionArray;
@synthesize MusicMessageView;
@synthesize musicNameLabel;
@synthesize musicPathLabel;
@synthesize musicTimeLabel;
@synthesize musicAlbumLabel;
@synthesize musicArtistLabel;

@synthesize tmpIndex;
@synthesize iallTheMusicTable;
@synthesize imusicDb;
@synthesize tmpMusic;
@synthesize ms;

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

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //    self.iFirstMusicTableView.myCollectMusicName=[[[NSMutableArray alloc] init] autorelease];
    //    self.iFirstMusicTableView.myCollectMusicPath=[[[NSMutableArray alloc] init] autorelease];
    
    self.iFirstMusicTableView.loveMusicDb=[[[MusicDb alloc] init] autorelease];
    
    self.iFirstMusicTableView.latePlayMusicDb=[[[MusicDb alloc] init] autorelease];
    
    self.iallTheMusicTable=[[[allTheMusicTable alloc] init] autorelease];
    
    self.ms = [[[MusicSqlite alloc]init] autorelease];
    //table
    self.MusicListTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    self.MusicListTable.delegate=self;
    self.MusicListTable.dataSource=self;
    [self.view addSubview:MusicListTable];
    self.MusicListTable.backgroundColor=[UIColor clearColor];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg24.png"]];
    
    //UIToolbar
    UIBarButtonItem *playbar=[[UIBarButtonItem alloc] 
                              initWithTitle:@"                  " style:UIBarButtonItemStylePlain target:self action:@selector(jumpPlayView)];
    NSArray *tmp=[[NSArray alloc] initWithObjects:playbar, nil];
    UIToolbar *toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 400, 320, 80)];
    [toolbar setItems:tmp];
    [self.view addSubview:toolbar];
    [toolbar release];
    [playbar release];
    [tmp release];
    
    //下一首按钮
    UIButton *jumpUpbutton=[[UIButton alloc] initWithFrame:CGRectMake(275, 413, 35, 35)];
    jumpUpbutton.backgroundColor=[UIColor clearColor];
    [jumpUpbutton setImage:[UIImage imageNamed:@"jumpUp.tiff"] forState:UIControlStateNormal];
    [jumpUpbutton addTarget:self action:@selector(jumpUp) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:jumpUpbutton];
    [jumpUpbutton release];
    
    //播放按钮
    playbutton=[[UIButton alloc] initWithFrame:CGRectMake(230, 413, 35, 35)];
    playbutton.backgroundColor=[UIColor clearColor];
    [playbutton setImage:[UIImage imageNamed:@"play.tiff"] forState:UIControlStateNormal];
    [playbutton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:playbutton];
    
    //暂停按钮
    paussbutton=[[UIButton alloc] initWithFrame:CGRectMake(230, 413, 35, 35)];
    paussbutton.backgroundColor=[UIColor clearColor];
    [paussbutton setImage:[UIImage imageNamed:@"pauss.tiff"] forState:UIControlStateNormal];
    [paussbutton addTarget:self action:@selector(pauss) forControlEvents:UIControlEventTouchDown];
    self.paussbutton.hidden=YES;
    [self.view addSubview:paussbutton];
    
    //上一首按钮
    UIButton *jumpDownbutton=[[UIButton alloc] initWithFrame:CGRectMake(185, 413, 35, 35)];
    jumpDownbutton.backgroundColor=[UIColor clearColor];
    [jumpDownbutton setImage:[UIImage imageNamed:@"jumpDown.tiff"] forState:UIControlStateNormal];
    [jumpDownbutton addTarget:self action:@selector(jumpDown) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:jumpDownbutton];
    [jumpDownbutton release];
    
	// Do any additional setup after loading the view.
    //歌曲名
    musicName=[[UILabel alloc] initWithFrame:CGRectMake(60, 408, 120, 20)];
    musicName.backgroundColor=[UIColor clearColor];
    musicName.font=[UIFont systemFontOfSize:16];
    //musicName.text=@"Tell Me Why";
    [self.view addSubview:musicName];
    
    //播放时间
    upAndAllTime=[[UILabel alloc] initWithFrame:CGRectMake(60, 430, 120, 20)];
    upAndAllTime.backgroundColor=[UIColor clearColor];
    upAndAllTime.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:upAndAllTime];
    
    //歌手照片
    musicImage=[[UIImageView alloc] initWithFrame:CGRectMake(5, 405, 50, 50)];
    //  musicImage.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:musicImage];
    /*   
     UIView *smallView=[[UIView alloc] initWithFrame:CGRectMake(150, 50, 100, 150)];
     // UITableView *smallTable=[[UITableView alloc] initWithFrame:CGRectMake(150, 50, 100, 150)];
     smallView.backgroundColor=[UIColor whiteColor];
     //[smallView addSubview:smallTable];
     [self.view addSubview:smallView];
     */ 
    
    //more选项界面
    moreActionTable=[[UITableView alloc] initWithFrame:CGRectMake(110, 80, 160, 240)];
    self.moreActionTable.delegate=self;
    self.moreActionTable.dataSource=self;
    self.moreActionTable.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.moreActionTable];
    self.moreActionTable.hidden=YES;
    UIView *moreActionTitle=[[UIView alloc] initWithFrame:CGRectMake(110, 80, 160, 40)];
    self.titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
    self.titlelabel.backgroundColor=[UIColor clearColor];
    moreActionTitle.backgroundColor=[UIColor blueColor];
    [moreActionTitle addSubview:titlelabel];
    self.moreActionTable.tableHeaderView=moreActionTitle;
    self.titlelabel.textAlignment=UITextAlignmentCenter;
    
    self.moreActionArray=[[NSMutableArray alloc] initWithObjects:@"添加最爱",@"歌曲信息",@"删除歌曲", nil];
    
    [moreActionTitle release];
    
    //歌曲信息界面.......................
    MusicMessageView=[[UIView alloc] initWithFrame:CGRectMake(30, 20, 260, 360)];
    MusicMessageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"8b.jpg"]];
    //MusicMessageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"8b.jpg"]];
    [self.view addSubview:MusicMessageView];
    UILabel *labeltitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 40)];
    labeltitle.backgroundColor=[UIColor yellowColor];
    labeltitle.font=[UIFont systemFontOfSize:18];
    labeltitle.text=@"歌曲信息";
    labeltitle.textAlignment=UITextAlignmentCenter;
    [self.MusicMessageView addSubview:labeltitle];
    
    UILabel *labelname=[[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 30)];
    labelname.backgroundColor=[UIColor clearColor];
    labelname.font=[UIFont systemFontOfSize:18];
    labelname.text=@" 歌曲: ";
    [self.MusicMessageView addSubview:labelname];
    
    UILabel *labelArtist=[[UILabel alloc] initWithFrame:CGRectMake(0, 70, 60, 30)];
    labelArtist.backgroundColor=[UIColor clearColor];
    labelArtist.font=[UIFont systemFontOfSize:18];
    labelArtist.text=@" 歌手: ";
    [self.MusicMessageView addSubview:labelArtist];
    
    UILabel *labelspecial=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, 60, 30)];
    labelspecial.backgroundColor=[UIColor clearColor];
    labelspecial.font=[UIFont systemFontOfSize:18];
    labelspecial.text=@" 专辑: ";
    [self.MusicMessageView addSubview:labelspecial];
    
    UILabel *labelstye=[[UILabel alloc] initWithFrame:CGRectMake(0, 130, 260, 30)];
    labelstye.backgroundColor=[UIColor clearColor];
    labelstye.font=[UIFont systemFontOfSize:18];
    labelstye.text=@" 风格: <未知>";
    [self.MusicMessageView addSubview:labelstye];
    
    UILabel *labeltime=[[UILabel alloc] initWithFrame:CGRectMake(0, 160, 60, 30)];
    labeltime.backgroundColor=[UIColor clearColor];
    labeltime.font=[UIFont systemFontOfSize:18];
    labeltime.text=@" 时长: ";
    [self.MusicMessageView addSubview:labeltime];
    
    UILabel *labelform=[[UILabel alloc] initWithFrame:CGRectMake(0, 190, 100, 30)];
    labelform.backgroundColor=[UIColor clearColor];
    labelform.font=[UIFont systemFontOfSize:18];
    labelform.text=@" 格式: mp3";
    [self.MusicMessageView addSubview:labelform];
    
    UILabel *labelpath=[[UILabel alloc] initWithFrame:CGRectMake(0, 220, 60, 30)];
    labelpath.backgroundColor=[UIColor clearColor];
    labelpath.font=[UIFont systemFontOfSize:18];
    labelpath.text=@" 路径: ";
    [self.MusicMessageView addSubview:labelpath];
    //歌曲名称
    self.musicNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(60, 40, 160, 30)];
    self.musicNameLabel.backgroundColor=[UIColor clearColor];
    self.musicNameLabel.font=[UIFont systemFontOfSize:18];
    [self.MusicMessageView addSubview:self.musicNameLabel];
    //歌曲时长
    self.musicTimeLabel=[[UILabel alloc] initWithFrame:CGRectMake(60, 160, 100, 30)];
    self.musicTimeLabel.backgroundColor=[UIColor clearColor];
    self.musicTimeLabel.font=[UIFont systemFontOfSize:18];
    [self.MusicMessageView addSubview:self.musicTimeLabel];
    //歌曲地址
    self.musicPathLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 230, 255, 130)];
    self.musicPathLabel.backgroundColor=[UIColor clearColor];
    self.musicPathLabel.font=[UIFont systemFontOfSize:15];
    self.musicPathLabel.numberOfLines=2;
    self.musicPathLabel.lineBreakMode=UILineBreakModeWordWrap;
    self.musicPathLabel.numberOfLines=0;
    [self.MusicMessageView addSubview:self.musicPathLabel];
    //歌手
    self.musicArtistLabel=[[UILabel alloc] initWithFrame:CGRectMake(60,70, 160, 30)];
    self.musicArtistLabel.backgroundColor=[UIColor clearColor];
    self.musicArtistLabel.font=[UIFont systemFontOfSize:18];
    [self.MusicMessageView addSubview:self.musicArtistLabel];
    //歌曲专辑
    self.musicAlbumLabel=[[UILabel alloc] initWithFrame:CGRectMake(60,100, 160, 30)];
    self.musicAlbumLabel.backgroundColor=[UIColor clearColor];
    self.musicAlbumLabel.font=[UIFont systemFontOfSize:18];
    [self.MusicMessageView addSubview:self.musicAlbumLabel];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(215, 325, 45, 35);
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(musicMessageAction) forControlEvents:UIControlEventTouchDown];
    [self.MusicMessageView addSubview:button];
    
    self.MusicMessageView.hidden=YES;
    [labeltitle release];
    [labelname release];
    [labelArtist release];
    [labelspecial release];
    [labelstye release];
    [labeltime release];
    [labelform release];
    [labelpath release];
    
    //    NSLog(@"aaaaaaaaaaaaaaa==  %@",self.imusicDb);
}
-(void)viewWillAppear:(BOOL)animated
{
    //添加 表头。。。。。。
    NSLog(@"%d",self.tmpIndex);
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    headerView.backgroundColor=[UIColor clearColor];
    NSMutableArray *tmpheader=[[NSMutableArray alloc] init];
    UIToolbar *headertoolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] 
                                initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace 
                                target: nil action: nil];
    [tmpheader addObject: spacer1];
    [spacer1 release];
    
    if (self.tmpIndex==0) 
    {
        UIBarButtonItem *header1=[[UIBarButtonItem alloc] 
                                  initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadView)];
        [tmpheader addObject:header1];
        [header1 release];
        
    }
    else if(self.tmpIndex==9)
    {
        UIBarButtonItem *header1=[[UIBarButtonItem alloc] 
                                  initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(AddMusic)];
        [tmpheader addObject:header1];
        [header1 release];
    }
    else
    {
        UIBarButtonItem *header1=[[UIBarButtonItem alloc] 
                                  initWithTitle:@"排序" style:UIBarButtonItemStylePlain target:self action:@selector(sortMusic)];
        [tmpheader addObject:header1];
        [header1 release];
    }
    UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] 
                                initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace 
                                target: nil action: nil];
    [tmpheader addObject: spacer2];
    [spacer2 release];
    
    UIBarButtonItem *header3=[[UIBarButtonItem alloc] 
                              initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backFirstView)];
    [tmpheader addObject:header3];
    [header3 release];
    
    UIBarButtonItem *spacer4 = [[UIBarButtonItem alloc] 
                                initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace 
                                target: nil action: nil];
    [tmpheader addObject: spacer4];
    [spacer4 release];
    
    [headertoolbar setItems:tmpheader];
    [headerView addSubview:headertoolbar];
    self.MusicListTable.tableHeaderView=headerView;
    
    
    [headerView release];
    [tmpheader release];
    [headertoolbar release];
    
    [super viewWillAppear:animated];
    
    [self.MusicListTable reloadData];
    
    self.MusicListTable.contentOffset=CGPointMake(0, 40); 
    
    //  NSLog(@"aaaaaaaaaaaaaaa==  %@",self.imusicDb);
}

/*******************************************
 函数名称：-(void)backFirstView
 函数功能：返回（九宫格）界面，实现跳转
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)backFirstView
{
    [self dismissModalViewControllerAnimated:YES];
}

/*******************************************
 函数名称：-(void)sortMusic
 函数功能：歌曲排序
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)sortMusic
{
    NSLog(@"Sort Music!!!");
}

/*******************************************
 函数名称：-(void)reloadView
 函数功能：刷新界面
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)reloadView
{
    NSLog(@"reloadView!!");
    
    // //9/4   if ([self.ms open]) {
    //        NSLog(@"open db ok");
    //    }else
    //    {
    //        NSLog(@"open db not ok");
    //    }
    
    
    [self.ms deleteaAll];
    
    //    //9/4[self.ms close];
    
    [self.iFirstMusicTableView onCellItem:0];
    
    
    
}

/*******************************************
 函数名称：-(void)AddMusic
 函数功能：刷新界面
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)AddMusic
{
    [self presentModalViewController:self.iallTheMusicTable animated:YES];
    NSLog(@"add music!!");
}

/*******************************************
 函数名称：-(void)playAction
 函数功能：实现播放功能
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)playAction
{
    [self.musicPlayer release];
    self.musicPlayer.currentTime=0.0;
    self.musicPlayer=[[AVAudioPlayer alloc] 
                      initWithContentsOfURL:musicpath error:nil];
    [self.musicPlayer  prepareToPlay];
    
    self.musicPlayer.volume=0.9;
    self.musicPlayer.delegate=self;
    
    self.playbutton.hidden=YES;
    self.paussbutton.hidden=NO;
    [self.musicPlayer play];
    
    NSLog(@"%f",self.musicPlayer.duration);
    
}

/*******************************************
 函数名称：-(void)play
 函数功能：播放按钮 调用的方法
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)play
{
    self.playbutton.hidden=YES;
    self.paussbutton.hidden=NO;
    [self.musicPlayer play];
}

/*******************************************
 函数名称：-(void)pauss
 函数功能：暂停按钮，实现暂停
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)pauss
{
    self.playbutton.hidden=NO;
    self.paussbutton.hidden=YES;
    [self.musicPlayer pause];
    
}

/*******************************************
 函数名称：-(void)jumpUp
 函数功能：上一首按钮，实现跳转
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)jumpUp
{
    musicpath= [self.tmpPath objectAtIndex:row-1];
    NSString *tmp=[self.listData objectAtIndex:row-1];
    self.musicName.text=tmp;
    [self playAction];
}

/*******************************************
 函数名称：-(void)jumpDown
 函数功能：下一首按钮，实现跳转
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)jumpDown
{
    musicpath= [self.tmpPath objectAtIndex:row+1];
    NSString *tmp=[self.listData objectAtIndex:row+1];
    self.musicName.text=tmp;
    [self playAction];
}

/*******************************************
 函数名称：-(void)jumpPlayView
 函数功能：跳转到播放界面
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)jumpPlayView
{
    NSLog(@"sdfsdfa");
}
/*******************************************
 函数名称：-(NSString *) transformTime: (NSTimeInterval) time
 函数功能：转换时间
 传入参数：无
 返回 值 ：无
 ********************************************/
-(NSString *) transformTime: (NSTimeInterval) time
{
	int _time = (int)time;
	int second = _time%60;	
	int minute = _time/60;	
	NSString *timeString = [[NSString alloc] initWithFormat: @"%.2i:%.2i",minute, second];
	[timeString autorelease];
	return timeString;
}

/*******************************************
 函数名称：-(void)moreAction
 函数功能：歌曲的更多功能（用来添加到收藏。。。）
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)moreAction
{
    if (self.moreActionTable.hidden==YES)
    {
        self.moreActionTable.hidden=NO;
        self.MusicListTable.userInteractionEnabled = NO;
    }
    else
    {
        self.moreActionTable.hidden=YES;
    }
    NSLog(@"more Action View!");
}

/*******************************************
 函数名称：-(void)musicMessageAction
 函数功能：关闭歌曲信息界面
 传入参数：无
 返回 值 ：无
 ********************************************/
-(void)musicMessageAction
{
    self.MusicMessageView.hidden=YES;
    self.moreActionTable.hidden=YES;
}

-(void)dealloc
{
    [musicAlbumLabel release];
    [musicArtistLabel release];
    [musicNameLabel release];
    [musicTimeLabel release];
    [musicPathLabel release];
    [MusicMessageView release];
    [moreActionArray release];
    [titlelabel release];
    [musicListTableCell release];
    [iFirstMusicTableView release];
    [listData release];
    [tmpPath release];
    [moreActionTable release];
    [musicPlayer release];
    [musicImage release];
    [musicName release];
    [musicArtist release];
    [upAndAllTime release];
    [playbutton release];
    [paussbutton release];
    [MusicListTable release];
    [ms release];
    [super dealloc];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    if (tableView==self.MusicListTable) 
    {NSLog(@"[self.listData count] = %d",[self.listData count]);
        return [self.imusicDb count];
    }
    else {NSLog(@"[self.moreActionArray count] = %d",[self.moreActionArray count]);
        return [self.moreActionArray count];}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消横线
    self.MusicListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (tableView==self.MusicListTable)
    {
        if (cell == nil)
        {
            
            self.musicListTableCell=[[MusicListTableCell alloc] initWithLabel];
            cell=self.musicListTableCell;
        }
        
        row=[indexPath row];
        //NSLog(@"+++++++++%@",self.imusicDb);
        musicListTableCell.musicNameLabel.text=[self.imusicDb musicAtIndex:row].name;
        //NSLog(@"[self.imusicDb musicAtIndex:row].name = %@",[self.imusicDb musicAtIndex:row].name);
        
        
        
        musicListTableCell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
        
    }
    else if(tableView==self.moreActionTable)
    {
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        }
        cell.textLabel.text=[self.moreActionArray objectAtIndex:[indexPath row]];
    }
    
    return cell;
    
    
}
#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    self.titlelabel.text=[self.imusicDb musicAtIndex:[indexPath row]].name;
    self.musicNameLabel.text=[self.imusicDb musicAtIndex:[indexPath row]].name;
    self.musicArtistLabel.text=[self.imusicDb musicAtIndex:[indexPath row]].artist;
    self.musicAlbumLabel.text=[self.imusicDb musicAtIndex:[indexPath row]].album;
    self.musicPathLabel.text=[[self.imusicDb musicAtIndex:[indexPath row]].url path];
    
    tmpMusic=[self.imusicDb musicAtIndex:[indexPath row]];
    
    musicTimeLabel.text=[self transformTime: self.musicPlayer.duration];
    
    [self moreAction];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.MusicListTable) 
    {
        //选中颜色 即刻消失；
        [self.MusicListTable deselectRowAtIndexPath:indexPath animated:YES];
        
        musicpath= [self.imusicDb musicAtIndex:[indexPath row]].url;
        [self playAction];
        //    //显示歌曲名
        NSString *tmp=[self.imusicDb musicAtIndex:[indexPath row]].name;
        self.musicName.text=tmp;
        self.musicImage.image=[self.imusicDb musicAtIndex:[indexPath row]].image;
        //最近播放............
        [self.iFirstMusicTableView.latePlayMusicDb addMusic:[self.imusicDb musicAtIndex:[indexPath row]]];
        
        
    }
    
    else
    {
        [self.moreActionTable deselectRowAtIndexPath:indexPath animated:YES];
        row=[indexPath row];
        NSLog(@"abc=%d",row);
        if (row==0) 
        {
            //添加最爱   
            UIAlertView* insertLove = [[UIAlertView alloc]initWithTitle:@"添加最爱" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [insertLove setTag:101];
            [insertLove show];
            [insertLove release];
            
            //[self.ms insertLove:tmpMusic];
            //[self.iFirstMusicTableView.loveMusicDb addMusic:tmpMusic];
        }
        else if (row==1) 
        {
            //歌曲信息
            self.MusicMessageView.hidden=NO;
        }
        else if (row==2) 
        {
            //删除歌曲
            if (0 == self.tmpIndex) {
                
                UIAlertView* deleteAlert = [[UIAlertView alloc]initWithTitle:@"删除歌曲" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除列表", nil];
                [deleteAlert setTag:100];
                [deleteAlert addButtonWithTitle:@"删除列表及本地文件"];
                [deleteAlert show];
                [deleteAlert release];
            }else
            {
                UIAlertView* deleteLove = [[UIAlertView alloc]initWithTitle:@"删除最爱" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] ;
                [deleteLove setTag:102];
                [deleteLove show];
                [deleteLove release];
            }
            //[self.ms deleteaNote:tmpMusic];
            //[self.imusicDb removeMusic:tmpMusic];
            //[self.MusicListTable reloadData];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (100 == alertView.tag)
    {
        
        NSLog(@"buttonindex = %d",buttonIndex);
        if (1 == buttonIndex) {
            [self.imusicDb removeMusic:tmpMusic];
            [self.MusicListTable reloadData];
            
        }else
            if(2 == buttonIndex)
            {
                [self.ms deleteaNote:tmpMusic];
                [self.imusicDb removeMusic:tmpMusic];
                [self.MusicListTable reloadData];
            }
        
    }else 
        if(101 == alertView.tag)
        {
            if (1 == buttonIndex) {
                [self.ms insertLove:tmpMusic];
            }
        }else
            if (102 == alertView.tag) {
                if(1 == buttonIndex)
                {
                    [self.ms updateLove:0 andMusic:tmpMusic ];//更改love值
                    [self.imusicDb removeMusic:tmpMusic];
                    [self.MusicListTable reloadData];
                }
            }
    
    self.moreActionTable.hidden=YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.MusicListTable.userInteractionEnabled = YES;
    self.moreActionTable.hidden=YES;
}


@end











