/***************************************************
 文件名称：Music.m
 作   者：任海丽
 备   注：音乐实现文件
 创建时间：2012-6-6
 修改历史：
 版权声明：Copyright 2012 . All rights reserved.
 ***************************************************/

#import "Music.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation Music
@synthesize url,name,album,artist,image,number,recently,love,lrcpath;
/*
-(id)init{
    self=[super init];
    if(!self){
        [self release];
        return nil;
    }
    url=[[NSURL alloc]init];
    name=[[NSString alloc]init];
    album=[[NSString alloc]init];
    artist=[[NSString alloc]init];
    image=[[NSString alloc]init];
    number=[[NSNumber alloc]init];
    lyrics=[[NSString alloc]init];
    recently=NO;
    love=NO;
    return self;
}
 */
/*******************************************
 函数名称：-(id)initUrl:(NSURL *)iUrl
 函数功能：音乐初始化方法
 传入参数：iUrl
 返回 值 ： N/A
 ********************************************/
-(id)initUrl:(NSURL*)iUrl{
    self=[super init];
    if(!self){
        [self release];
        return nil;
    }
    url=iUrl;
    //获取专辑信息
    [self albumInformation];
    if (!self.name) {
        name=[[NSString alloc]initWithString:@"未知歌名"];
    }
    if (!self.album) {
        album=[[NSString alloc]initWithString:@"未知专辑"];
    }
    if (!self.artist) {
        artist=[[NSString alloc]initWithString:@"未知歌手"];
    }
    //获取图片

    [self imageName];
    if (!self.image) {
        //default_music
        NSBundle *bundle=[NSBundle mainBundle];
        image=[[UIImage alloc]initWithContentsOfFile:[bundle pathForResource:@"default_music" ofType:@"png"]];
    }
    
    number=[[NSNumber alloc]init];

    recently=NO;
    love=NO;
    //歌词路径
    lrcpath=[[NSString alloc]init];
    return self;
}
/*******************************************
 函数名称：-(id)initUrl:(NSURL *)iUrl andLrcPath:(NSString*)iLrcPath
 函数功能：音乐初始化方法
 传入参数：iUrl。iLrcPath
 返回 值 ： N/A
 ********************************************/
