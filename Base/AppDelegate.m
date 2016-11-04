//
//  AppDelegate.m
//  Base
//
//  Created by lawrence on 16/10/27.
//  Copyright © 2016年 李辉. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "NetWorkStates.h"

@interface AppDelegate ()

@property (nonatomic, strong) Reachability *reacha;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //    状态栏改为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    [self checkNetworkStates];
    
    return YES;
}


- (void)checkNetworkStates
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange) name:kReachabilityChangedNotification object:nil];
    _reacha = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    [_reacha startNotifier];
}


- (void)networkChange
{
    NSString *tips;
    NetState currentStates = [NetWorkStates getNetworkStates];
    
    switch (currentStates) {
        case NetworkStatesNone:
            tips = @"当前无网络, 请检查您的网络状态";
            break;
        case NetworkStates2G:
            tips = @"切换到了2G网络";
            break;
        case NetworkStates3G:
            tips = @"切换到了3G网络";
            break;
        case NetworkStates4G:
            tips = @"切换到了4G网络";
            break;
        case NetworkStatesWIFI:
            tips = nil;
            break;
        default:
            break;
    }
    
    if (tips.length) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:tips delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        
    }
}



- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDImageCache sharedImageCache] clearMemory];
}


@end
