//
//  EditView.h
//  Base
//
//  Created by lawrence on 17/2/6.
//  Copyright © 2017年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,btnType) {
    
    ChangStr,
    Sanf,
    Other
};

@interface EditView : UIView

@property (nonatomic ,weak) IBOutlet UIButton *changBtn;
@property (nonatomic, copy)void (^selectedBlock)(btnType btnType);

/**
 *  改变背景图片
 *
 *  @param color 字符串时间
 *
 *  @return 返回时间戳
 */
-(UIColor*)changeBackImage:(UIColor*)color;

/** 改变背景色 */
-(void)changeBackCOlor:(UIColor*)color;
@end
