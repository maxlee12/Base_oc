//
//  XQGA.m
//  Pear
//
//  Created by Lawrence on 16/4/26.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "XQGA.h"

@implementation XQGA
// 点击 滑动
+(void)createEventWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber*)value{

    id tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category
                                                          action:action
                                                           label:label
                                                           value:value] build]];
}

//viewController
+(void)createScreenView:(NSString*)controllerName{
    /*
    字段名称	跟踪器字段	类型	是否必需	说明
    Screen Name	kGAIScreenName	NSString	是	应用屏幕的名称
    屏幕浏览数据主要用于以下标准 Google Analytics（分析）报告中：
    
    “屏幕”报告
    互动流
    手动屏幕衡量
    
    要手动发送屏幕浏览数据,请在跟踪器上设置屏幕字段值,然后发送匹配：
    */
    
    id tracker = [[GAI sharedInstance] defaultTracker];

    [tracker set:kGAIScreenName
           value:controllerName];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

@end
