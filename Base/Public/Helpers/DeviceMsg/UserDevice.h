//
//  UserDevice.h
//  Pear
//
//  Created by Lawrence on 16/3/19.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyChainStore.h"

@interface UserDevice : NSObject
/*
 获得设备的基本信息 （越狱、网络、type、型号）
*/
+(UserDevice*)shareUserDevice;

/**
 是否越狱
 */
@property(nonatomic,assign) BOOL  isJailBreak;

/**
 当前设备的所有信息 网络 model
 */
@property(nonatomic,strong) NSDictionary * deviceMessage;

/**
 当前连接的wifi信息
 */
@property(nonatomic,strong) NSDictionary * deviceWiFi;
@end
