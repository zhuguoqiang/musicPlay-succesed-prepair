//
//  FirstMusicTableView.m
//  MusicPlayer2
//
//  Created by student on 12-8-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstMusicTableView.h"
#import "Read.h"
#import "Write.h"
#import "MusicListViewController.h"
@interface NSString  (Sub)

-(NSString *)sub:(NSString *)str;
@end

@implementation NSString (Sub)
/*******************************************
 函数名称：-(NSString *)sub:(NSString *)str
 函数功能：截取路径中的名字
 传入参数：str
 返回 值 ：temp
 ********************************************/
-(NSString *)sub:(NSString *)str
{
    NSRange range = [self rangeOfString:str];
    
    NSString * temp = [[self copy]autorelease];
    
    while (range.location != NSNotFound) {
        
        temp = [temp substringFromIndex:range.location+1];
        
        range = [temp rangeOfString:str];
        
    }
    return temp;
}

@end

@implementation FirstMusicTableView
@synthesize iMusicListViewController;
@synthesize iFirstMusicCell;
@synthesize titleArray;
@synthesize imageArray;
@synthesize itemArray;
@synthesize itemarray;
@synthesize listName;
@synthesize array1;
@synthesize array2;
@synthesize array3;
@synthesize array4;
@synthesize array5;
@synthesize array6;
@synthesize array7;
@synthesize read;
@synthesize write;
@synthesize listPath;
@synthesize path;
@synthesize loveMusicName;
@synthesize loveMusicPath;
@synthesize myCollectMusicName;
@synthesize myCollectMusicPath;
@synthesize latePlayMusicName;
@synthesize latePlayMusicPath;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*******************************************
 函数名称：InitData 
 函数功能：初始化数据函数
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
- (void)InitData
{
    int i=0;
    itemArray=[[NSMutableArray alloc]init];
    itemarray=[NSArray arrayWithObjects:
                        [[ImageAndTitle alloc]InitWithImage:[array1 objectAtIndex:i] AndTitle:@"全部歌曲"],
                        [[ImageAndTitle alloc]InitWithImage:[array2 objectAtIndex:i] AndTitle:@"我的收藏"],
                        [[ImageAndTitle alloc]InitWithImage:[array3 objectAtIndex:i] AndTitle:@"我的最爱"],
                        [[ImageAndTitle alloc]InitWithImage:[array4 objectAtIndex:i] AndTitle:@"新建列表"],
                        [[ImageAndTitle alloc]InitWithImage:[array5 objectAtIndex:i] AndTitle:@"最近播放"],
                        [[ImageAndTitle alloc]InitWithImage:[array6 objectAtIndex:i] AndTitle:@"缓存音乐"],
                        nil];
    [self setItem:itemarray];
}
/*******************************************
 函数名称：(void)setItem:(NSArray *)temperatureArray 
 函数功能：转载九宫格的图片数组和文字数组
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
- (void)setItem:(NSArray *)temperatureArray
{
	[self->itemArray addObjectsFromArray:temperatureArray];
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
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"8b.jpg"]];
//    UIImageView *backImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    backImage.image=[UIImage imageNamed:@"8b.jpg"];
//    [self.view addSubview:backImage];
    self.iMusicListViewController=[[MusicListViewController alloc] init];
    self.iMusicListViewController.iFirstMusicTableView = self;
    
    [super viewDidLoad];
    self.array1=[[NSMutableArray alloc] initWithObjects:@"全部歌曲1.png",@"全部歌曲2.bmp",@"全部歌曲3.png",@"全部歌曲4.png", nil];
    self.array2=[[NSMutableArray alloc] initWithObjects:@"我的收藏1.png",@"我的收藏2.bmp",@"我的收藏3.png",@"我的收藏4.png", nil];
    self.array3=[[NSMutableArray alloc] initWithObjects:@"我的最爱1.png",@"我的最爱2.bmp",@"我的最爱3.png",@"我的最爱4.gif", nil];
    self.array4=[[NSMutableArray alloc] initWithObjects:@"新建列表1.png",@"新建列表2.bmp",@"新建列表3.png",@"新建列表4.png", nil];
    self.array5=[[NSMutableArray alloc] initWithObjects:@"最近播放1.png",@"最近播放2.bmp",@"最近播放3.png",@"最近播放4.png", nil];
    self.array6=[[NSMutableArray alloc] initWithObjects:@"缓存音乐1.png",@"缓存音乐2.bmp",@"缓存音乐3.png",@"缓存音乐4.png", nil];
    self.array7=[[NSMutableArray alloc] initWithObjects:@"全部歌曲1.png",@"全部歌曲2.bmp",@"全部歌曲3.png",@"全部歌曲4.png", nil];
    
    [self InitData];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*******************************************
 函数名称：- (void) enterList
 函数功能：跳转到播放列表
 传入参数：
 返回 值 ：
 ********************************************/
