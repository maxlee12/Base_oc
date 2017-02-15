//
//  MainViewController.m
//  GLink
//
//  Created by lawrence on 16/10/6.
//  Copyright © 2016年 lawrence. All rights reserved.
//

#import "MainViewController.h"

#import "ScanCompanyCodeController.h"

#import "EditView.h"
#import "ChangeStringView.h"
@interface MainViewController ()
@property (nonatomic ,strong) EditView *editView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
}

-(void)initUI{

    [self editView];
}

-(UIView*)editView{

    if (_editView == nil) {
        
        _editView = [[[NSBundle mainBundle] loadNibNamed:@"EditView" owner:nil options:nil] firstObject];
        _editView.center = self.view.center;
        
        typeof(*&self)weakSelf = self;
        _editView.selectedBlock = ^(btnType type){
        
            switch (type) {
                case ChangStr:
                    [weakSelf changStr];
                    break;
                    
                case Sanf:
                    [weakSelf scanCodeController];
                    break;
                    
                case Other:
                    
                    break;
                    
                default:
                    break;
            }
        };
        
        [self.view addSubview:_editView];
    }
    
    return _editView;
}

#pragma mark _EditViewMethod
-(void)changStr{
    
    ChangeStringView *view = [[[NSBundle mainBundle] loadNibNamed:@"ChangeStringView" owner:nil options:nil] firstObject];
    
    view.titleStr = @"改变按钮";
    view.oldName = _editView.changBtn.title;
    view.ReturnNewStrBlock = ^(NSString* str){
    
        [_editView.changBtn setTitle:str];
    };
    
    [self.view addSubview:view];
}

-(void)scanCodeController{
    
    ScanCompanyCodeController *vc = [[ScanCompanyCodeController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
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
