//
//  HTTPRequestManager.h
//  Pear
//
//  Created by Henry on 15/11/30.
//  Copyright © 2015年 Henry. All rights reserved.
//


//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间,写字间里程序员；
//                  程序人员写程序,又拿程序换酒钱
//                  酒醒只在网上坐,酒醉还来网下眠；
//                  酒醉酒醒日复日,网上网下年复年
//                  但愿老死电脑间,不愿鞠躬老板前；
//                  奔驰宝马贵者趣,公交自行程序员
//                  别人笑我忒疯癫,我笑自己命太贱；
//                  不见满街漂亮妹,哪个归得程序员?
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| ^_^ |)
//                           O\  =  /O
//                        ____/`---'\____
//                      .'  \\|     |//  `.
//                     /  \\|||  :  |||//  \
//                    /  _||||| -:- |||||-  \
//                    |   | \\\  -  /// |   |
//                    | \_|  ''\---/''  |   |
//                    \  .-\__  `-`  ___/-. /
//                  ___`. .'  /--.--\  `. . ___
//                ."" '<  `.___\_<|>_/___.'  >'"".
//              | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//              \  \ `-.   \_ __\ /__ _/   .-` /  /
//        ========`-.____`-.___\_____/___.-`____.-'========
//                             `=---='
//        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//              佛祖保佑       永无BUG        永不修改



#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^ResultBlock)(BOOL success,id responseObj,NSError * error);

@interface HTTPRequestManager : NSObject
{
    AFHTTPSessionManager * manager;
    NSURLSessionDataTask * POSTTask;
}


+ (HTTPRequestManager *)defaultManager;

/*
 * 判断store的version是否升级(参数需要修改)
*/
-(void)judgeVersionUpdata;

@end
