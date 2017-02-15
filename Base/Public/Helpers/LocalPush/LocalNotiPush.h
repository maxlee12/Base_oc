//
//  LocalNotiPush.h
//  Pear
//
//  Created by lawrence on 16/7/14.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateTools.h"

typedef NS_OPTIONS(NSInteger, CHECKTYPE)
{
    CHECK_IN,
    CHECK_OUT
};

@interface LocalNotiPush : NSObject

+ (void)cancelLocalNotificationWithKey:(NSString *)key;

+(void)isSendLoaclPushWithRuleDic:(NSDictionary*)ruleDic;
@end
