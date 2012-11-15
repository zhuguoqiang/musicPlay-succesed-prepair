//
//  FirstMusicTableView.h
//  MusicPlayer2
//
//  Created by student on 12-8-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstMusicCell.h"
#import "ImageAndTitle.h"
@class Read;
@class Write;
@class MusicListViewController;
@class myCollectTable;
@class allTheMusicTable;
@class Music;
@class MusicDb;
@class MusicSqlite;

@interface FirstMusicTableView : UITableViewController <cellItemDelegate,UITabBarControllerDelegate,UITextFieldDelegate>
{
    FirstMusicCell *iFirstMusicCell;//字定义单元格
    NSArray* titleArray;   //用来转载九宫格的显示的文字
    NSArray* imageArray;   //用来转载九宫格的显示的图片
    NSMutableArray *itemArray; //用来装置九宫格文字数组和图片数组的数组
    
}
@property (nonatomic, retain) FirstMusicCell *iFirstMusicCell;
@property (nonatomic, retain) NSMutableArray *itemArray;
@property (nonatomic, retain) NSArray* titleArray;
@property (nonatomic, retain) NSArray* imageArray;
@property (nonatomic, retain) UITextField *listName;
@property (nonatomic, retain) NSMutableArray *array1; 
@property (nonatomic, retain) NSMutableArray *array2;
@property (nonatomic, retain) NSMutableArray *array3;
@property (nonatomic, retain) NSMutableArray *array4;
@property (nonatomic, retain) NSMutableArray *array5;
@property (nonatomic, retain) NSMutableArray *array6;
@property (nonatomic, retain) NSMutableArray *array7;
@property (nonatomic, retain) NSMutableArray *itemarray;

@property(nonatomic, strong)Read *read;
@property(nonatomic, strong)Write *write;
@property(nonatomic, retain)NSMutableArray *listPath;
@property(nonatomic, retain)NSArray *path;

@property(nonatomic, retain)MusicListViewController *iMusicListViewController;

@property(nonatomic, retain)MusicDb *loveMusicDb;

@property(nonatomic, retain)MusicDb *latePlayMusicDb;

@property(nonatomic, retain)myCollectTable *imyCollectTable;
@property(nonatomic, retain)NSMutableArray *tmpNewTable;
@property(nonatomic, retain)allTheMusicTable *iallMusicTable;

@property(nonatomic, retain)MusicDb *allMusicDb;
@property(nonatomic, retain)MusicSqlite* ms;

/*******************************************
 函数名称：InitData 
 函数功能：初始化数据函数
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
- (void)InitData;   
/*******************************************
 函数名称：(void)setItem:(NSArray *)temperatureArray 
 函数功能：转载九宫格的图片数组和文字数组
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/

- (void)setItem:(NSArray *)temperatureArray;

/*******************************************
 函数名称：- (void)run
 函数功能：判断播放列表是否存在,如果存在就读取,不存在就创建
 传入参数：无
 返回 值 ：无
 ********************************************/

- (void)run;

/*******************************************
 函数名称：-(MusicDb*)searchButtonPress
 函数功能：扫描本地文件
 传入参数：无
 返回 值 ：MusicDb
 ********************************************/

-(MusicDb*)searchButtonPress;

/*******************************************
 函数名称：-(BOOL)boolMediaFile:(NSString *)file
 函数功能：判断是否支持格式
 传入参数：file
 返回 值 ：BOOl
 ********************************************/

-(BOOL)boolMusicFile:(NSString *)file;

/*******************************************
 函数名称：- (void)readtxt
 函数功能：读取播放列表
 传入参数：resdstream
 返回 值 ：listPath
 ********************************************/

- (void)readtxt;

/*******************************************
 函数名称：- (void)writetxt
 函数功能：写播放列表
 传入参数：listPath
 返回 值 ：resData
 ********************************************/

- (void)writetxt;

/*******************************************
 函数名称：- (void) enterList
 函数功能：跳转到播放列表
 传入参数：
 返回 值 ：
 ********************************************/

- (void) enterList;


@end
