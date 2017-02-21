//
//  PhoneConfirmController.m
//  Pear
//
//  Created by Lawrence on 16/4/8.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "PhoneConfirmController.h"

#define DARK_GRAY [UIColor colorWithRed:189/255.0 green:191/255.0 blue:191/255.0 alpha:1.0]//灰色
#define COLOR5_BtnGroundTitle [UIColor colorWithRed:53/255.0 green:71/255.0 blue:75/255.0 alpha:1.0]

static int messageTimeLong = 60;
@interface PhoneConfirmController ()<UITextFieldDelegate>
{
    NSTimer *timer;
    NSDate *timeStartDate;
    
    IBOutlet UIView *backNaviBar;
    
    IBOutlet UILabel *phoneNumErrView;
    IBOutlet UILabel *phoneCodeErrView;
}
//输入手机号view
@property (weak, nonatomic) IBOutlet UIView *phoneNumView;      //输入手机号View
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;   //手机号

//验证码view
@property (weak, nonatomic) IBOutlet UIView *phoneCodeView;     //验证码view
@property (weak, nonatomic) IBOutlet UITextField *codeTF;       //验证码

@property (weak, nonatomic) IBOutlet UIButton *messageBtn;      //发送验证码按钮

@property (weak, nonatomic) IBOutlet UIButton *completeBigBtn;  //完成键

@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@end

@implementation PhoneConfirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setXibView];       //设置界面Xib

//    成为第一响应
    [self.phoneNumTF becomeFirstResponder];

    //
    [self hideErrView];
}

#pragma mark--设置xib的view
-(void)setXibView{
    //设置光标颜色
    self.phoneNumTF.tintColor = [UIColor colorWithRed:53/255.0 green:71/255.0 blue:75/255.0 alpha:1.0];
    self.codeTF.tintColor = [UIColor colorWithRed:53/255.0 green:71/255.0 blue:75/255.0 alpha:1.0];
    
    //
    self.messageBtn.titleLabel.numberOfLines = 2;
    self.messageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rersignKeyBoard)];
    [self.view addGestureRecognizer:tap];

}


#pragma mark --发送验证码
-(IBAction)sendMessage:(id)sender{
    //号码正确
    if ([self judgePhoneNum:self.phoneNumTF.text]) {
        
        //光标移到验证码
        [self.codeTF becomeFirstResponder];
        
        //添加倒计时
        [self addTimer];
        
        
        //获得验证码
        
#pragma mark  --发起获得验证码请求
        
        
    }
    else {
        DebugLog(@"电话号码格式buzhengque");
    }
}

