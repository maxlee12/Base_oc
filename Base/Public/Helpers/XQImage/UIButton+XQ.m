//
//  UIButton+XQ.m
//  comen
//
//  Created by lawrence on 16/12/26.
//  Copyright © 2016年 ChenPark. All rights reserved.
//

#import "UIButton+XQ.h"

@implementation UIButton (XQ)

-(void)setXQImageWithNetStr:(NSString *)str andPlacehoder:(NSString*)hoderStr{
    
    if([str containsString:@"default"] || !str.length){
        
        self.contentMode = UIViewContentModeCenter;
        if (!str.length) {
            [self setImage:[UIImage imageNamed:hoderStr] forState:UIControlStateNormal];
        }else{
            [self setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
            
        }
    }else{
        //
        self.contentMode = UIViewContentModeScaleToFill;
        NSString *imgStr = [NSString stringWithFormat:@"%@/%@",HOST,str];
        NSURL *imageUrl = [NSURL URLWithString:imgStr];
        [self sd_setImageWithURL:imageUrl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:hoderStr]];
    }
}
@end
