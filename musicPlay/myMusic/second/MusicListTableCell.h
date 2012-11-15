//
//  MusicListTableCell.h
//  MusicPlay
//
//  Created by student on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicListTableCell : UITableViewCell
{
    UILabel *musicNameLabel;     //歌曲名称Label
    UILabel *artistAndAlbumNameLabel;    //艺术家Label
}
@property(nonatomic, retain) UILabel *musicNameLabel;
@property(nonatomic, retain) UILabel *artistAndAlbumNameLabel;
@property(nonatomic, retain) UIButton *moreButton;

-(id)initWithLabel;

@end
