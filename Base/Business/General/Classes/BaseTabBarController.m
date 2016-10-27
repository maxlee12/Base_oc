//
//  BaseTabBarController.m
//  GLink
//
//  Created by lawrence on 16/9/23.
//  Copyright © 2016年 lawrence. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavtionController.h"
#import "MainViewController.h"
@interface BaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self setupBasic];
}

- (void)setupBasic
{
    //首页
    [self addChildViewController:[[MainViewController alloc] init] notmalimageNamed:@"toolbar_home" selectedImage:@"toolbar_home_sel" title:@"首页"];
    //直播
    [self addChildViewController:[[MainViewController alloc] init] notmalimageNamed:@"toolbar_live" selectedImage:nil title:@"直播"];
    //个人中心
    [self addChildViewController:[[MainViewController alloc] init] notmalimageNamed:@"toolbar_me" selectedImage:@"toolbar_me_sel" title:@"个人中心"];
}

- (void)addChildViewController:(UIViewController *)childController notmalimageNamed:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title
{
    BaseNavtionController *nav = [[BaseNavtionController alloc] initWithRootViewController:childController];
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childController.title = title;
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :BasicColor} forState:UIControlStateNormal];
    
    [self addChildViewController:nav];
}

#warning mark -law-shouldLookLook
#pragma mark 代理方法
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController.tabBarItem.image isEqual:[UIImage imageNamed:@"toolbar_live"]]){
        
        //特殊处理不显示Bar的cintroller
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
