//
//  SHowBigPicController.m
//  imageViews
//
//  Created by ChenPark on 16/9/13.
//  Copyright © 2016年 ChenPark. All rights reserved.
//

#import "SHowBigPicController.h"
#import "UIView+Frame.h"
#define margin 30
#define btnWH 30
#define imgH 300
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
@interface SHowBigPicController ()

@end

@implementation SHowBigPicController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView *imageView = [[UIImageView alloc]init];

    imageView.image = self.image;
    [imageView sizeToFit];
    imageView.drink_centerX = self.view.drink_centerX;
    imageView.drink_centerY = self.view.drink_centerY;
    
    [self.view addSubview:imageView];
        //添加返回和删除按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(margin, margin, btnWH, btnWH)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"show_image_back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *delBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W - btnWH - margin, margin, btnWH, btnWH)];
    [delBtn setBackgroundImage:[UIImage imageNamed:@"album_order_topbar_rubbish"] forState:UIControlStateNormal];
        //删除该张图片
    [delBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delBtn];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)delete{
    [self.delegate deletePicWithViewController:self delImage:self.image];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
