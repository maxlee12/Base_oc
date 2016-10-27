//
//  UIBarButtonItem+LH.m
//  GLink
//
//  Created by lawrence on 16/9/23.
//  Copyright © 2016年 lawrence. All rights reserved.
//

#import "UIBarButtonItem+LH.h"

@implementation UIBarButtonItem (LH)

+ (instancetype)barButtonItemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage targer:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.image = image;
    btn.highlightedImage = highlightImage;
    
    [btn sizeToFit];
    
    [btn addTarget:target action:action];
    
    return [[self alloc] initWithCustomView:btn];
    
}
@end