- (void) enterList
{
    [self presentModalViewController:self.iMusicListViewController animated:YES];
}

/*******************************************
 函数名称：(void)onCellItem:(int)index 
 函数功能：cellItemDelegate协议的回调方法，获取
 用户单击九宫格的序号
 传入参数：(int)index 九宫格的序号
 返回 值 ： N/A
 ********************************************/
- (void)onCellItem:(int)index
{
    NSLog(@"index is %d",index);
    if (0 == index)
    {
        NSString *tmpstring;
        self.iMusicListViewController.listData=nil;
        self.iMusicListViewController.tmpPath=nil;
        //扫描本地文件
        self.read=[[[Read alloc] init] autorelease];
        self.write=[[[Write alloc] init] autorelease];
        [self run];
        
        NSMutableArray *array=[NSMutableArray arrayWithCapacity:10];
        for (int i=0; i<[self.listPath count]; i++)
        {
            tmpstring=[[self.listPath objectAtIndex:i]sub:@"/"];
            [array addObject:[tmpstring substringToIndex:[tmpstring length]-4]];
        }
        
        self.iMusicListViewController.listData=array;
        self.iMusicListViewController.tmpPath=self.listPath;
        [self enterList];
    }
    else if(1 == index)
    {
        self.iMusicListViewController.listData=self.myCollectMusicName;
        self.iMusicListViewController.tmpPath=self.myCollectMusicPath;
        [self enterList];
    }
    else if (2 == index)
    {
        self.iMusicListViewController.listData=self.loveMusicName;
        self.iMusicListViewController.tmpPath=self.loveMusicPath;
        [self enterList];
    }
    else if (3 == index)
    {
        UIAlertView *addList=[[UIAlertView alloc] initWithTitle:@"＋新建列表" message:@"" delegate: self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        self.listName=[[UITextField alloc] initWithFrame:CGRectMake(20, 38, 245, 20)];
        self.listName.backgroundColor=[UIColor whiteColor];
        self.listName.borderStyle=UITextBorderStyleRoundedRect;
        self.listName.textAlignment=UITextAlignmentCenter;
        [addList addSubview:self.listName];
        self.listName.delegate=self;
        self.listName.text=@"新建列表";
        [addList show];
        [addList release];
        
    }
    else if (4 == index)
    {
        self.iMusicListViewController.listData=self.latePlayMusicName;
        self.iMusicListViewController.tmpPath=self.latePlayMusicPath;
        [self enterList];
    }
    else if(6 == index)
    {
        [self enterList];
    }
    else 
    {
        
    }
    
}

/*******************************************
 函数名称：- (void)run
 函数功能：判断播放列表是否存在,如果存在就读取,不存在就创建
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)run
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSLog(@"documentsDirectory = %@",documentsDirectory);
    if (!documentsDirectory) {
        NSLog(@"没用找到 Documents!");
        return;
    }
    NSString *appFile=[documentsDirectory stringByAppendingPathComponent:@"All.txt"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:appFile])
    {
        NSLog(@"列表文件已经找到");
        [self readtxt];
    }
    else
    {
        NSLog(@"没用找到列表文件");
        [self searchButtonPress];
        [self writetxt];
    }
}
/*******************************************
 函数名称：-(void)searchButtonPress
 函数功能：扫描本地文件
 传入参数：无
 返回 值 ：listPath
 ********************************************/
-(void)searchButtonPress
{
    NSArray *pathArray=NSSearchPathForDirectoriesInDomains(NSUserDirectory, NSUserDirectory, YES);
    NSLog(@"pathArray=%@",pathArray);
    NSMutableArray *paths=[NSMutableArray arrayWithCapacity:10];
    for (int i=0; i<[pathArray count]; i++) 
    {
        NSFileManager *manager;
        manager=[NSFileManager defaultManager];
        
        NSString *home=[[pathArray objectAtIndex:i] stringByExpandingTildeInPath];
        NSDirectoryEnumerator *direnum= [manager enumeratorAtPath:home];
        NSString *filename;
        while (filename=[direnum nextObject])
        {
            if ([self boolMusicFile:filename]) 
            {
                NSString *fileFullName=[((NSString *)[pathArray objectAtIndex:i]) stringByAppendingPathComponent:[NSString stringWithFormat:filename]];
                [paths addObject:fileFullName];
            }
        }
    }
    self.listPath=paths;
    self.path=pathArray;
   // [self.MusicListTable reloadData];
}

/*******************************************
 函数名称：-(BOOL)boolMediaFile:(NSString *)file
 函数功能：判断是否支持格式
 传入参数：file
 返回 值 ：BOOl
 ********************************************/
-(BOOL)boolMusicFile:(NSString *)file
{
    NSString *pathExtension=[file pathExtension];
    if ([pathExtension compare:@"mp3" options:NSCaseInsensitiveSearch|NSNumericSearch]==NSOrderedSame) 
    {
        return YES;
    }
    return NO;
}

/*******************************************
 函数名称：- (void)readtxt
 函数功能：读取播放列表
 传入参数：resdstream
 返回 值 ：listPath
 ********************************************/
- (void)readtxt
{
    self.listPath=read._array;
    [self.read resdstream];
    while ([self.read.read isEqualToString:@"NO"])
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    self.listPath=read._array;
    //[self.MusicListTable reloadData];
}

/*******************************************
 函数名称：- (void)writetxt
 函数功能：写播放列表
 传入参数：listPath
 返回 值 ：resData
 ********************************************/
- (void)writetxt
{
    self.write.showarray=self.listPath;
    [self.write resData];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) 
    {
//        itemarray=[NSArray arrayWithObjects:[[ImageAndTitle alloc]InitWithImage:[array7 objectAtIndex:2] AndTitle:self.listName.text]];
//        [self setItem:itemarray];
    }
}


