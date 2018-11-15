//
//  SLEditInspirationController.m
//  HeShi
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 Oyd. All rights reserved.
//

#import "SLEditInspirationController.h"

#import "UIImage+SLImage.h"
#import "NSAttributedString+SLTextViewText.h"
#import "SLEditPhoto.h"
#import "SLToolView.h"
#import "SLEditText.h"

#import "SLdrawArrowandLine.h"
#import "SLdrawLine.h"


@interface SLEditInspirationController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SLToolViewDelegate,SLEditTextDelegate>
{
    UITextView *_textView;
    UILabel *placeholder;
    NSInteger keyBoardHeight;
    UIView *_toolView;
    NSMutableString *text;
    SLEditPhoto *backView;
    SLToolView *sltoolView;
    UIButton *cancleBtn;
    UIButton *btn;
    float image_h;
    UIButton *recallbtn;
    UIView *_whiteView;
    
}
@end

@implementation SLEditInspirationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatUI
{
    
    //编辑框
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height-nav_Height)];
    
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:22.0f];
    [self.view addSubview:_textView];
    
    
    //提示文字
    placeholder = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, 200, 40)];
    placeholder.enabled = NO;
    placeholder.text = @"有什么想说的";
    placeholder.font = [UIFont systemFontOfSize:22.0f];
    placeholder.textColor = [UIColor lightGrayColor];
    [_textView addSubview:placeholder];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    _toolView  = [[UIView alloc]init];
    //   _toolView.backgroundColor = [UIColor cyanColor];
    _toolView.frame = CGRectMake(0, screen_Height, screen_Width, 50);
    [self.view addSubview:_toolView];
    
    UIButton *losebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    losebtn.frame = CGRectMake(20, 0, 50, 50);
    //[btn setBackgroundColor:[UIColor whiteColor]];
    [losebtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [losebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [losebtn setTitle:@"弹下" forState:UIControlStateNormal];
    [_toolView addSubview:losebtn];
    
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageBtn setTitle:@"图片" forState:UIControlStateNormal];
    imageBtn.frame = CGRectMake(screen_Width-100, 0, 50, 50);
    [imageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [imageBtn addTarget:self action:@selector(imageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:imageBtn];
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraBtn setTitle:@"相机" forState:UIControlStateNormal];
    cameraBtn.frame = CGRectMake(screen_Width-50, 0, 50, 50);
    [cameraBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:cameraBtn];
    
    UIButton *canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [canclebtn setTitle:@"取消" forState:UIControlStateNormal];
    canclebtn.frame = CGRectMake(screen_Width-150, 0, 50, 50);
    [canclebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [canclebtn addTarget:self action:@selector(canclebtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:canclebtn];
    
}
#pragma mark 取消
-(void)canclebtnBtnClick{
    _textView.text = [NSString stringWithFormat:@"%@", [_textView.textStorage getPlainString]];
}
#pragma mark 相册
-(void)imageBtnClick
{
    //相册
    UIImagePickerController *pick = [[UIImagePickerController alloc]init];
    pick.delegate = self;
    [self presentViewController:pick animated:YES completion:nil];
}
#pragma mark 相机
-(void)cameraBtnClick
{
    //相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有相机,请从相册选取" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
   // picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
  
}

#pragma mark -相册代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //适配屏幕宽度
    UIImage *image1 = [image scaleToSize:CGSizeMake(screen_Width, image.size.height*screen_Width/image.size.width)];
    image_h = image1.size.height;
    _whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:_whiteView];
    //可编辑区域
    backView = [[SLEditPhoto alloc]initWithFrame:CGRectMake(0, 0, screen_Width, image1.size.height) andWithImage:image1];
   //backView.backgroundColor = [UIColor blackColor];
    
    backView.center = _whiteView.center;
    backView.userInteractionEnabled = YES;
    backView.center = self.view.center;
    [_whiteView addSubview:backView];
    
    sltoolView  = [[SLToolView alloc]initWithFrame:CGRectMake(20, screen_Height-70, 50, 50) ];
    sltoolView.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:sltoolView];
   //确定按钮
    [self creatBtn];
    //取消按钮
    [self cancleBtn];
    //撤回按钮
    [self creatrecallBtn];
    [self creatColorBtn];
    [self creatLineWith];
}
#pragma mark 颜色按钮
-(void)creatColorBtn
{
    UIButton *colorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colorBtn.frame = CGRectMake(screen_Width - 170, screen_Height-70, 50, 50);
    [colorBtn addTarget:self action:@selector(colorBtnClick) forControlEvents:UIControlEventTouchUpInside];
    colorBtn.backgroundColor = [UIColor redColor];
    colorBtn.layer.cornerRadius = 25;
    colorBtn.layer.masksToBounds = YES;
    //[[UIApplication sharedApplication].keyWindow addSubview:colorBtn];
}
- (void)colorBtnClick
{
    
}
#pragma mark 粗细按钮
- (void)creatLineWith
{
    
}
#pragma mark 撤回按钮
- (void)creatrecallBtn
{
    recallbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recallbtn.frame = CGRectMake(screen_Width - 100, screen_Height-70, 50, 50);
    [recallbtn setTitle:@"撤回" forState:UIControlStateNormal];
    recallbtn.layer.cornerRadius = 25;
    recallbtn.layer.masksToBounds = YES;
    recallbtn.backgroundColor = [UIColor blackColor];
    [recallbtn addTarget:self action:@selector(recallbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow  addSubview:recallbtn];
}
#pragma mark 撤回按钮实现
- (void)recallbtnClick
{
    NSArray *viewArray =  (id)[backView subviews];
    if (viewArray.count>1)
    {
        if ([viewArray.lastObject isKindOfClass:[UILabel class]]||[viewArray.lastObject isKindOfClass:[UIImageView class]]) {
            [viewArray.lastObject removeFromSuperview];
        }
        else if ([viewArray.lastObject isKindOfClass:[SLdrawArrowandLine class]])
        {
            SLdrawArrowandLine *touchDrawView = viewArray.lastObject;
            if (touchDrawView.completeLines.count>1)
            {
                [touchDrawView clearAll];
            }
            else
            {
                [touchDrawView removeFromSuperview];
            }
        }
        else if ([viewArray.lastObject isKindOfClass:[SLdrawLine class]])
        {
            SLdrawLine *drawPaletteView = viewArray.lastObject;
            if (drawPaletteView.allMyDrawPaletteLineInfos.count>1)
            {
                [drawPaletteView cleanFinallyDraw];
            }
            else{
                [drawPaletteView removeFromSuperview];
            }
        }
    }
}
- (void)cancleBtn
{
    cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(20, 20, 50, 50) ;
    cancleBtn.backgroundColor = [UIColor clearColor];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(btn1Click1) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:cancleBtn];
}
#pragma mark 取消按钮
- (void)btn1Click1
{
    [_whiteView removeFromSuperview];
    [recallbtn removeFromSuperview];
    [sltoolView removeFromSuperview];
    [backView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
    [_textView becomeFirstResponder];
    [cancleBtn removeFromSuperview];
    [btn removeFromSuperview];
}
- (void)creatBtn
{
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(screen_Width-70, 20, 50, 50) ;
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick1) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:btn];
}
#pragma mark 确定按钮
- (void)btnClick1
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(screen_Width, backView.frame.size.height), YES, 1.0);
    [backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *uiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_whiteView removeFromSuperview];
    [backView removeFromSuperview];
    [sltoolView removeFromSuperview];
    [recallbtn removeFromSuperview];
    NSTextAttachment *imgTextAtta = [[NSTextAttachment alloc]init];
    //裁剪
    CGImageRef img = CGImageCreateWithImageInRect(uiImage.CGImage, CGRectMake(0, screen_Height/2-image_h/2, screen_Width, image_h));
    UIImage *newImage = [UIImage imageWithCGImage:img];
    imgTextAtta.image = newImage;
    //插入图片
    [_textView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:imgTextAtta]atIndex:_textView.selectedRange.location];
    //设置光标位置
    _textView.selectedRange = NSMakeRange(_textView.selectedRange.location + 1, _textView.selectedRange.length);
    //设置样式
    [self resetTextStyle];
    [self dismissViewControllerAnimated:YES completion:nil];
    //每次添加完图片后  返回编辑状态
    [_textView becomeFirstResponder];
    [cancleBtn removeFromSuperview];
    [btn removeFromSuperview];
}

