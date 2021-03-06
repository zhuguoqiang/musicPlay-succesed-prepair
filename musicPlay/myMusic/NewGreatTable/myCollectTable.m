//
//  myCollectTable.m
//  MusicPlayer2
//
//  Created by student on 12-8-21.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "myCollectTable.h"
#import "MusicListViewController.h"
#import "FirstMusicTableView.h" 

@implementation myCollectTable

@synthesize GreatArray;
@synthesize iMusicListView;
@synthesize iFirstMusicView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    [super viewDidLoad];
    
    self.iFirstMusicView=[[FirstMusicTableView alloc] init];
    
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    headerView.backgroundColor=[UIColor clearColor];
    NSMutableArray *tmpheader=[[NSMutableArray alloc] init];
    UIToolbar *headertoolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] 
                                initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace 
                                target: nil action: nil];
	[tmpheader addObject: spacer1];
	[spacer1 release];
    
    UIBarButtonItem *header1=[[UIBarButtonItem alloc] 
                              initWithTitle:@"排序" style:UIBarButtonItemStylePlain target:self action:@selector(sortMusic)];
    [tmpheader addObject:header1];
    [header1 release];
    
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
    self.tableView.tableHeaderView=headerView;
    
    
    [headerView release];
    [tmpheader release];
    [headertoolbar release];
    
    self.iMusicListView=[[MusicListViewController alloc] init];
    
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
    [self.tableView reloadData];
    self.tableView.contentOffset=CGPointMake(0, 40);
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

-(void)dealloc
{
    [super dealloc];
    [iFirstMusicView release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.GreatArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    cell.textLabel.text=[self.GreatArray objectAtIndex:[indexPath row]];
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
    self.iMusicListView.tmpIndex=9;
    self.iFirstMusicView.iMusicListViewController.listData=nil;
    self.iFirstMusicView.iMusicListViewController.tmpPath=nil;

    [self presentModalViewController:self.iMusicListView animated:YES];

}

@end
