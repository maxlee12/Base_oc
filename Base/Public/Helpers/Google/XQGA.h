//
//  XQGA.h
//  Pear
//
//  Created by Lawrence on 16/4/26.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAI.h"     //谷歌分析
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
@interface XQGA : NSObject
/*
 * event 相关,参数为String category, String action, String label,对应表里面的三个字段
 * category : 按UI、网络请求分,eg:  wel main slide att user rule addressBook logIn(界面)  / 网络 net
 * action : 具体操作,eg:  click  scroll (点击 滑动 )  / 网络 成功success(网络延迟,放value)/失败fail
 * label : 操作的具体view(具体名称 详见wiki表格) / 网络请求的API id(get或者post + url)
 * value ： 成功的时候,网络延迟
 */





/*
 
 调用方法前请加上该备注：
 
 //谷歌analytics
 
 */


// 点击 滑动 --- 方法内执行
+(void)createEventWithCategory:(NSString*)category action:(NSString*)action label:(NSString*)label value:(NSNumber*)value;

//viewController
//controllerName 传输界面的名称 category包含内容----viewDidLoad类执行
+(void)createScreenView:(NSString*)controllerName;


@end
