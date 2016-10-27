//
//  KeyChainStore.h
//  TEST
//
//  Created by Mr_White on 16/3/23.
//  Copyright © 2016年 xqopen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end
