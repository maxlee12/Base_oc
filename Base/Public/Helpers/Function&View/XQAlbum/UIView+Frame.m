//
//  UIView+Frame.m
//  Drink
//
//  Copyright © 2016年 Chenpark. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

+(instancetype)drinkViewFromType{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}

- (CGFloat)drink_centerX
{
    return self.center.x;
}
- (void)setDrink_centerX:(CGFloat)drink_centerX
{
    CGPoint center = self.center;
    center.x = drink_centerX;
    self.center = center;
}

- (CGFloat)drink_centerY
{
    return self.center.y;
}
- (void)setDrink_centerY:(CGFloat)drink_centerY
{
    CGPoint center = self.center;
    center.y = drink_centerY;
    self.center = center;
}

- (CGFloat)drink_height
{
    return self.frame.size.height;
}

- (void)setDrink_height:(CGFloat)drink_height
{
    CGRect rect = self.frame;
    rect.size.height = drink_height;
    self.frame = rect;
}

- (CGFloat)drink_width
{
    return self.frame.size.width;
}

- (void)setDrink_width:(CGFloat)drink_width
{
    CGRect rect = self.frame;
    rect.size.width = drink_width;
    self.frame = rect;

}

- (CGFloat)drink_x
{
    return self.frame.origin.x;
}

- (void)setDrink_x:(CGFloat)drink_x
{
    CGRect rect = self.frame;
    rect.origin.x = drink_x;
    self.frame = rect;

}

- (CGFloat)drink_y
{
    return self.frame.origin.y;
}
- (void)setDrink_y:(CGFloat)drink_y
{
    CGRect rect = self.frame;
    rect.origin.y = drink_y;
    self.frame = rect;

}
@end
