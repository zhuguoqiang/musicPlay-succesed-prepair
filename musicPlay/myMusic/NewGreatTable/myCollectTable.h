//
//  myCollectTable.h
//  MusicPlayer2
//
//  Created by student on 12-8-21.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicListViewController;
@class FirstMusicTableView;
@interface myCollectTable : UITableViewController

@property(nonatomic, retain)NSMutableArray *GreatArray;
@property(nonatomic, retain)MusicListViewController *iMusicListView;

@property(nonatomic, retain)FirstMusicTableView *iFirstMusicView;
@end