-(void)dealloc
{
//    [loveMusicPath release];
//    [loveMusicName release];
    [iFirstMusicCell release];
    [itemArray release];
    [titleArray release];
    [imageArray release];
    [listName release];
    [array1 release];
    [array2 release];
    [array3 release];
    [array4 release];
    [array5 release];
    [array6 release];
    [array7 release];
    [iMusicListViewController release];
    [listPath release];
    [path release];
    
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
    NSLog(@"lovemusic=%d",[self.loveMusicName count]);
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView 
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        iFirstMusicCell=[[FirstMusicCell alloc] initWithLableAndButton];
        iFirstMusicCell.tableCellDelegate=self;
        iFirstMusicCell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell=iFirstMusicCell;
        cell.backgroundColor=[UIColor clearColor];
    }
    //取消tableview的单元格的线。
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    if ((indexPath.row*3)<=([itemArray count]-1)) 
	{
		ImageAndTitle* i=[itemArray objectAtIndex:indexPath.row*3];
        
		iFirstMusicCell.lbl1.text=[NSString stringWithFormat:@"%@",i.Title];
        
		[iFirstMusicCell.btn1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",i.Image]] forState:UIControlStateNormal];
        
		[iFirstMusicCell.btn1 setTag:indexPath.row*3];
	}
    if ((indexPath.row*3+1)<=([itemArray count]-1)) 
	{
		ImageAndTitle * i=[itemArray objectAtIndex:indexPath.row*3+1];
        
		iFirstMusicCell.lbl2.text=[NSString stringWithFormat:@"%@",i.Title];
		[iFirstMusicCell.btn2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",i.Image]] forState:UIControlStateNormal];
		[iFirstMusicCell.btn2 setTag:indexPath.row*3+1];
	}
	if ((indexPath.row*3+2)<=([itemArray count]-1)) 
	{
		ImageAndTitle * i=[itemArray objectAtIndex:indexPath.row*3+2];
        
		iFirstMusicCell.lbl3.text=[NSString stringWithFormat:@"%@",i.Title];
		[iFirstMusicCell.btn3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",i.Image]] forState:UIControlStateNormal];
		[iFirstMusicCell.btn3 setTag:indexPath.row*3+2];
	}
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
//去键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder ];
    return YES;
}



@end
