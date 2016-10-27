//
//  NetWorkStates.h
//  Base
//
//  Created by lawrence on 16/10/27.
//  Copyright © 2016年 李辉. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, NetState) {
    NetworkStatesNone, // 没有网络
    NetworkStates2G, // 2G
    NetworkStates3G, // 3G
    NetworkStates4G, // 4G
    NetworkStatesWIFI // WIFI
};
@interface NetWorkStates : NSObject
// 判断网络类型
+ (NetState)getNetworkStates;

@end