#pragma mark 增加文字提示框
- (void)addText
{
    SLEditText *editText = [[SLEditText alloc]initWithFrame:CGRectMake(60, nav_Height, screen_Width-120, screen_Width*2/3)];
    editText.tag = 650;
    editText.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:editText];
//    UITapGestureRecognizer *tapLabel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLabel:)];
//    [editText addGestureRecognizer:tapLabel];
    
}
#pragma mark 增加文字代理方法
- (void)ADDTextWithText:(NSString *)TEXT
{
    UILabel *textlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 360)];
    textlabel.tag = 900;
    textlabel.lineBreakMode = 0;
    textlabel.center = CGPointMake(backView.bounds.size.width/2, backView.bounds.size.height/2);
    textlabel.font = [UIFont systemFontOfSize:25];
    textlabel.text = TEXT;
    textlabel.userInteractionEnabled = YES;
    [backView addSubview:textlabel];
    //拖拽
    UIPanGestureRecognizer *panLabel = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(tapLabel:)];
    [textlabel addGestureRecognizer:panLabel];
    //旋转
    UIRotationGestureRecognizer *rota = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [textlabel addGestureRecognizer:rota];
    //缩放
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [textlabel addGestureRecognizer:pinch];
    
  //  [backView becomeFirstResponder];
}
//放大
-(void)pinch:(UIPinchGestureRecognizer *)pin{
   // NSLog(@"pin....");
    pin.view.transform = CGAffineTransformScale(pin.view.transform, pin.scale, pin.scale);
    //重置缩放系数
    pin.scale = 1.0;
}
//旋转
-(void)rotation:(UIRotationGestureRecognizer *)rota{
    //rota.rotation 旋转的角度
    rota.view.transform = CGAffineTransformRotate(rota.view.transform, rota.rotation);
    //重置角度
    rota.rotation = 0;
}
//拖拽
- (void)tapLabel:(UIPanGestureRecognizer *)panLabel
{
    UILabel *textlabel = (UILabel *)[self.view viewWithTag:900];
    CGPoint point =  [panLabel  translationInView:textlabel];
   // NSLog(@"%f %f",point.x ,point.y);
    //改变中心点坐标（原来的中心点+偏移量=当前的中心点）
    panLabel.view.center = CGPointMake(panLabel.view. center.x+point.x, panLabel.view.center.y+point.y);
    //每次调用完之后，需要重置手势的偏移量，否则平移手势会自动累加偏移量
    //CGPointMake(0, 0)<==>CGPointZero
    [panLabel setTranslation:CGPointZero inView:textlabel];
    
}
#pragma mark 随意划线
- (void)addPike
{
    SLdrawLine *d = [[SLdrawLine alloc]initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height)];
    //颜色
    d.currentPaintBrushColor = [UIColor redColor];
    //粗细
    d.currentPaintBrushWidth = 5.0f;
    [backView addSubview:d];
}
#pragma mark 加图片
-(void)addImage
{
    UIImageView *imV = [[UIImageView alloc]initWithFrame:CGRectMake(screen_Width/2-50, screen_Height/2-50, 100, 100)];
    imV.center =  CGPointMake(backView.bounds.size.width/2, backView.bounds.size.height/2);
    imV.image = [UIImage imageNamed:@"100"];
    imV.layer.cornerRadius = 15;
    imV.layer.masksToBounds= YES;
    imV.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panimV = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panimV:)];
    [imV addGestureRecognizer:panimV];
    UIRotationGestureRecognizer *rotaimV = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotaimV:)];
    [imV addGestureRecognizer:rotaimV];
    //缩放
    UIPinchGestureRecognizer *pinchimV = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchimV:)];
    [imV addGestureRecognizer:pinchimV];

    imV.tag = 910;
    
    [backView addSubview:imV];
}
- (void)rotaimV:(UIRotationGestureRecognizer *)rota
{
    rota.view.transform = CGAffineTransformRotate(rota.view.transform, rota.rotation);
    //重置角度
    rota.rotation = 0;
}
- (void)pinchimV:(UIPinchGestureRecognizer *)pin
{
    pin.view.transform = CGAffineTransformScale(pin.view.transform, pin.scale, pin.scale);
    //重置缩放系数
    pin.scale = 1.0;
}
- (void)panimV:(UIPanGestureRecognizer *)pan
{
    
//    UIImageView *imV = (UIImageView *)[backView viewWithTag:910];
    CGPoint point1 =  [pan  translationInView:pan.view];
    pan.view.center = CGPointMake(pan.view.center.x+point1.x, pan.view.center.y+point1.y);
    [pan setTranslation:CGPointZero inView:pan.view];
}
#pragma mark 划直线   箭头
- (void)addLineWith:(BOOL)isLine
{
    SLdrawArrowandLine *touchdrawView = [[SLdrawArrowandLine alloc]initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height)];
    //NSArray *array = touchdrawView.completeLines;
    touchdrawView.isLine = isLine;
