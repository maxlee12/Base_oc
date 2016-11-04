//
//  HTTPRequestManager.m
//  Pear
//
//  Created by Henry on 15/11/30.
//  Copyright © 2015年 Henry. All rights reserved.
//

#import "HTTPRequestManager.h"
#import "Reachability.h"

static NSInteger timeOut = 10.0f;
@implementation HTTPRequestManager

+ (HTTPRequestManager *)defaultManager
{
    static HTTPRequestManager * requestManager;
    if(!requestManager)
    {
        requestManager = [[HTTPRequestManager alloc] init];
    }
    return requestManager;
}

/*json转换为字典*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/*字典转换成json*/
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark 设置基本manager
- (void)initNormalManager
{
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = timeOut;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

}


#pragma mark --example
-(void)getDetailVersionWithResultBlock:(ResultBlock)resultBlock{
    
    [self initNormalManager];
    
    NSString *strUrl = @"example_url";
    
    [self managerGetWithUrl:strUrl andResultBlock:^(BOOL success, id responseObj , NSError *error) {
        
        //数据的normal处理
        [self manageNormalReturnDataWithResultBlock:resultBlock and:success Msg:responseObj error:error];
        
    }];
    
}

#pragma mark --GET Post Patch Delete Put
/*
 GET方法
 */
-(void)managerGetWithUrl:(NSString*)strUrl  andResultBlock:(ResultBlock)resultBlock{
    
    //如果飞行模式不发送请求
    if ([self judgeNoNetwork]) {
        resultBlock(NO,nil,nil);
        return;
    }

    [manager GET:strUrl parameters:nil  progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(resultBlock){
            
            NSDictionary *responDic = [NSJSONSerialization  JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            resultBlock(YES,responDic,nil);

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(resultBlock)
        {
            NSLog(@"%@",error);
            resultBlock(NO,nil,error);

        }
    }];
    
}

/*
 POST方法
 */
-(void)managerPostWithUrl:(NSString*)strUrl andParmart:(NSDictionary*)parameters andResultBlock:(ResultBlock)resultBlock{
    
    //如果飞行模式不发送请求
    if ([self judgeNoNetwork]) {
        resultBlock(NO,nil,nil);
        return;
    }
    [self setCancelTimer];

    POSTTask =  [manager POST:strUrl parameters:parameters  progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(resultBlock){
            
            NSDictionary *responDic = [NSJSONSerialization  JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            resultBlock(YES,responDic,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(resultBlock)
        {
            NSLog(@"%@",error);
            
            resultBlock(NO,nil,error);

        }
    }];
    
}

/*
 PATCH方法
 */
-(void)managerPATCHwithUrl:(NSString*)strUrl andParmart:(NSDictionary*)parameters andResultBlock:(ResultBlock)resultBlock{

    [manager PATCH:strUrl parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(resultBlock)
        {
            NSDictionary *responDic = [NSJSONSerialization  JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            resultBlock(YES,responDic,nil);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(resultBlock)
        {
            resultBlock(NO,nil,error);
        }
    }];
}

/*
 DELETE方法
 */
-(void)managerDELETEwithUrl:(NSString*)strUrl andParmart:(NSDictionary*)parameters andResultBlock:(ResultBlock)resultBlock{
    
    //如果飞行模式不发送请求
    if ([self judgeNoNetwork]) {
        
        resultBlock(NO,nil,nil);
        return;
    }

    [manager DELETE:strUrl parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(resultBlock){
            NSDictionary *responDic = [NSJSONSerialization  JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            resultBlock(YES,responDic,nil);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(resultBlock)
        {
            NSLog(@"%@",error);
            resultBlock(NO,nil,error);

        }
        
    }];
}

/*
 PUT方法
 */
-(void)managerPUTwithUrl:(NSString*)strUrl andParmart:(NSDictionary*)parameters andResultBlock:(ResultBlock)resultBlock{
    
    //如果飞行模式不发送请求
    if ([self judgeNoNetwork]) {
        
        resultBlock(NO,nil,nil);
        return;
    }

    [manager PUT:strUrl parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(resultBlock)
        {
            NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            resultBlock(YES,jsonDict,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(resultBlock)
        {
            NSLog(@"%@",error);
            
            resultBlock(NO,nil,error);
        }
    }];
    
}

#pragma mark--判断网络状态
/*
 判断网络状态是否为飞行模式
*/
- (BOOL)judgeNoNetwork
{
    Reachability * wifi = [Reachability reachabilityForLocalWiFi];
    Reachability * reachable = [Reachability reachabilityForInternetConnection];
    if([wifi currentReachabilityStatus] == NotReachable && [reachable currentReachabilityStatus] == NotReachable)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


#pragma mark --判断版本号 提醒升级

-(void)judgeVersionUpdata{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //商店版本号(需要自己去查看)
        NSString* STOREAPPID = @"111111";
        //从网络获取appStore版本号
        NSError *error;
        //先获取当前工程项目版本号
        NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
        
        NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
        
        
        
        if (response) {
            
            NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
            
            NSArray *array = appInfoDic[@"results"];
            NSDictionary *dic = array[0];
            NSString *appStoreVersion = dic[@"version"];
            //打印版本号
            NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion ,appStoreVersion );
            
            
            //主线程展示
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSComparisonResult result = [currentVersion compare:appStoreVersion options:NSNumericSearch];
                //当前版本号小于商店版本号,就更新
                if(result == NSOrderedAscending)
                {
                    //获得当前window
                    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
                    if (window.windowLevel != UIWindowLevelNormal)
                    {
                        NSArray *windows = [[UIApplication sharedApplication] windows];
                        for(UIWindow * tmpWin in windows)
                        {
                            if (tmpWin.windowLevel == UIWindowLevelNormal)
                            {
                                window = tmpWin;
                                break;
                            }
                        }
                    }
                    //获得当前window上的第一个控制器
                    UIViewController *currentController ;
                    UIResponder *nextResponser = window.subviews[0].nextResponder;
                    if ([nextResponser isKindOfClass:UIViewController.class]) {
                        currentController = (UIViewController*)nextResponser;
                    }
                    else
                    {
                        currentController = window.rootViewController;
                    }
                    
                    NSString *info_msg_goup = @"去升级";
                    
                    NSString *info_msg_cancel = @"取消";
                    
                    
                    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",appStoreVersion] preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertControl addAction:[UIAlertAction actionWithTitle:info_msg_cancel style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
                        
                    }]];
                    
                    [alertControl addAction:[UIAlertAction actionWithTitle:info_msg_goup style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/gb/app/yi-dong-cai-bian/id1097506217?mt=8"] options:@{} completionHandler:nil];
                        

                    }]];
                    
                    [currentController presentViewController:alertControl animated:YES completion:nil];
                    
                }
                
                
            });
        }
        
    });
    
}

