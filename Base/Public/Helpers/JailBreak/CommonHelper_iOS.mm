//
//  CommonHelper_iOS.mm
//  Pear
//
//  Created by Mr_White on 16/1/6.
//  Copyright © 2016年 Henry. All rights reserved.
//



#import "CommonHelper_iOS.h"
#import <sys/stat.h>
const NSString *applicationsKey = @"applications";

const NSString *pathsKey = @"paths";
const NSString *cydiaKey = @"cydia";
const NSString *mobileSubstrateKey = @"mobileSubstrate";
const NSString *bashKey = @"bash";
const NSString *sshdKey = @"sshd";
const NSString *aptKey = @"apt";

@implementation CommonHelper_iOS


+ (BOOL)isJailBreak {
    
    //    DebugLog(@"%hhd - %hhd - %hhd - %hhd - %hhd", [JailBreakJudge checkJailBreakToolPaths], [JailBreakJudge checkCydiaURLScheme], [JailBreakJudge checkApplicationsPath], [JailBreakJudge checkCydiaWithStat], [JailBreakJudge checkLibraries]);
    
    BOOL ret = [CommonHelper_iOS checkJailBreakToolPaths] ||
    [CommonHelper_iOS checkCydiaURLScheme] ||
    [CommonHelper_iOS checkApplicationsPath] ||
    [CommonHelper_iOS checkCydiaWithStat] ||
    [CommonHelper_iOS checkLibraries];
    
    return ret;
}




#pragma mark - private judge methods

// 判定常见的越狱文件
+ (BOOL)checkJailBreakToolPaths {
    for (NSString *path in ((NSDictionary *)[CommonHelper_iOS getPaths][pathsKey]).allValues) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            //            DebugLog(@"%@", path);
            return YES;
        }
    }
    
    return NO;
}


// 判断cydia的URL scheme
+ (BOOL)checkCydiaURLScheme {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        return YES;
    }
    
    return NO;
}


// 读取系统所有用户名
+ (BOOL)checkApplicationsPath {
    checkCydia();
    // iOS7
    NSString *userAppPath = [CommonHelper_iOS getPaths][applicationsKey];
    
    //law---------delte
    
    
    
    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:userAppPath]) {
//        //        NSArray *appList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:userAppPath error:nil];
//        //        DebugLog(@"%@", appList);
//        return YES;
//    }
    
    //law -----------add  [[NSFileManager defaultManager] fileExistsAtPath:path]) //如果文件不存在则创建
    
    
    //改为判断路径下是否存在内容
    if([[NSFileManager defaultManager] contentsAtPath:userAppPath])
    {
    return YES;
    }
    
    return NO;
}


// 防止 hook NSFileManager, 使用stat函数
/**
 *  判定cydia.app
 *
 *  @return 1 - 越狱
 0 - 未越狱
 */
int checkCydia()
{
    int ret = 0;
    const char *cydiaPath = [(NSString *)[CommonHelper_iOS getPaths][pathsKey][cydiaKey] UTF8String];
    
    struct stat stat_info;
    if (0 == stat(cydiaPath, &stat_info)) {
        ret = 1;
    }
    
    return ret;
}

+ (BOOL)checkCydiaWithStat {
    if (checkCydia()) {
        return YES;
    }
    
    return NO;
}



// 读取环境变量
char* printEnv()
{
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    //    DebugLog(@"%s", env);
    return env;
}

+ (BOOL)checkLibraries {
    if (printEnv()) {
        return YES;
    }
    return NO;
}


#pragma mark - tool path
+ (NSDictionary *)getPaths {
    NSDictionary *pathsDict = @{applicationsKey: @"/Applications",
                                pathsKey: @{cydiaKey: @"/Applications/Cydia.app",
                                            mobileSubstrateKey: @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                                            bashKey: @"/bin/bash",
                                            sshdKey: @"/usr/sbin/sshd",
                                            aptKey: @"/etc/apt"}};
    return pathsDict;
}



@end
