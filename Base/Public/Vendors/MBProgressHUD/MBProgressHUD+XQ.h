//
//  MBProgressHUD+XQ.h
//  comen
//
//  Created by lawrence on 16/12/28.
//  Copyright © 2016年 ChenPark. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (XQ)

// 加载圈
+(MBProgressHUD*)show;
+(MBProgressHUD*)showTime:(NSTimeInterval)interval;
+(MBProgressHUD*)showToView:(UIView *)view;   //推荐
+(MBProgressHUD*)showToView:(UIView *)view time:(NSTimeInterval)interval;


//透明加载圈
+(MBProgressHUD*)showClearHud;
+(MBProgressHUD*)showClearHudToView:(UIView *)view;
+(MBProgressHUD*)showClearHud:(NSTimeInterval)interval;
+(MBProgressHUD*)showClearHudToView:(UIView *)view time:(NSTimeInterval)interval;
//

//成功图标 自动消失
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

//失败图标 自动消失
+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

//toast信息 自动消失
+ (void)showAlertMessage:(NSString *)alert;

//显示信息  需要手动隐藏
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;  //推荐

//隐藏
+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

/** 设置是否阻碍用户操作 */
-(void)setBlockUserActivity:(BOOL)isBlock;

/** Toast显示 */
+(void)showToast:(NSString*)text;

+(void)showToast:(NSString*)text toView:(UIView *)view;

@end
