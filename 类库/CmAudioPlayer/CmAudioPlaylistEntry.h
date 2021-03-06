/*
 *  CmAudioPlaylistEntry.h
 *
 *  Copyright (c) 2008, 2009, 2010 CodeMorphic, Inc. (www.codemorphic.com)
 *
 *  This file is part of CoMoRadio.
 *
 *  CoMoRadio is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  CoMoRadio is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with CoMoRadio.  If not, see <http://www.gnu.org/licenses/>.
 */

@interface CmAudioPlaylistEntry : NSObject {
 @private
  NSString *  streamTitle_;
  NSString *  streamURL_;
  NSInteger   streamLength_;
}

@property (nonatomic, retain) NSString * streamTitle;
@property (nonatomic, retain) NSString * streamURL;
@property (nonatomic, assign) NSInteger streamLength;

@end
