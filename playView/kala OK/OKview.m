//
//  OKview.m
//  MusicPlay
//
//  Created by student on 12-8-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "OKview.h"

@implementation OKview

@synthesize text = _text;
@synthesize font = _font;
@synthesize time = _time;
@synthesize with = _with;
@synthesize fa;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGSize size = [self.text sizeWithFont:self.font];
    size.width = 1.2 * size.width;
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.with) {
        CGContextSetLineWidth(context, self.with);
    }else CGContextSetLineWidth(context, 0.8);
    CGContextSetRGBFillColor(context, red, green, blue, 1.0);
    [self.text drawInRect:CGRectMake(0 - fa, 0, size.width, size.height) withFont:self.font];
}

- (void)play:(float)frame
{
    self.frame = CGRectMake(330, 270, frame, 28);
    [self setNeedsDisplay];
}

- (void)playback:(float)frame
{
    fa = frame;
    self.frame = CGRectMake(330 + frame, 270, 300 - frame, 28);
    [self setNeedsDisplay];
}

- (void)Play:(float)frame
{
    self.frame = CGRectMake(360, 298, frame, 28);
    [self setNeedsDisplay];
}

- (void)Playback:(float)frame
{
    fa = frame;
    self.frame = CGRectMake(360 + frame, 298, 300 - frame, 28);
    [self setNeedsDisplay];
}

- (void)setRed:(float)_red Green:(float)_green Blue:(float)_blue
{
    red = _red;
    green = _green;
    blue = _blue;
}

@end








