//
//  ChangeStringView.h
//  Pear
//
//  Created by lawrence on 16/8/18.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeStringView : UIView
@property(nonatomic,copy) NSString *titleStr;      //标题栏
@property(nonatomic,copy) NSString *oldName;       //需要修改的文字

//修改后block返回 
@property (nonatomic,copy) void (^ReturnNewStrBlock)(NSString *newStr);
@end
