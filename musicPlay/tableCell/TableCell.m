/***************************************************
 文件名称：TableCell.h
 作   者：任海丽
 备   注：自定义cell实现文件
 创建时间：2012-6-6
 修改历史：
 版权声明：Copyright 2012 . All rights reserved.
 ***************************************************/

#import "TableCell.h"

@implementation TableCell

@synthesize lbIndex,name,btnDownload,aritst,alubm,delegate;

-(id)init{
    if(self=[super init]){
        self.lbIndex=[[UILabel alloc]initWithFrame:CGRectMake(5, 15, 20, 30)];
        self.lbIndex.textColor=[UIColor redColor];
        self.lbIndex.backgroundColor=[UIColor clearColor];
        
        self.name=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 100, 30)];
        [self.name setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        self.name.backgroundColor=[UIColor clearColor];
        
        self.aritst=[[UILabel alloc]initWithFrame:CGRectMake(130, 0, 90, 30)];
        self.aritst.text=@"歌手名";
        [self.aritst setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        self.aritst.backgroundColor=[UIColor clearColor];
        self.alubm=[[UILabel alloc]initWithFrame:CGRectMake(30, 30, 230, 30)];
        self.alubm.text=@"专辑名";
        [self.alubm setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        self.alubm.backgroundColor=[UIColor clearColor];
        //self.downImage=[[UIImageView alloc]initWithFrame:CGRectMake(260, 5, 30, 30)];
        self.btnDownload=[[UIButton alloc]initWithFrame:CGRectMake(260, 5, 30, 30)];
        [self.btnDownload addTarget:self action:@selector(downMusic:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.lbIndex];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.btnDownload];
        [self.contentView addSubview:self.aritst];
        [self.contentView addSubview:self.alubm];
    }
    
    return self;
}
/*******************************************
 函数名称：-(void)downMusic:(UIButton*)button;
 函数功能：点击下载按钮所触发的方法
 传入参数：N/A
 返回 值 ： N/A
 ********************************************/
-(void)downMusic:(UIButton*)button{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(downMusic:)]) {
        [self.delegate downMusic:button];
    }
}

- (void)dealloc {
    self.lbIndex = nil;
    self.name=nil;
    self.btnDownload = nil;
    self.aritst=nil;
    self.alubm=nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
