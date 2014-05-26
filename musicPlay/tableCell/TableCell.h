/***************************************************
 文件名称：TableCell.h
 作   者：任海丽
 备   注：自定义cell头文件
 创建时间：2012-6-6
 修改历史：
 版权声明：Copyright 2012 . All rights reserved.
 ***************************************************/

#import <UIKit/UIKit.h>
@protocol donwMusicDelegate <NSObject>
-(void)downMusic:(UIButton*)sender;
@end
@interface TableCell : UITableViewCell{
    UILabel *lbIndex;
    UILabel *name;
    UILabel *aritst;
    UILabel *alubm;
    UIButton *btnDownload;
}
@property (nonatomic, retain) UILabel *lbIndex;
@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *aritst;
@property (nonatomic, retain) UILabel *alubm;
@property (nonatomic, retain) UIButton *btnDownload;
@property (nonatomic, assign) id<donwMusicDelegate>delegate;
/*******************************************
 函数名称：-(void)downMusic:(UIButton*)button;
 函数功能：点击下载按钮所触发的方法
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)downMusic:(UIButton*)button;
@end
