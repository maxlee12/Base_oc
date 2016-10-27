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
//
+(UserDevice*)shareUserDevice;
@property(nonatomic,assign) BOOL  isJailBreak;
@property(nonatomic,strong) NSDictionary * deviceMessage;
@property(nonatomic,strong) NSDictionary * deviceWiFi;
@end
