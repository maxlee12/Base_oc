//
//  AppMacro.h
//  XibDemo
//
//  Created by lawrence on 16/9/9.
//  Copyright © 2016年 lawrence. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

//app相关的宏定义  网络接口





//
//无拼接取出字符串
#define  INTER_Str(s_key) ([NSString stringWithFormat:NSLocalizedStringFromTable(s_key, @"Localizable",nil)])
//有拼接取出字符串
//直接使用 [NSString stringWithFormat:NSLocalizedStringFromTable(@"info_msg_reGetSecond", @"LogAndRegist", nil),拼接值,.....];

//查找中文方法
//@"[^"]*[\u4E00-\u9FA5]+[^"\n]*?"


#endif /* AppMacro_h */
