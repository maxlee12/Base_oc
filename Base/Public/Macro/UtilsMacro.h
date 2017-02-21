//
//  UtilsMacro.h
//  XibDemo
//
//  Created by lawrence on 16/9/9.
//  Copyright © 2016年 lawrence. All rights reserved.
//

//方便使用的 （颜色、尺寸等）
#ifndef UtilsMacro_h
#define UtilsMacro_h


//main sleep
#define msleep(ms) usleep(ms*1000)

#define BasicColor rgb(214,41,117,1)
#define rgb(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#endif /* UtilsMacro_h */
