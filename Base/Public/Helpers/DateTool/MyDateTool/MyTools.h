//
//  MyTools.h
//  TimeTest
//
//  Created by 刘文鹏 on 3/10/14.
//  Copyright (c) 2014 gorson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTools : NSObject

/**
 *  标准时间字符串转换成时间类型
 *
 *  @return 时间类型
 */
+ (NSDate *)getDateWithString:(NSString *)timeStr andFormatter:(NSString *)format;

/**
 *  获取当前时间的时间戳（例子：1464326536）
 *
 *  @return 时间戳字符串型
 */
+ (NSString *)getCurrentTimestamp;


/**
 *  获取当天开始的时间戳（例子：1464326536）
 *
 *  @return 时间戳字符串型
 */
+ (NSString *)getTodayStartTimestamp;

/**
 *  获取当天结束标准时间（例子：1464326536-02-03）
 *
 *  @return 标准时间字符串型
 */
+ (NSString *)getTodayStopTimestamp;



/**
 *  NSDate转时间戳
 *
 *  @param date 字符串时间
 *
 *  @return 返回时间戳
 */
+ (NSInteger)timestampFromDate:(NSDate *)date;

+ (NSInteger)timestampFromString:(NSString *)timeStr format:(NSString *)format;

+ (NSString *)getCurrentStandarTimeWithFormatter:(NSString *)format;
/**
 *  时间戳转换为时间的方法
 *
 *  @param timestam 时间戳
 *
 *  @return 标准时间字符串 1464326536 ——》 2015-02-03
 */
+ (NSString *)timestampChangesStandarTime:(NSString *)timestam WithFormatter:(NSString *)format;

 /*
  时间转换星期
  */
+(NSString *)timeToweek:(NSString *)time WithFormatter:(NSString *)format;

 /*
  英文转换中文星期
  */
+(NSString*)getweek:(NSString*)week;

@end
