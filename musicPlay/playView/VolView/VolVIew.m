//
//  VolVIew.m
//  MusicPlay
//
//  Created by student on 12-8-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "VolVIew.h"

@implementation VolVIew

@synthesize value = _value; 
@synthesize MaximumTrackImage = _MaximumTrackImage;
@synthesize MaximumTrackImageview = _MaximumTrackImageview;
@synthesize MinimumTrackImage = _MinimumTrackImage;
@synthesize MinimumTrackImageview = _MinimumTrackImageview;
@synthesize target = _target;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        a = frame.size.height;
        self.MaximumTrackImageview = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, a)] autorelease];
        self.MinimumTrackImageview = [[[UIImageView alloc] initWithFrame:CGRectMake(0, a, 0, 0)] autorelease];
        [self addSubview:self.MaximumTrackImageview];
        [self addSubview:self.MinimumTrackImageview];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setValue:(float)value
{
    if ((_value != value) && (value >= 0) && (value <= 1)) {
        _value =value;
        self.MaximumTrackImageview.frame = CGRectMake(0, 0, self.frame.size.width, a * (1 - _value));
        self.MinimumTrackImageview.frame = CGRectMake(0, a * (1 - _value), self.frame.size.width, a * _value);
        [self.target performSelector:_action withObject:self];
    }
}
- (float)value
{
    return _value;
}

- (void)setMaximumTrackImage:(UIImage *)MaximumTrackImage
{
    _MaximumTrackImage = MaximumTrackImage;
    self.MaximumTrackImageview.image = _MaximumTrackImage;
}

- (void)setMinimumTrackImage:(UIImage *)MinimumTrackImage
{
    _MinimumTrackImage = MinimumTrackImage;
    self.MinimumTrackImageview.image = _MinimumTrackImage;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    float b = point.y;
    if (a) {
        self.value = (a - b) / a;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    int b = point.y;
    if (a) {
        self.value = (a - b) / a;
    }
}

- (void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    _action = action;
}

- (void)dealloc
{
    self.MinimumTrackImageview = nil;
    self.MinimumTrackImage = nil;
    self.MaximumTrackImageview = nil;
    self.MaximumTrackImage = nil;
    self.target = nil;
    [super dealloc];
}

@end









