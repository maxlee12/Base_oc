//
//  XQImageView.h
//  imageViews
//
//  Created by ChenPark on 16/9/13.
//  Copyright © 2016年 ChenPark. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XQImageViewDelegate <NSObject>
-(void)returnXQImageViewHeight:(CGFloat)height;
-(void)returnImages:(NSArray *)photos;
@end
@interface XQImageView : UIView
@property (nonatomic, weak) id <XQImageViewDelegate> delegate;
//初始化的时候不添加图片但是限定最多多少张图片
-(instancetype)initWithFrame:(CGRect)frame maxCount:(int)maxCount;
//初始化的时候不添加图片并且限定最多多少张图片
-(instancetype)initWithFrame:(CGRect)frame images:(NSArray *)imageArray maxCount:(int)maxCount;
//设置最多显示多少张图片
@property (assign,nonatomic) int maxCount;
@end
