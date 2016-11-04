//
//  ViewController.m
//  Base
//
//  Created by lawrence on 16/10/27.
//  Copyright © 2016年 李辉. All rights reserved.
//

#import "ViewController.h"
#import "BaseTabBarController.h"
#import "KSGuideManager.h"
#define kScreenBounds [UIScreen mainScreen].bounds
@interface ViewController ()<KSGuideDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createGuidView];
}

#pragma mark welcomeView
-(void)createGuidView{
    
    NSMutableArray *paths = [NSMutableArray new];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"3" ofType:@"jpg"]];
    
    [[KSGuideManager shareInstance] setDelegate:self];
    [[KSGuideManager shareInstance] clearMark];
    [[KSGuideManager shareInstance] showGuideViewWithImages:paths];
}

- (UIButton *)KSGuidLastPageButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 200, 44)];
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.layer setCornerRadius:5];
    [button.layer setBorderColor:[UIColor grayColor].CGColor];
    [button.layer setBorderWidth:1.0f];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setCenter:CGPointMake(kScreenBounds.size.width / 2, kScreenBounds.size.height - 100)];
    return button;
}

- (void)KSGuidLastPageButtonDidOnClick {
    
    [MBProgressHUD showMessage:@"登录中..."];
    
    [self jump];
}


/** 登陆成功之后跳转 */
- (void)jump
{
    BaseTabBarController *tab = [[BaseTabBarController alloc] init];
    
    //一秒之后跳转
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"登陆成功"];
        
        [self presentViewController:tab animated:YES completion:^{
            
        }];
    });
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
