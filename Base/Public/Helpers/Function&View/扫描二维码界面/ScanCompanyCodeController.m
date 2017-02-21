//
//  ScanCompanyCodeController.m
//  Pear
//
//  Created by Lawrence on 15/12/25.
//  Copyright © 2015年 Henry. All rights reserved.
//

#import "ScanCompanyCodeController.h"
#import "AFNetworking.h"
#import <AVFoundation/AVFoundation.h>
#import "ZXingObjC.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
@interface ScanCompanyCodeController ()<AVCaptureMetadataOutputObjectsDelegate,UIWebViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UIView *actionView;
    
    UIImageView     *_scanView;
    UIImageView     *_lineView;
}

@property (nonatomic ,strong) AVCaptureSession *captureSession;                 //捕捉会话
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;    //预览图层layer
@property (strong, nonatomic) UIView *boxView;//扫描识别框

@property (nonatomic, strong) UIImagePickerController *imagePickerController;


@end

@implementation ScanCompanyCodeController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    
    //判断相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限
        NSString *info_msg_camera = @"请打开相机权限";
        NSString *info_msg_prompt = @"提示";
        NSString *info_msg_certain = @"确定";
        
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:info_msg_prompt message:info_msg_camera delegate:nil cancelButtonTitle:nil otherButtonTitles:info_msg_certain, nil];
        [view show];
    }
    
    [self startScan];
    
}

//开始扫描
- (void)startScan
{
    //初始化设备(摄像头)
    NSError *error = nil;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (error)
    {
        DebugLog(@"没有摄像头:%@", error.localizedDescription);
        return;
    }
    
    
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    //实例化捕捉会话并添加输入,输出流
    if (!_captureSession) {
        _captureSession = [[AVCaptureSession alloc] init];
    }
    
    //高质量采集率
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_captureSession addInput:input];
    [_captureSession addOutput:output];
    
    //设置输出的代理,在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];   //用串行队列新线程结果在UI上显示较慢
    
    //扫码类型
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,         //二维码
                                     AVMetadataObjectTypeCode39Code,     //条形码   韵达和申通
                                     AVMetadataObjectTypeCode128Code,    //CODE128条码  顺丰用的
                                     AVMetadataObjectTypeCode39Mod43Code,
                                     AVMetadataObjectTypeEAN13Code,
                                     AVMetadataObjectTypeEAN8Code,
                                     AVMetadataObjectTypeCode93Code,    //条形码,星号来表示起始符及终止符,如邮政EMS单上的条码
                                     AVMetadataObjectTypeUPCECode]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    //添加预览图层
    _videoPreviewLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:_videoPreviewLayer];
    [self.view bringSubviewToFront:self.view.subviews[0]];
    
    
    //扫描范围
    UIImage *scanImage = [UIImage imageNamed:@"scanscanBg"];
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    CGFloat scanW = 300;
    CGRect scanFrame = CGRectMake(width / 2. - scanW / 2. , height / 2. - scanW / 2., scanW, scanW);
    
    //扫描范围方框
    _scanView = [[UIImageView alloc] initWithImage:scanImage];
    _scanView.backgroundColor = [UIColor clearColor];
    _scanView.frame = scanFrame;
    [self.view addSubview:_scanView];
    
    //扫描识别范围
    output.rectOfInterest = CGRectMake(0 / self.view.bounds.size.height,
                                       0  / self.view.bounds.size.width,
                                       SCREEN_W / self.view.bounds.size.width,
                                       SCREEN_H / self.view.bounds.size.height);
    
    //开始扫描
    [_captureSession startRunning];
    [self loopDrawLine];
    [self setOverView];

}

//返回
- (IBAction)cancaelSanf:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //谷歌analytics
}

//闪光
- (IBAction)ChangeTorchMode:(id)sender{
    UIButton *torchBtn = sender;
    BOOL isLightOpened = [self isLightOpened];
    
    if (isLightOpened) {
        [torchBtn setImage:[UIImage imageNamed:@"scan_icon_light_off"] forState:UIControlStateNormal];
    }
    else
    {
        [torchBtn setImage:[UIImage imageNamed:@"scan_icon_light_on"] forState:UIControlStateNormal];
    }
    
    [self openLight:!isLightOpened];

}

- (BOOL)isLightOpened
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo];
    if (![device hasTorch]) {
        return NO;
    }else{
        if ([device torchMode] == AVCaptureTorchModeOn) {
            return YES;
        } else {
            return NO;
        }
    }
}

