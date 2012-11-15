/***************************************************
 文件名称：Music.h
 作   者：任海丽
 备   注：音乐头文件
 创建时间：2012-6-6
 修改历史：
 版权声明：Copyright 2012 . All rights reserved.
 ***************************************************/

#import <Foundation/Foundation.h>

@interface Music : NSObject<NSCopying,NSCoding>{
    NSURL *url;//歌曲的地址
    NSString *name;//歌曲的名字
    NSString *album;//歌曲的专辑名
    NSString *artist;//演唱者
    UIImage *image;//专辑图片
    NSNumber *number;//播放次数
    BOOL recently;//最近播放
    BOOL love;//是否收藏
    NSString *lrcpath;//歌词路径
    NSString *httpp;
}
@property(nonatomic,retain)NSURL *url;//歌曲的地址
@property(nonatomic,retain)NSString *name;//歌曲的名字
@property(nonatomic,retain)NSString *album;//歌曲的专辑名
@property(nonatomic,retain)NSString *artist;//演唱者
@property(nonatomic,retain)UIImage *image;//专辑图片
@property(nonatomic,retain)NSNumber *number;//播放次数

@property(nonatomic,assign)BOOL recently;//最近播放
@property(nonatomic,assign)BOOL love;//是否收藏

@property(nonatomic,retain)NSString *lrcpath;//歌词路径
@property(nonatomic,strong)NSString *httpp;
//-(id)init;
/*******************************************
 函数名称：-(id)initUrl:(NSURL *)iUrl
 函数功能：音乐初始化方法
 传入参数：iUrl
 返回 值 ： N/A
 ********************************************/
-(id)initUrl:(NSURL *)iUrl;
/*******************************************
 函数名称：-(id)initUrl:(NSURL *)iUrl andLrcPath:(NSString*)iLrcPath
 函数功能：音乐初始化方法
 传入参数：iUrl。iLrcPath
 返回 值 ： N/A
 ********************************************/
-(id)initUrl:(NSURL *)iUrl andLrcPath:(NSString*)iLrcPath;
/*******************************************
 函数名称：-(NSComparisonResult)compareName:(id)element
 函数功能：按name排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSComparisonResult)compareName:(id)element;
/*******************************************
 函数名称：-(NSComparisonResult)compareAlbum:(id)element
 函数功能：按Album排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSComparisonResult)compareAlbum:(id)element;
/*******************************************
 函数名称：-(NSComparisonResult)compareArtist:(id)element
 函数功能：按Artist排序
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(NSComparisonResult)compareArtist:(id)element;
/*******************************************
 函数名称：-(void)albumInformation
 函数功能：获取歌曲的专辑名，演唱者和歌名
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)albumInformation;
/*******************************************
 函数名称：-(void)imageName
 函数功能：获取专辑图片
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)imageName;

@end