//    Line *line = array.lastObject;
    
   // NSLog(@"%f%f%f%f",line.begin.x,line.begin.y,line.end.x,line.end.y) ;
    touchdrawView.lineColor = [UIColor yellowColor];
    touchdrawView.lineWidth = 5.0;
    touchdrawView.tag = 902;
    [backView addSubview:touchdrawView];
}

#pragma mark 工具栏代理
-(void)cancle
{
    [_whiteView removeFromSuperview];
    [recallbtn removeFromSuperview];
    [backView removeFromSuperview];
    [sltoolView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
    [_textView becomeFirstResponder];
}
#pragma mark 改变字体大小
- (void)resetTextStyle {
    //After changing text selection, should reset style.
    NSRange wholeRange = NSMakeRange(0, _textView.textStorage.length);
    [_textView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    [_textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22.0f] range:wholeRange];
}
#pragma mark 相册取消按钮代理方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 弹下
-(void)btnClick
{
    [_textView resignFirstResponder];
}
#pragma mark 当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyBoardHeight = keyboardRect.size.height;
//    NSLog(@"%ld",(long)keyBoardHeight);
    [UIView animateWithDuration:0.1 animations:^{
        _textView.frame = CGRectMake(0, 0, screen_Width, screen_Height-keyBoardHeight-50);
         _toolView.frame = CGRectMake(0, screen_Height-keyBoardHeight-50, screen_Width, 50);
    }];
   
}

#pragma mark 当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.1 animations:^{
    _textView.frame = CGRectMake(0, 0, screen_Width, screen_Height);
    _toolView.frame = CGRectMake(0, screen_Height+50, screen_Width, 50);
    }];
}
#pragma mark 根据文字长度   是否显示提示文字
- (void)textViewDidChange:(UITextView *)textView;
{
    if (_textView.textStorage.length == 0)
    {
        placeholder.hidden = NO;
    }
    else
    {
        placeholder.hidden = YES;
    }
}
@end

