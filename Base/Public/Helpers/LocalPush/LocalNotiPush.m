//
//  LocalNotiPush.m
//  Pear
//
//  Created by lawrence on 16/7/14.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "LocalNotiPush.h"
#import "MyTools.h"

double ONEDAY_m = 24*60*60;
double ONEMinutes_ms = 1*60*1000;
@implementation LocalNotiPush




+(void)isSendLoaclPushWithRuleDic:(NSDictionary*)ruleDic{
    
    //得到分断函数
    NSDictionary *periodDic = [self initperiodDic:ruleDic];
    
    //获取系统时区
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    DebugLog(@"localTimeZone is -->%@",localTimeZone);
    
    NSTimeZone *systemTimeZone = [NSTimeZone systemTimeZone];
    DebugLog(@"systemTimeZone -->%@",systemTimeZone);
    
    NSTimeZone *defaultTimeZone = [NSTimeZone defaultTimeZone];
    DebugLog(@"defaultTimeZone -->%@", defaultTimeZone);
    

    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    DebugLog(@"%@",ruleDic[@"tomorrowNeedCheckin"]);
    UIApplication *application = [UIApplication sharedApplication];
    //     && [self.checkInRoleDic[@"tomorrowNeedCheckin"] isEqualToString:@"true"]
    
    if ([[defaults objectForKey:@"isSupportLocalPush"] isEqualToString:@"YES"]) {
        
        //注册通知
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
            
            [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert categories:nil]];
        }
        
        if ([periodDic[@"periodArr"] count]) {
            //
            [self cancleAllNotifation];
            //
        }
        
        for (NSArray *arr in periodDic[@"periodArr"]) {
            
            [LocalNotiPush addWorkNotiWith:[NSString stringWithFormat:@"%@",[arr firstObject]] andCheckInOrCheckOutType:CHECK_IN];
            
            [LocalNotiPush addWorkNotiWith:[NSString stringWithFormat:@"%@",[arr lastObject]]andCheckInOrCheckOutType:CHECK_OUT];
        }
        
    }
    else
    {
        
#warning mark --lawDelete
//        [self cancelLocalNotificationWithKey:@"noticeWorkLocalPush"];
    }
    
}

+ (void)addWorkNotiWith:(NSString*)workingTime andCheckInOrCheckOutType:(CHECKTYPE)checkType{
    

//    User *currentUser = [[UserManager sharUserManager] currentUser];
    UIApplication *application = [UIApplication sharedApplication];

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UILocalNotification * notification = [[UILocalNotification alloc] init];
        
        //获取提醒的提前时长
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * noticeCheckInTime = [[defaults objectForKey:@"checkInNoticeTime"] stringValue];
        NSString * noticeCheckOutTime = [[defaults objectForKey:@"checkOutNoticeTime"] stringValue];
        if (!noticeCheckInTime) {
            
           noticeCheckInTime = @"5";
        }
        if (!noticeCheckOutTime) {
            noticeCheckOutTime = @"5";
        }
        
        //计算通知的时间
        NSString *startNotiTime;
        //
        if(checkType == CHECK_IN)
        {
            startNotiTime = [NSString stringWithFormat:@"%f",[workingTime integerValue] -[noticeCheckInTime integerValue]*ONEMinutes_ms];

//            notification.alertBody = [NSString stringWithFormat:@"%@ 还有%@分钟就到上班时间了，记得打卡哦！",currentUser.userCompanyName,noticeCheckInTime];
        }
        else
        {
        startNotiTime = [NSString stringWithFormat:@"%f",[workingTime integerValue] +[noticeCheckOutTime integerValue]*ONEMinutes_ms];
//            notification.alertBody = [NSString stringWithFormat:@"%@ 下班时间已经过了%@分钟,记得打卡哦！",currentUser.userCompanyName,noticeCheckOutTime];
        }
        
        
        //
        NSTimeZone *beiJingZone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
        notification.timeZone = beiJingZone;
        
        //通知的相关设置
        NSDate *fireDate =  [self zoneChange:[startNotiTime substringToIndex:10]]; /*不用这个方法转换时间戳，后台是北京时间，只许要把时区设置为北京时区就可以了。*/
        fireDate =  [NSDate dateWithTimeIntervalSince1970:[[startNotiTime substringToIndex:10] integerValue]];
        notification.fireDate = fireDate;

        //
        notification.repeatInterval = kCFCalendarUnitDay;
        notification.alertTitle = @"打卡通知";
        notification.alertAction = @"OK";
        notification.soundName = UILocalNotificationDefaultSoundName;

        NSDictionary*info = [NSDictionary dictionaryWithObject:@"default" forKey:@"noticeWorkLocalPush"];
        notification.userInfo = info;
        //发送通知
        [application scheduleLocalNotification:notification];
        DebugLog(@"add_notification-----%@------", notification.fireDate);

    });
}



#pragma mark -- 取消所有的通知
+(void)cancleAllNotifation{
    
    UIApplication *application = [UIApplication sharedApplication];
    
     for (UILocalNotification *notification in application.scheduledLocalNotifications) {
         
         DebugLog(@"cancel_notification-----%@------", notification.fireDate);
     }
    
    [application cancelAllLocalNotifications];
    application.applicationIconBadgeNumber = 0;
}

#pragma mark -- 取消通知某通知
+ (void)cancelLocalNotificationWithKey:(NSString *)key {
    
    UIApplication *application = [UIApplication sharedApplication];

    // 获取所有本地通知数组
    NSArray *localNotifications = application.scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                DebugLog(@"cancel_notification-----%@------", notification.fireDate);
                break;  
            }  
        }  
    }  
}  

//将时间戳转换成NSDate,加上时区偏移
+(NSDate*)zoneChange:(NSString*)spString{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp dateByAddingTimeInterval: interval];
    return localeDate;
}
//比较给定NSDate与当前时间的时间差，返回相差的秒数
+(long)timeDifference:(NSDate *)date{
    NSDate *localeDate = [NSDate date];
    long difference =fabs([localeDate timeIntervalSinceDate:date]);
    return difference;
}

+(NSMutableDictionary*)initperiodDic:(NSDictionary*)checkInRoleDic{
    

    NSMutableDictionary *periodDic = [NSMutableDictionary new];
    //时段数据赋值
    NSMutableArray *periodarr = [NSMutableArray array];
    NSMutableArray *cannoCheckArr = [NSMutableArray array];
    NSMutableArray *borderCheckArr = [NSMutableArray array];
    
    //时段数据赋值
    if (![checkInRoleDic[@"timeRangeList"] count]) {

    }
    for (NSDictionary *periodTimeDic in checkInRoleDic[@"timeRangeList"] ) {
        
        [periodarr addObject:periodTimeDic[@"workRange"]];
        [cannoCheckArr addObject:periodTimeDic[@"rangeCannotCheckin"]];
        [borderCheckArr addObject:periodTimeDic[@"borderCheckInRange"]];
    }
    
    [periodDic setObject:periodarr forKey:@"periodArr"];
    [periodDic setObject:cannoCheckArr forKey:@"cannoCheckArr"];
    [periodDic setObject:borderCheckArr forKey:@"borderCheckArr"];
    
    return periodDic;
}

@end
