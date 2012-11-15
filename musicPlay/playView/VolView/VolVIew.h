//
//  VolVIew.h
//  MusicPlay
//
//  Created by student on 12-8-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VolVIew : UIView
{
    float a;
    SEL _action;
}
@property (nonatomic, assign) float value; 
@property (nonatomic, retain) UIImage *MaximumTrackImage;
@property (nonatomic, retain) UIImageView *MaximumTrackImageview;
@property (nonatomic, retain) UIImage *MinimumTrackImage;
@property (nonatomic, retain) UIImageView *MinimumTrackImageview;
@property (nonatomic, retain) id target;

- (void)addTarget:(id)target action:(SEL)action;

@end
