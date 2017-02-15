//
//  MBProgressHUD+XQ.m
//  comen
//
//  Created by lawrence on 16/12/28.
//  Copyright © 2016年 ChenPark. All rights reserved.
//

#import "MBProgressHUD+XQ.h"

@implementation MBProgressHUD (XQ)

+(MBProgressHUD*)show{
    
    UIView* view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    return hud;
}

+(MBProgressHUD*)showTime:(NSTimeInterval)interval{

    MBProgressHUD *hud = [self show];
    [hud hideAnimated:YES afterDelay:interval];
    return hud;
}

+(MBProgressHUD*)showToView:(UIView *)view{

    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    return hud;
}

+(MBProgressHUD*)showToView:(UIView *)view time:(NSTimeInterval)interval{
    
    MBProgressHUD *hud = [self showToView:view];
    [hud hideAnimated:YES afterDelay:interval];
    return hud;
}

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.5];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

+ (void)showAlertMessage:(NSString *)alert
{
    [self show:alert icon:nil view:nil];
}


/** 是否阻塞用户操作*/
-(void)setBlockUserActivity:(BOOL)isBlock{
    
    self.userInteractionEnabled = isBlock;
}

+(void)showToast:(NSString*)text{
    
    [self showToast:text toView:nil];
}


+(void)showToast:(NSString*)text toView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    //label设置
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.text = text;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.numberOfLines = 0;//根据最大行数需求来设置
    textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    CGSize maximumLabelSize = CGSizeMake(screen_w*0.7,480);//labelsize的最大值
    //关键语句
    CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label,如果用xib加了约束的话可以只改一个约束的值
    textLabel.frame = CGRectMake(0, 0, expectSize.width, expectSize.height);
    
    //label背景view设置
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, expectSize.width+8*2, expectSize.height+4*2)];
    backView.layer.cornerRadius = backView.frame.size.height/2;
    backView.clipsToBounds = YES;
    backView.backgroundColor = [UIColor lightGrayColor];
    textLabel.center = backView.center;
    [backView addSubview:textLabel];
    
    backView.center = view.center;
    
    [UIView animateWithDuration:2.5 delay:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [view addSubview:backView];
        backView.alpha = 0;
    } completion:^(BOOL finished) {
        [backView removeFromSuperview];
        backView.alpha = 1;
    }];
}


@end