#pragma mark post 超时设置
- (void)setCancelTimer
{
    [NSTimer scheduledTimerWithTimeInterval:timeOut target:self selector:@selector(cancelPOST) userInfo:nil repeats:NO];
}

- (void)cancelPOST
{
    [POSTTask cancel];
}




#pragma mark --基本的后台返回数据处理
-(void)manageNormalReturnDataWithResultBlock:(ResultBlock)resultBlock and:(BOOL)success Msg:(id)responseObj error:(NSError*)error{
    
    if (success) {
        if ([responseObj[@"status"] isEqualToString:@"0"]) {
            
            resultBlock(YES,responseObj,nil);
        }
        else{
            resultBlock(NO,responseObj[@"errMsg"],nil);
        }
    }
    else
    {
        [self getErrResuleBlock:resultBlock andMsg:responseObj[@"errMsg"] error:error];
    }
    
}

/*
 处理错误的 resultBlock  处理显示特定的错误码
 */
-(void)getErrResuleBlock:(ResultBlock)resultBlock andMsg:(NSString*)erMsg error:(NSError*)error{
    
    if (erMsg.length) {
        resultBlock(NO,erMsg,nil);
    }
    else if (error == nil) {
        NSString *message = @"";
        resultBlock(NO,message,nil);
    }
    
    else if (error.code ==-1001) {
        NSString *message = @"";
        resultBlock(NO,message,nil);
    }
    
    else if (error.code ==-1009) {
        NSString *message = @"";
        resultBlock(NO,message,nil);
    }
    else{
        
        NSString *message = @"";
        resultBlock(NO,message,nil);
    }
    
}



@end

