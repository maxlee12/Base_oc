//
//  UserManager.h
//  Pear
//
//  Created by Lawrence on 16/1/13.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPRequestManager.h"
#import "User.h"

@interface UserManager : NSObject
@property(nonatomic,strong)NSMutableDictionary *userDic;
@property(nonatomic,strong)User *currentUser;

+(id)sharUserManager;

/** 登出清除数据 */
-(void)removeAllData;

@end