//到计时
-(void)addTimer{
    
    //发送验证码时清除验证码
    self.codeTF.text = @"";

    timeStartDate = [NSDate date];

    //倒计时
    [timer invalidate];
    timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(UpdateLabTime) userInfo:nil repeats:YES];
    [timer fire];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)UpdateLabTime{
    
    NSTimeInterval timeDiff = [[[NSDate alloc] init] timeIntervalSinceDate:timeStartDate];
    
   int messageTime = messageTimeLong - (int)timeDiff;
    
    [self.messageBtn setTitleColor:DARK_GRAY forState:UIControlStateNormal];
    self.messageBtn.userInteractionEnabled = NO;
    if (messageTime>=0) {

        NSString *titleStr = [NSString stringWithFormat:@"%d秒",messageTime];
        self.messageBtn.titleLabel.text = titleStr;
        [self.messageBtn setTitle:titleStr forState:UIControlStateNormal];
    }
    else
    {
        [timer invalidate];
        timer = nil;
        self.messageBtn.userInteractionEnabled = YES;
        [self.messageBtn setTitleColor:COLOR5_BtnGroundTitle forState:UIControlStateNormal];

        self.messageBtn.titleLabel.text = @"重新获取";
        [self.messageBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    }
  
}

//发送失败后恢复可以重新发送验证码状态
-(void)resetSendMessage{
    
    [timer invalidate];
    timer = nil;
    self.codeTF.text = @"";
    self.messageBtn.userInteractionEnabled = YES;
    [self.messageBtn setTitleColor:COLOR5_BtnGroundTitle forState:UIControlStateNormal];
    self.messageBtn.titleLabel.text =@"";
    [self.messageBtn setTitle:@"重新获取" forState:UIControlStateNormal];
}

#pragma mark --判断手机号正确性
-(BOOL)judgePhoneNum :(NSString *)strNum{
    
    if ([[strNum stringByReplacingOccurrencesOfString:@" " withString:@""]length]<11) {

        [MBProgressHUD showError:@"格式不正确"];
        return NO;
    }
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    //不带空格的电话号码
//    ^((13[0-9])|(147)|(170)|(15[^4,\\D])|(18[0-9]))\\d{8}$

    NSString *mobileRegex =@"^[1][0-9]{10}$";
    
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileRegex];
    
    
    BOOL isPhoneNum = [mobileTest evaluateWithObject:[strNum stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    if (isPhoneNum == NO) {
        [MBProgressHUD showError:@"格式不正确"];
        return NO;
    }
    else{
        
        return YES;
    }
    return NO ;
}

#pragma mark--返回
-(void)clickLeftBtn{
    //释放键盘
    [self rersignKeyBoard];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --验证(完成)
-(IBAction)confirmePhoneCode:(id)sender{
    

    //释放键盘
    [self rersignKeyBoard];
    //判断手机号
    if ([self judgePhoneNum:self.phoneNumTF.text]) {
        NSString *verfiryMessage = [NSString stringWithFormat:@"%@",self.codeTF.text];
        if (verfiryMessage.length<4) {
            
            //显示验证码有误
            [MBProgressHUD showError:@"验证码错误"];
        }
        
        else{
        #pragma mark --登录请求
            
        }
    }
    else {
        DebugLog(@"电话号码格式buzhengque");
    }

    if ((UIButton*)sender == self.completeBigBtn) {
        //谷歌analytics
    }
  
}

- (IBAction)wechatLogin:(id)sender {
    

    
}


#pragma mark -- TextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == self.phoneNumTF) {
        
    }
    if (textField == self.codeTF) {
       
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if(textField == self.codeTF){
        [self judgePhoneCodeLength:self.codeTF.text];
    }
    if(textField == self.phoneNumTF){
        [self judgePhoneNum:self.phoneNumTF.text];
    }
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{

    if(textField == self.codeTF){
        [self judgePhoneCodeLength:self.codeTF.text];
    }
    if(textField == self.phoneNumTF){
    }

}

//
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    //输入电话号码
    if (textField == self.phoneNumTF) {
        
        // 删除字符
        if ([string isEqualToString:@""]) {
            return YES;
        }
        //控制数量
        if (range.location ==10) {
            self.phoneNumTF.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
            
            
            //号码正确
            if ([self judgePhoneNum:self.phoneNumTF.text]) {
                //移除code——err和phone_err view
                [self hideErrView];
                
            }
            return NO;
        }
        if (range.location >10) {
            
            //号码正确
            if ([self judgePhoneNum:self.phoneNumTF.text]) {
                //移除code——err和phone_err view
                [self hideErrView];
            }
            return NO;
        }
        
        //判断是否1开头
        [self judgePhoneNumStartWith:[NSString stringWithFormat:@"%@%@",textField.text,string]];
   
    }
    
    //验证码
    if (textField == self.codeTF) {
        
        // 删除字符
        if ([string isEqualToString:@""]) {
            
            return YES;
        }
        else if (range.location == 3){
            self.codeTF.text = [NSString stringWithFormat:@"%@%@",self.codeTF.text,string];
           
            return NO;
        }
        else if (range.location >3) {
            
            return NO;
        }
        
    }
    
    return YES;
}

#pragma mark --判断是否 1 开头
-(void)judgePhoneNumStartWith:(NSString*)text{
    
    if ([text hasPrefix:@"1"]) {
        
        [self removePhoneNumErr];
    }
    else{
        //添加手机号格式错误提示
        [self showPhoneNumErr];
    }
    
    //删除验证码错误提示
    [self removePhoneCodeErr];
}

#pragma mark --判断code长度
-(void)judgePhoneCodeLength:(NSString*)text{
    if (text.length==4||text.length==0) {
        [self removePhoneCodeErr];
    }
    else{
        [self showPhoneCodeErr];
        [MBProgressHUD showError:@"验证码错误"];
    }
}

//点击空白释放键盘
-(void)rersignKeyBoard{
    [self.phoneNumTF resignFirstResponder];
    [self.codeTF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    //释放键盘
    [self rersignKeyBoard];
    [timer invalidate];
    timer = nil;
}

#pragma mark --showErr
-(void)showPhoneNumErr{
    phoneNumErrView.alpha = 1;
}

-(void)showPhoneCodeErr{
    phoneCodeErrView.alpha = 1;
}

-(void)removePhoneNumErr{
    phoneNumErrView.alpha = 0;
}

-(void)removePhoneCodeErr{
    phoneCodeErrView.alpha = 0;
}

-(void)hideErrView{
    
    phoneNumErrView.alpha = 0;
    phoneCodeErrView.alpha = 0;
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
