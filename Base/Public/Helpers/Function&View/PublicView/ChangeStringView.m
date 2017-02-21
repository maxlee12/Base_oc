//
//  ChangeStringView.m
//  Pear
//
//  Created by lawrence on 16/8/18.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "ChangeStringView.h"
@interface ChangeStringView()<UITextFieldDelegate>
{
    __weak IBOutlet UILabel *titleLab;
    __weak IBOutlet UITextField *nameTF;
    __weak IBOutlet UIButton *cancelBtn;
    __weak IBOutlet UIButton *cerTainBtn;
    
    __weak IBOutlet UIView *backView;

}

@end

CGFloat KeyBoard_height = 160;
@implementation ChangeStringView


-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    
    [cancelBtn addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
    
    [cerTainBtn addTarget:self action:@selector(clickCertainBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf)];
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    
    nameTF.delegate = self;
    
    [nameTF becomeFirstResponder];
    
    backView.layer.cornerRadius = 8;
    backView.clipsToBounds = YES;
    
    self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
}

-(void)setOldName:(NSString *)oldName{
    
    _oldName = oldName;
    nameTF.text = _oldName;
    
}

-(void)setTitleStr:(NSString *)titleStr{
    
    _titleStr = titleStr;
    titleLab.text = _titleStr;
}

-(void)removeSelf{
    
    [nameTF resignFirstResponder];
    [self removeFromSuperview];

}

-(void)clickCertainBtn{

    if (nameTF.text.length) {
       
        if (_ReturnNewStrBlock) {
            
            _ReturnNewStrBlock(nameTF.text);
            [self removeSelf];
        }
        
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([[textField.text stringByAppendingString:string] length] >30  ) {
        
        return NO;
    };
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self clickCertainBtn];
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        backView.centerY = self.centerY - KeyBoard_height;
    }];
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //滑动效果
    NSTimeInterval animationDuration = 0.5f;
    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //恢复屏幕
    self.centerX = self.centerX + 100.0f;
    
    [UIView commitAnimations];
}


-(void)becomeResponder{
    //滑动效果（动画）
    NSTimeInterval animationDuration = 0.5f;
    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    self.centerX = self.centerX - 100.0f;
    [UIView commitAnimations];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
