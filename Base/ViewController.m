//
//  ViewController.m
//  Base
//
//  Created by lawrence on 16/10/27.
//  Copyright © 2016年 李辉. All rights reserved.
//

#import "ViewController.h"
#import "BaseTabBarController.h"

@interface ViewController ()
/** 快速登录 */
@property (nonatomic, weak) UIButton *loginBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loginBtn];
}

- (UIButton *)loginBtn
{
    if (_loginBtn == nil){
        
        UIButton *loginBtn = [[UIButton alloc] init];
        
        loginBtn.backgroundColor = [UIColor clearColor];
        loginBtn.titleColor = BasicColor;
        loginBtn.title = @"快速登录";
        loginBtn.layer.borderWidth = 1;
        loginBtn.layer.borderColor = BasicColor.CGColor;
        loginBtn.highlightedTitleColor = [UIColor redColor];
        
        
        [loginBtn addTarget:self action:@selector(loginClick)];
        
        [self.view addSubview:loginBtn];
        
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@40);
            make.right.equalTo(@-40);
            make.centerX.mas_equalTo(SCREEN_W * 0.5);
            make.height.equalTo(@40);
            make.bottom.equalTo(self.view).offset(-60);
        }];
        
        
        
        _loginBtn = loginBtn;
    }
    return _loginBtn;
}



- (void)loginClick
{
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