-(id)initUrl:(NSURL *)iUrl andLrcPath:(NSString*)iLrcPath{
    self=[super init];
    if(!self){
        [self release];
        return nil;
    }
    url=iUrl;
    //获取专辑信息
    [self albumInformation];
    if (!self.name) {
        name=[[NSString alloc]initWithString:@"未知歌名"];
    }
    if (!self.album) {
        album=[[NSString alloc]initWithString:@"未知专辑"];
    }
    if (!self.artist) {
        artist=[[NSString alloc]initWithString:@"未知歌手"];
    }
    //获取图片
    
    [self imageName];
    if (!self.image) {
        //default_music
        NSBundle *bundle=[NSBundle mainBundle];
        image=[[UIImage alloc]initWithContentsOfFile:[bundle pathForResource:@"default_music" ofType:@"png"]];
    }
    number=[[NSNumber alloc]init];
    
    recently=NO;
    love=NO;
    //歌词路径
    lrcpath=iLrcPath;
    if (!self.lrcpath) {
        lrcpath=[[NSString alloc]init];
        NSLog(@"如果是空的话就执行");
    }
    return self;
}
/*******************************************
 函数名称：-(NSComparisonResult)compareName:(id)element
 函数功能：按name排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSComparisonResult)compareName:(id)element{
    return [self.name compare:[element name]];
}
/*******************************************
 函数名称：-(NSComparisonResult)compareAlbum:(id)element
 函数功能：按Album排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSComparisonResult)compareAlbum:(id)element{
    return [self.album compare:[element album]];
}
/*******************************************
 函数名称：-(NSComparisonResult)compareArtist:(id)element
 函数功能：按Artist排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSComparisonResult)compareArtist:(id)element{
    return [self.artist compare:[element artist]];
}
#pragma mark NSCopying
-(id)copyWithZone:(NSZone *)zone{
    Music *newMusic=[[Music allocWithZone:zone]init];
    newMusic.url=self.url;
    newMusic.name=self.name;
    newMusic.album=self.album;
    newMusic.artist=self.artist;
    newMusic.image=self.image;
    newMusic.number=self.number;
    newMusic.recently=self.recently;
    newMusic.love=self.love;
    newMusic.lrcpath=self.lrcpath;
    return newMusic;
}
#pragma mark NSCoding
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.lrcpath forKey:@"lrcpath"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.album forKey:@"album"];
    [aCoder encodeObject:self.artist forKey:@"artist"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.number forKey:@"number"];
    [aCoder encodeBool:self.recently forKey:@"recently"];
    [aCoder encodeBool:self.love forKey:@"love"];
    
    NSLog(@"写成功");
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if(!self){
        return nil;
    }
    self.url=[aDecoder decodeObjectForKey:@"url"];
    self.lrcpath=[aDecoder decodeObjectForKey:@"lrcpath"];
    self.name=[aDecoder decodeObjectForKey:@"name"];
    self.album=[aDecoder decodeObjectForKey:@"album"];
    self.artist=[aDecoder decodeObjectForKey:@"artist"];
    self.image=[aDecoder decodeObjectForKey:@"image"];
    self.number=[aDecoder decodeObjectForKey:@"number"];
    self.recently=[aDecoder decodeBoolForKey:@"recently"];
    self.love=[aDecoder decodeBoolForKey:@"love"];
    
    
    return self;
}
/*******************************************
 函数名称：-(void)albumInformation
 函数功能：获取歌曲的专辑名，演唱者和歌名
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)albumInformation{
    //NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];//建立一个自动释放池 pool
    NSString *fileExtension = [[url path] pathExtension];
    
    if ([fileExtension isEqual:@"mp3"]||[fileExtension isEqual:@"m4a"])
    {
        //根据url获取fileId：一个不透明的音频文件对象的引用。
        AudioFileID fileID  = nil;
        //OSStatus err=noErr;        
        AudioFileOpenURL( (CFURLRef) url, kAudioFileReadPermission, 0, &fileID );
       /*
        if( err != noErr ) {
            NSLog( @"AudioFileOpenURL failed" );
        }
        */
        //得到返回CFDictionary填补了在该文件中包含的数据信息。
        NSDictionary *piDict = nil;
        UInt32 piDataSize   = sizeof( piDict );
        AudioFileGetProperty( fileID, kAudioFilePropertyInfoDictionary, &piDataSize, &piDict );
        /*
        if( err != noErr ) {
            [piDict release];
            NSLog( @"AudioFileGetProperty failed for property info dictionary" );
        }   
         */
        fileID  = nil;
        //专辑名
        NSString * _Album = [(NSDictionary*)piDict objectForKey: 
                             [NSString stringWithUTF8String: kAFInfoDictionary_Album]];
        /*
        if([_Album canBeConvertedToEncoding:1]){
            NSLog(@"_Album1%@",_Album);
        }
        if([_Album canBeConvertedToEncoding:2]){
            NSLog(@"_Album2%@",_Album);
        }
        if([_Album canBeConvertedToEncoding:3]){
            NSLog(@"_Album3%@",_Album);
        }
        if([_Album canBeConvertedToEncoding:4]){
            NSLog(@"_Album4%@",_Album);
        }
        if([_Album canBeConvertedToEncoding:5]){
            NSLog(@"_Album5%@",_Album);
        }
        if([_Album canBeConvertedToEncoding:6]){
            NSLog(@"_Album6%@",_Album);
        }
        if([_Album canBeConvertedToEncoding:7]){
            NSLog(@"_Album7%@",_Album);
        }
        if([_Album canBeConvertedToEncoding:8]){
            NSLog(@"_Album8%@",_Album);
        }
        if([_Album canBeConvertedToEncoding:10]){
            NSLog(@"_Album10%@",_Album);
        }
        if([_Album canBeConvertedToEncoding:11]){
            NSLog(@"_Album11%@",_Album);
        }
        if([_Album canBeConvertedToEncoding:12]){
            NSLog(@"_Album12%@",_Album);
        }
        if([_Album canBeConvertedToEncoding:13]){
            NSLog(@"_Album13%@",_Album);
        }
         */
        //NSLog(@"_Album-----1212-%@",_Album);
        if([_Album canBeConvertedToEncoding:8]||[_Album canBeConvertedToEncoding:3]){
            self.album=_Album;
        }else{
            char converted_Album[([_Album length] + 1)];
            [_Album getCString:converted_Album maxLength:([_Album length] + 1) encoding: NSISOLatin1StringEncoding];     
            self.album = [NSString stringWithCString:converted_Album encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        }
    //    NSLog(@"self.album = %@",self.album);
        //演唱者
        NSString * _Artist = [(NSDictionary*)piDict objectForKey: 
                              [NSString stringWithUTF8String: kAFInfoDictionary_Artist]];
        /*
        if([_Artist canBeConvertedToEncoding:1]){
            NSLog(@"_Album1%@",_Artist);
        }
        if([_Artist canBeConvertedToEncoding:2]){
            NSLog(@"_Album2%@",_Artist);
        }
        if([_Artist canBeConvertedToEncoding:3]){
            NSLog(@"_Album3%@",_Artist);
        }
        if([_Artist canBeConvertedToEncoding:4]){
            NSLog(@"_Album4%@",_Artist);
        }
        if([_Artist canBeConvertedToEncoding:5]){
            NSLog(@"_Album5%@",_Artist);
        }
        if([_Artist canBeConvertedToEncoding:6]){
            NSLog(@"_Album6%@",_Artist);
        }
        if([_Artist canBeConvertedToEncoding:7]){
            NSLog(@"_Album7%@",_Artist);
        }
        if([_Artist canBeConvertedToEncoding:8]){
            NSLog(@"_Album8%@",_Artist);
        }
        if([_Artist canBeConvertedToEncoding:10]){
            NSLog(@"_Album10%@",_Artist);
        }
        if([_Artist canBeConvertedToEncoding:11]){
            NSLog(@"_Album11%@",_Artist);
        }
        if([_Artist canBeConvertedToEncoding:12]){
            NSLog(@"_Album12%@",_Artist);
        }
        if([_Album canBeConvertedToEncoding:13]){
            NSLog(@"_Album13%@",_Album);
        }
        */
        if(![_Artist canBeConvertedToEncoding:2]){
            self.artist=_Artist;
        }else{
            char converted_Artist[([_Artist length] + 1)];
            [_Artist getCString:converted_Artist maxLength:([_Artist length] + 1) encoding: NSISOLatin1StringEncoding];     
            self.artist = [NSString stringWithCString:converted_Artist encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        }
        
      //  NSLog(@"self.artist = %@",self.artist);
        //歌曲名
        NSString * _Title = [(NSDictionary*)piDict objectForKey: 
                             [NSString stringWithUTF8String: kAFInfoDictionary_Title]];
        if(![_Title canBeConvertedToEncoding:2]){
            self.name=_Title;
        }else{
            char converted[([_Title length] + 1)];
            [_Title getCString:converted maxLength:([_Title length] + 1) encoding: NSISOLatin1StringEncoding];     
            self.name = [NSString stringWithCString:converted encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        }
     //   NSLog(@"self.album = %@",self.name);
        piDict = nil;
    }
    fileExtension=nil;
    //[pool drain];//开始销毁自动释放池
}
/*******************************************
 函数名称：-(void)imageName
 函数功能：获取专辑图片
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)imageName{
    AVURLAsset *a = [AVURLAsset URLAssetWithURL:url options:nil];
    //图片解析
    NSArray *k = [NSArray arrayWithObjects:@"commonMetadata", nil];
    [a loadValuesAsynchronouslyForKeys:k completionHandler:^
     {
         NSArray *artworks = [AVMetadataItem metadataItemsFromArray:a.commonMetadata
                                                            withKey:AVMetadataCommonKeyArtwork keySpace:AVMetadataKeySpaceCommon];
         
         NSMutableArray *artworkImages = [NSMutableArray array];
         for (AVMetadataItem *i in artworks)
         {
             NSString *keySpace = i.keySpace;
             UIImage *im = nil;
             
             if ([keySpace isEqualToString:AVMetadataKeySpaceID3])
             {
                 NSDictionary *d = [[i.value copyWithZone:nil]autorelease];
                 im = [UIImage imageWithData:[d objectForKey:@"data"]];
             }
             else if ([keySpace isEqualToString:AVMetadataKeySpaceiTunes])
                 im = [UIImage imageWithData:[[i.value copyWithZone:nil]autorelease]];
             
             if (im)
                 [artworkImages addObject:im];
         }
         if ([artworkImages count]>0) {
              self.image=[artworkImages objectAtIndex:0];
         }
     }];
}
/*******************************************
 函数名称：-(NSString *)description
 函数功能：打印语句 大中国
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSString *)description{
    NSString *string=[NSString stringWithFormat:@"url=%@,recently=%d,love=%d",self.url,self.recently,self.love];
    return string;
}
/*******************************************
 函数名称：-(void)dealloc
 函数功能：析构方法
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)dealloc{
    [url release];
    [name release];
    [album release];
    [artist release];
    [image release];
    [number release];
    [lrcpath release];
    [super dealloc];
}
@end
