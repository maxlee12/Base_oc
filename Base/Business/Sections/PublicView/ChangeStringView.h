//
//  ChangeStringView.h
//  Pear
//
//  Created by lawrence on 16/8/18.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeStringView : UIView
@property(nonatomic,copy) NSString *titleStr;
@property(nonatomic,copy) NSString *oldName;
@property (nonatomic,copy) void (^ReturnNewStrBlock)(NSString *newStr);
@end
