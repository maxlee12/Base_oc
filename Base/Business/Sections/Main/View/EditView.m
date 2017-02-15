//
//  EditView.m
//  Base
//
//  Created by lawrence on 17/2/6.
//  Copyright © 2017年 李辉. All rights reserved.
//

#import "EditView.h"

@interface EditView()
@property (nonatomic ,weak) IBOutlet UIButton *scanfBtn;
@end

@implementation EditView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(IBAction)clickChangStr:(id)sender{
    
    if (_selectedBlock) {
        
        _selectedBlock(ChangStr);
    }
    
}

-(IBAction)clickScanf:(id)sender{
    
    if (_selectedBlock) {
        
        _selectedBlock(Sanf);
    }
}

-(IBAction)clickOther:(id)sender{
    
    if (_selectedBlock) {
        
        _selectedBlock(Other);
    }
    
}


@end
