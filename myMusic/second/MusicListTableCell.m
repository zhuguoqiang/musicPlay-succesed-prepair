//
//  MusicListTableCell.m
//  MusicPlay
//
//  Created by student on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicListTableCell.h"

@implementation MusicListTableCell
@synthesize musicNameLabel;
@synthesize artistAndAlbumNameLabel;
@synthesize moreButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithLabel
{
    if (self=[super init])
    {
        self.musicNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 10, 250, 20)];
        self.musicNameLabel.backgroundColor=[UIColor clearColor];
        self.musicNameLabel.textColor=[UIColor whiteColor];
        self.musicNameLabel.font=[UIFont systemFontOfSize:18];
        [self.contentView addSubview:self.musicNameLabel];
        /*
        self.artistAndAlbumNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(5,20, 160, 20)];
        self.artistAndAlbumNameLabel.backgroundColor=[UIColor clearColor];
        self.artistAndAlbumNameLabel.textColor=[UIColor whiteColor];
        self.artistAndAlbumNameLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.artistAndAlbumNameLabel];
        
        self.moreButton=[[UIButton alloc] initWithFrame:CGRectMake(280, 0, 40, 40)];
        [self.moreButton setImage:[UIImage imageNamed:@"34149.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.moreButton];
    */
    }
    return self;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dealloc
{
    [moreButton release];
    [musicNameLabel release];
    [artistAndAlbumNameLabel release];
    [super dealloc];
}


@end
