//
//  UIBarButtonItem+LH.h
//  GLink
//
//  Created by lawrence on 16/9/23.
//  Copyright © 2016年 lawrence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LH)
+ (instancetype)barButtonItemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage targer:(id)target action:(SEL)action;
@end
