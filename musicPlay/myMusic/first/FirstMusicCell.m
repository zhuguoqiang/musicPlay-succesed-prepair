//
//  FirstMusicCell.m
//  MusicPlayer2
//
//  Created by student on 12-8-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstMusicCell.h"

@implementation FirstMusicCell

@synthesize delegate;

@synthesize btn1;
@synthesize btn2;
@synthesize btn3;

@synthesize lbl1;
@synthesize lbl2;
@synthesize lbl3;

/*******************************************
 函数名称：(id)initWithLableAndButton  
 函数功能：初始化九宫格和九宫格的标签
 传入参数：N/A
 返回 值： N/A
 ********************************************/
- (id)initWithLableAndButton
{
    self = [super init];
    if (self)
    {
        lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 100, 90, 30)];
	    lbl1.backgroundColor = [UIColor clearColor];
		lbl1.textColor = [UIColor blueColor];
		
        btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(25,25,68, 60);
        [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(125, 100, 90, 30)];
	    lbl2.backgroundColor = [UIColor clearColor];
		lbl2.textColor = [UIColor blueColor];
		
        btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(125,25,68, 60);
        [btn2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(225, 100, 90, 30)];
	    lbl3.backgroundColor = [UIColor clearColor];
		lbl3.textColor = [UIColor blueColor];
		
        btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.frame = CGRectMake(225,25,68, 60);
        [btn3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:btn1];
	    [self.contentView addSubview:lbl1];
        
        [self.contentView addSubview:btn2];
	    [self.contentView addSubview:lbl2];
        
        [self.contentView addSubview:btn3];
	    [self.contentView addSubview:lbl3];
    }
    
    return self;
}   


/*******************************************
 函数名称：(void)click:(id)sender  
 函数功能：处理九宫各宫格的单击
 传入参数：(id)sender
 返回 值： N/A
 ********************************************/
- (void)click:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    if (nil != delegate && [delegate responsToSelector:@selector(onCellItem:)]) {
        [delegate onCellItem:button.tag];
    }
	
}

- (void)dealloc 
{
	self.btn1 = nil;
	self.btn2 = nil;
	self.btn3 = nil;
    
    self.lbl1 = nil;
    self.lbl2 = nil;
    self.lbl3 = nil;
    [super dealloc];
}

@end
