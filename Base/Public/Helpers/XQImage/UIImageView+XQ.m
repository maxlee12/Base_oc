//
//  UIImageView+XQ.m
//  comen
//
//  Created by lawrence on 16/12/26.
//  Copyright © 2016年 ChenPark. All rights reserved.
//

#import "UIImageView+XQ.h"

@implementation UIImageView (XQ)

-(void)setXQImageWithNetStr:(NSString *)str andPlacehoder:(NSString*)hoderStr{
    
    if([str containsString:@"default"] || !str.length){
        
        self.contentMode = UIViewContentModeCenter;
        if (!str.length) {
            [self setImage:[UIImage imageNamed:hoderStr]];
        }else{
            [self setImage:[UIImage imageNamed:str]];
        }
        
        
    }else{
        //
        self.contentMode = UIViewContentModeScaleToFill;
        NSString *imgStr = [NSString stringWithFormat:@"%@%@",HOST,str];
        NSURL *imageUrl = [NSURL URLWithString:imgStr];
        [self sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:hoderStr]];
    }
}

-(void)setXQImageWithNetStr:(NSString *)str andPlacehoder:(NSString*)hoderStr andSize:(CGSize*)size {
}

@end
