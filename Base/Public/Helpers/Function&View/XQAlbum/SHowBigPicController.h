//
//  SHowBigPicController.h
//  imageViews
//
//  Created by ChenPark on 16/9/13.
//  Copyright © 2016年 ChenPark. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShowBigPicDelegate <NSObject>
-(void)deletePicWithViewController:(UIViewController *)viewController delImage:(UIImage *)delImage;
@end
@interface SHowBigPicController : UIViewController
@property (strong,nonatomic) UIImage *image;
@property (nonatomic, weak) id <ShowBigPicDelegate> delegate;
@end
