//
//  UIView+Frame.h
//  Drink
//
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property CGFloat drink_width;
@property CGFloat drink_height;
@property CGFloat drink_x;
@property CGFloat drink_y;
@property CGFloat drink_centerY;
@property CGFloat drink_centerX;

+(instancetype)drinkViewFromType;
@end
