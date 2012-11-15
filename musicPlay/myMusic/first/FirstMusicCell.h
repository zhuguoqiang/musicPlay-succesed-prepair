//
//  FirstMusicCell.h
//  MusicPlayer2
//
//  Created by student on 12-8-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@protocol cellItemDelegate;

@interface FirstMusicCell : UITableViewCell
{
    UIButton *btn1; //九宫格里的第一个格
    UIButton *btn2; //九宫格里的第二个格
    UIButton *btn3; //九宫格里的第三个格
    
    UILabel *lbl1;  //九宫格里的第一个格的标签
    UILabel *lbl2;  //九宫格里的第二个格的标签
    UILabel *lbl3;  //九宫格里的第三个格的标签
    
	id <cellItemDelegate> tableCellDelegate;
    
}

@property(nonatomic, assign) id <cellItemDelegate> tableCellDelegate;;

@property(nonatomic, retain) UIButton *btn1;
@property(nonatomic, retain) UIButton *btn2;
@property(nonatomic, retain) UIButton *btn3;

@property(nonatomic, retain) UILabel *lbl1;
@property(nonatomic, retain) UILabel *lbl2;
@property(nonatomic, retain) UILabel *lbl3;

/*******************************************
 函数名称：(id)initWithLableAndButton  
 函数功能：初始化九宫格和九宫格的标签
 传入参数：N/A
 返回 值： N/A
 ********************************************/
- (id)initWithLableAndButton;

/*******************************************
 函数名称：(void)click:(id)sender  
 函数功能：处理九宫各宫格的单击
 传入参数：(id)sender
 返回 值： N/A
 ********************************************/
- (void)click:(id)sender;

@end


@protocol cellItemDelegate

@optional

/*******************************************
 函数名称：(void)onCellItem:(int)index  
 函数功能：获取用户单击九宫格的序号，实现此协议时实现
 传入参数：(int)index
 返回 值： N/A
 ********************************************/
- (void)onCellItem:(int)index;


@end
