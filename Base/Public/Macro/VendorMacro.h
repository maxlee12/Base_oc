//
//  VendorMacro.h
//  XibDemo
//
//  Created by lawrence on 16/9/9.
//  Copyright © 2016年 lawrence. All rights reserved.
//

#ifndef VendorMacro_h
#define VendorMacro_h

//main sleep
#define msleep(ms) usleep(ms*1000)


#define LHColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#endif /* VendorMacro_h */
