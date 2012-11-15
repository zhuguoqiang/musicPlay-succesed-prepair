//
//  OKview.h
//  MusicPlay
//
//  Created by student on 12-8-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKview : UIView
{
    float red;
    float green;
    float blue;
    float fa;
}

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, assign) float time; 
@property (nonatomic, assign) float with;
@property (nonatomic, assign) float fa;

- (void)play:(float)frame;
- (void)playback:(float)frame;
- (void)Play:(float)frame;
- (void)Playback:(float)frame;
- (void)setText:(NSString *)text;
- (void)setRed:(float)_red Green:(float)_green Blue:(float)_blue;

@end
