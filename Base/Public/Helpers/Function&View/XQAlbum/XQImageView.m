//
//  XQImageView.m
//  imageViews
//
//  Created by ChenPark on 16/9/13.
//  Copyright © 2016年 ChenPark. All rights reserved.
//

#import "XQImageView.h"
#import "UIView+Frame.h"
#import "SuPhotoPicker.h"
#import "SHowBigPicController.h"
#define margin 10
#define col 3
#define btnWH (self.bounds.size.width - (col-1)*margin)/col
@interface XQImageView ()<ShowBigPicDelegate>
//添加所有按钮的view
@property (weak,nonatomic) UIView *picViews;
@property (weak,nonatomic) UIButton *addBtn;
@property (weak,nonatomic) UIButton *selBtn;
@property (strong,nonatomic) NSMutableArray *photos;
@end
@implementation XQImageView
-(NSMutableArray *)photos{
    if(!_photos){
        _photos = [NSMutableArray array];
    }
    return _photos;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self setAddBtn];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame maxCount:(int)maxCount{
    if(self == [super initWithFrame:frame]){
        self.maxCount = maxCount;
        [self setAddBtn];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame images:(NSArray *)imageArray maxCount:(int)maxCount{
    if(self == [super initWithFrame:frame] && imageArray.count > 0){
        [self setAddBtn];
        self.maxCount = maxCount;
        if(imageArray.count == self.maxCount){
            self.addBtn.hidden = YES;
        }else{
            self.addBtn.hidden = NO;
        }
        
        self.photos = (NSMutableArray *)imageArray;
        [self addCommentViewWithImages:imageArray];
    }
    return self;
}

-(void)setAddBtn{
    UIView *picViews = [[UIView alloc]init];
    picViews.frame = self.bounds;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnWH, btnWH)];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_photo_add"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addPic) forControlEvents:UIControlEventTouchUpInside];
    [picViews addSubview:btn];
    self.addBtn = btn;
    self.picViews = picViews;
    [self addSubview:picViews];
}

//仅添加图片数组
-(void)addCommentViewWithImages:(NSArray *)array{
    
    //将图片按钮数组和添加图片的按钮都添加到View上面
    CGFloat x = 0;
    CGFloat y = 0;
    int i=0;
    for(UIImage *img in array){
        UIImageView *imageView = [[UIImageView alloc]init];
        x = i%col*(btnWH + margin);
        y = i/col*(btnWH+margin);
        imageView.frame = CGRectMake(x, y, btnWH, btnWH);
        imageView.tag = i+1;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = img;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick:)];
        [imageView addGestureRecognizer:tap];
        [self.picViews addSubview:imageView];
        i++;
    }
    //重新定义按钮和视图布局
    self.addBtn.frame = CGRectMake(array.count%col*(btnWH + margin), array.count/col*(btnWH+margin), btnWH, btnWH);
        
    [self.delegate returnXQImageViewHeight:self.drink_height];
    [self.delegate returnImages:self.photos];
}

-(void)btnClick:(UIGestureRecognizer *)tap{
    //对图片按钮的点击事件(跳转新的控制器)
    SHowBigPicController *vc = [[SHowBigPicController alloc]init];
    vc.delegate = self;
    vc.image = self.photos[tap.view.tag-1];
    [[self viewController] presentViewController:vc animated:YES completion:nil];
}

-(void)deletePicWithViewController:(UIViewController *)viewController delImage:(UIImage *)delImage{

    //删除掉原来的所有试图
    for(UIView *view in self.picViews.subviews){
        if(view != self.addBtn){
            [view removeFromSuperview];
        }
    }
    [self.photos removeObject:delImage];
    //重新布局新试图
    [self addCommentViewWithImages:self.photos];
    
    [self layout];
   
}

//添加图片按钮的点击事件
-(void)addPic{

    SuPhotoPicker *photoPicker = [[SuPhotoPicker alloc]init];
    //最多限制添加三张照片
    photoPicker.selectedCount = self.maxCount - self.photos.count;
    
    UIViewController *vc = [self viewController];
    
    [photoPicker showInSender:vc handle:^(NSArray *photos) {
        //完成选择后的操作
        if(self.photos.count == 0){
            self.photos = (NSMutableArray *)photos;
        }else{
            //重新计算最新的视图数组
            NSMutableArray * tempArray = [NSMutableArray arrayWithArray:self.photos];
            if((self.photos.count + photos.count)<=self.maxCount){
            for(int i=0;i<photos.count;i++){
                    [tempArray addObject:photos[i]];
                }
            }
            self.photos = tempArray;
        }
     
        if(self.photos.count<=self.maxCount){
            for(UIView *view in self.picViews.subviews){
                if(view != self.addBtn){
                    [view removeFromSuperview];
                }
            }
            
            [self addCommentViewWithImages:self.photos];
            [self layout];
        }else{

            return;
        }
        
    }];

}

-(void)layout{
    [self setNeedsLayout];
    
    if(self.photos.count < self.maxCount){
        self.addBtn.hidden = NO;
    }else{
        self.addBtn.hidden = YES;
    }
    
    if((self.picViews.subviews.count%col == 1 && self.addBtn.hidden == YES) || (self.picViews.subviews.count%col == 0 && self.addBtn.hidden == NO) ){
        self.drink_height = (self.picViews.subviews.count/col )*(btnWH+margin)-margin;
    }else{
        self.drink_height = (self.picViews.subviews.count/col+1)*(btnWH+margin)-margin;
    }
    
    self.picViews.frame = self.bounds;
}

//获取控件的控制器
-(UIViewController *)viewController{
    for (UIView* next = [self superview];
         next;
         next = next.superview){
            UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]){
            return(UIViewController*)nextResponder;
        }
    }
    
    return nil;
}
@end
