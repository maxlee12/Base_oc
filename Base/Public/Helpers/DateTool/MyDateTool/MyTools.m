//
//  MyTools.m
//  TimeTest
//
//  Created by 刘文鹏 on 3/10/14.
//  Copyright (c) 2014 gorson. All rights reserved.
//

#import "MyTools.h"

@implementation MyTools

/**
 *  标准时间字符串转换成时间类型
 *  
 *  @
 *  @return 时间类型
 */
+ (NSDate *)getDateWithString:(NSString *)timeStr andFormatter:(NSString *)format
{
    NSDateFormatter * dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:format];
    NSDate * date = [dateformatter dateFromString:timeStr];
    return date;
}

/**
 *  获取当前时间的时间戳（例子：1464326536）
 *
 *  @return 时间戳字符串型
 */
+ (NSString *)getCurrentTimestamp
{
    //获取系统当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    // 转为字符型
    return timeString;
}

/**
 *  获取当天开始的时间戳（例子：1464326536）
 *
 *  @return 时间戳字符串型
 */
+ (NSString *)getTodayStartTimestamp{
    
    //获取系统当前的时间戳
    NSDate* fromdate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *selfDateFormat=[[NSDateFormatter alloc]init];
    [selfDateFormat setDateFormat:@"yyyy-MM-dd 00:00:00"];
    NSString* selfString=[selfDateFormat stringFromDate:fromdate];
    

    //
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* dateTodo = [dateFormat dateFromString:selfString];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[dateTodo timeIntervalSince1970]];
    
    return timeSp;
}

/**
 *  获取当天结束标准时间（例子：1464326536-02-03）
 *
 *  @return 标准时间字符串型
 */
+ (NSString *)getTodayStopTimestamp{
    //获取系统当前的时间戳
    NSDate* fromdate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *selfDateFormat=[[NSDateFormatter alloc]init];
    [selfDateFormat setDateFormat:@"yyyy-MM-dd 23:59:59"];
    NSString* selfString=[selfDateFormat stringFromDate:fromdate];
    
    //
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* dateTodo = [dateFormat dateFromString:selfString];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[dateTodo timeIntervalSince1970]];
    
    return timeSp;
    
    
    
}



//将date转换成时间戳
+ (NSInteger)timestampFromDate:(NSDate *)date
{
    return (long)[date timeIntervalSince1970];
}

+ (NSInteger)timestampFromString:(NSString *)timeStr format:(NSString *)format
{
    NSDate *date = [self getDateWithString:timeStr andFormatter:format];
    return [self timestampFromDate:date];
}

/**
 *  获取当前标准时间（例子：2015-02-03）
 *
 *  @return 标准时间字符串型
 */
+ (NSString *)getCurrentStandarTimeWithFormatter:(NSString *)format
{
    NSDate * senddate=[NSDate date];

    NSDateFormatter * dateformatter=[[NSDateFormatter alloc] init];

    [dateformatter setDateFormat:format];

    NSString * locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

/**
 *  时间戳转换为时间的方法
 *
 *  @param timestamp 时间戳
 *
 *  @return 标准时间字符串
 */
+ (NSString *)timestampChangesStandarTime:(NSString *)timestamp WithFormatter:(NSString *)format
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;

}

+(NSString *)timeToweek:(NSString *)time WithFormatter:(NSString *)format
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *formatterDate = [inputFormatter dateFromString:time];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//    [outputFormatter setDateFormat:@"HH:mm 'on' EEEE MMMM d"];
    // For US English, the output is:
    // newDateString 10:30 on Sunday July 11
    [outputFormatter setDateFormat:@"EEEE"];
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    return newDateString;
}

/*
 
 转换为中文星期
 
 */
+(NSString*)getweek:(NSString*)week
{
    //返回中文和英文由系统确定
    NSString*weekStr=nil;
    if ([week containsString:@"day"]) {
        if([week isEqualToString:@"Sunday"])
        {
            weekStr=@"星期天";
        }else if([week isEqualToString:@"Monday"]){
            weekStr=@"星期一";
            
        }else if([week isEqualToString:@"Tuesday"]){
            weekStr=@"星期二";
            
        }else if([week isEqualToString:@"Wednesday"]){
            weekStr=@"星期三";
            
        }else if([week isEqualToString:@"Thursday"]){
            weekStr=@"星期四";
            
        }else if([week isEqualToString:@"Friday"]){
            weekStr=@"星期五";
            
        }else if([week isEqualToString:@"Saturday"]){
            weekStr=@"星期六";
            
        }
        return weekStr;
    }
    
    else{
       return week;
    }

}

@end