- (void)openLight:(BOOL)open
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo];//[self.reader.readerView device];
    if (![device hasTorch]) {
    } else {
        if (open) {
            // 开启闪光灯
            if(device.torchMode != AVCaptureTorchModeOn ||
               device.flashMode != AVCaptureFlashModeOn){
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                [device unlockForConfiguration];
            }
        } else {
            // 关闭闪光灯
            if(device.torchMode != AVCaptureTorchModeOff ||
               device.flashMode != AVCaptureFlashModeOff){
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                [device unlockForConfiguration];
            }
        }
    }
}

#pragma mark - 获取相册照片
//PS:info.plist文件已添加 Localizations 项,并选择语言为 Chinese (simplified),使相册的选择,打开,取消等按键为中文.
- (IBAction)showImagePicker{
    [_captureSession stopRunning];
    
    if (!_imagePickerController) {
        
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
    
}

#pragma mark 照片处理
-(void)getInfoWithImage:(UIImage *)img{
    
    UIImage *loadImage= img;
    CGImageRef imageToDecode = loadImage.CGImage;
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    
    if (result)
    {
        DebugLog(@"相册图片QRCodeString == %@",result.text);
        
        [self handleResultOfScaningQRCodeString:result.text];

    }
    else
    {
        //选择图片为非二维码
        NSString *eror_wrong_qrcode = @"扫描不到二维码";
        NSString *info_msg_prompt =@"提示";
        NSString *info_msg_certain = @"确定";
        UIAlertController *alertController= [UIAlertController alertControllerWithTitle:info_msg_prompt message:eror_wrong_qrcode preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:info_msg_certain style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_captureSession startRunning];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
}

#pragma mark - 扫描结果代理方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    [_captureSession stopRunning];
    //    [_videoPreviewLayer removeFromSuperlayer];
    
    if (metadataObjects.count > 0) {
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        DebugLog(@"扫码扫描结果obj.stringValue == %@", obj.stringValue);
        [self handleResultOfScaningQRCodeString:obj.stringValue];
    }

}

//从相机扫描或者从相册选取二维码后的跳转判断
- (void)handleResultOfScaningQRCodeString:(NSString *)QRCodeString
{


}


#pragma - mark - UIImagePickerViewControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self getInfoWithImage:image];
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_captureSession startRunning];
    
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark--UIWebViewDelegate  跳转H5相关

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:( NSError *)error{

}

#pragma mark - 添加模糊效果
- (void)setOverView {
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = CGRectGetMinX(_scanView.frame);
    CGFloat y = CGRectGetMinY(_scanView.frame);
    CGFloat w = CGRectGetWidth(_scanView.frame);
    CGFloat h = CGRectGetHeight(_scanView.frame);
    
    [self creatView:CGRectMake(0, 0, width, y)];
    [self creatView:CGRectMake(0, y, x, h)];
    [self creatView:CGRectMake(0, y + h, width, height - y - h)];
    [self creatView:CGRectMake(x + w, y, width - x - w, h)];
}

- (void)creatView:(CGRect)rect {
    CGFloat alpha = 0.5;
    UIColor *backColor = [UIColor grayColor];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    view.alpha = alpha;
    [self.view insertSubview:view belowSubview:actionView];

}

#pragma mark - 动画
- (void)loopDrawLine {
    
    UIImage *lineImage = [UIImage imageNamed:@"scanLine"];
    
    CGFloat w = CGRectGetWidth(_scanView.frame);
    CGFloat h = CGRectGetHeight(_scanView.frame);
    
    CGRect start = CGRectMake(0, 0, w, 2);
    CGRect end = CGRectMake(0, h - 2, w, 2);
    
    if (!_lineView) {
        _lineView = [[UIImageView alloc] initWithImage:lineImage];
        _lineView.frame = start;
        [_scanView addSubview:_lineView];
    } else {
        _lineView.frame = start;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:2 animations:^{
        _lineView.frame = end;
       
    } completion:^(BOOL finished) {
        [weakSelf loopDrawLine];
        
    }];
}

#pragma mark 获取扫描区域
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x, y, width, height);
}
-(void)showSelfViewToast:(NSString *)text{
    
    [MBProgressHUD showMessage:text];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_captureSession stopRunning];
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
