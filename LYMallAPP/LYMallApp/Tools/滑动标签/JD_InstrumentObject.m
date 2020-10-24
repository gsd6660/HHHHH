//
//  JD_InstrumentObject.m
//  HaoJuDian
//
//  Created by zzjd on 2017/9/28.
//  Copyright © 2017年 zzjd. All rights reserved.
//

#import "JD_InstrumentObject.h"
#import <UIKit/UIKit.h>
@interface JD_InstrumentObject ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong)UIView * chooseImageView;

@property (nonatomic,assign)NSInteger editType;//1 编辑 2 左右转换 3 大小

@property (nonatomic,assign)BOOL isAutoWidth;

@end

@implementation JD_InstrumentObject

+(JD_InstrumentObject *)shareJD_Instrument{
    static JD_InstrumentObject * JD_Instrument;
    @synchronized (self) {
        if (!JD_Instrument) {
            JD_Instrument = [[self alloc] init];
        }
    }
    return JD_Instrument;
    
    
}


+(UIView *)createViewWithFrame:(CGRect)Vframe
                     VbcgColor:(UIColor *)VbcgColor
                 VcornerRodius:(CGFloat)VcornerRodiu
                          Vtag:(NSInteger)Vtag
                        Valpha:(CGFloat)Valpha
                   VcolorAlpha:(CGFloat)VcolorAlpha{
    
    UIView * view = [[UIView alloc]initWithFrame:Vframe];
    
    if (VcornerRodiu>0) {
        view.layer.cornerRadius = VcornerRodiu;
        view.clipsToBounds = YES;
    }
    if (Vtag>0) {
        view.tag = Vtag;
    }
    if (Valpha != 1) {
        view.alpha = Valpha;
    }
    
    if (VcolorAlpha != 1) {
        view.backgroundColor = [VbcgColor colorWithAlphaComponent:VcolorAlpha];
        
    }else{
        view.backgroundColor = VbcgColor;
    }
    
    return view;
    
}

+(UILabel *)createLabelWithFrame:(CGRect)Vframe
                       VbcgColor:(UIColor *)VbcgColor
                   VcornerRodius:(CGFloat)VcornerRodiu
                            Vtag:(NSInteger)Vtag
                          Valpha:(CGFloat)Valpha
                     VcolorAlpha:(CGFloat)VcolorAlpha
                      VtextColor:(UIColor *)VtextColor
                       VtextFont:(CGFloat)Vfont
                    VtextAliment:(NSTextAlignment)VtextAliment{
    
    UILabel * label = [[UILabel alloc]initWithFrame:Vframe];
    
    if (VcornerRodiu>0) {
        label.layer.cornerRadius = VcornerRodiu;
        label.clipsToBounds = YES;
    }
    if (Vtag>0) {
        label.tag = Vtag;
    }
    if (Valpha != 1) {
        label.alpha = Valpha;
    }
    
    if (VcolorAlpha != 1) {
        label.backgroundColor = [VbcgColor colorWithAlphaComponent:VcolorAlpha];
        
    }else if(VbcgColor){
        label.backgroundColor = VbcgColor;
    }
    
    if (VtextColor) {
        label.textColor = VtextColor;
    }
    
    if (Vfont>0) {
        label.font = [UIFont systemFontOfSize:Vfont];
    }
    
    label.textAlignment = VtextAliment;
    
    
    
    
    return label;
    
}
#pragma mark  富文本数字变色

+(void)setRichNumberWithLabel:(UILabel*)label Color:(UIColor *) color FontSize:(CGFloat)size{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];
    NSString *temp = nil;
    for(int i =0; i < [attributedString length]; i++){
        
        temp = [label.text substringWithRange:NSMakeRange(i, 1)];
        if([temp mj_isPureInt]||[temp isEqualToString:@"."]){
            if (size == 0) {
                [attributedString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 color, NSForegroundColorAttributeName, nil]
                                          range:NSMakeRange(i, 1)];
            }else{
                [attributedString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 color, NSForegroundColorAttributeName,
                                                 [UIFont systemFontOfSize:size],NSFontAttributeName, nil]
                                          range:NSMakeRange(i, 1)];
            }
        }
    }
    
    label.attributedText = attributedString;
}
#pragma mark  富文本部分变色
+(void)attRangeArray:(NSArray *)rangeArr label:(UILabel *)label headindent:(CGFloat)indent{
    
    NSMutableAttributedString *attributdeString = [[NSMutableAttributedString alloc]initWithString:label.text];
    
    if (indent>0) {
        NSMutableParagraphStyle *paraStyle02 = [[NSMutableParagraphStyle alloc] init];
        paraStyle02.headIndent = indent;
        
        [attributdeString setAttributes:@{NSParagraphStyleAttributeName:paraStyle02} range:NSMakeRange(0, [label.text length])];
    }
    
    
    for (int i = 0; i<rangeArr.count; i++) {
        
        NSDictionary * rangeDict = rangeArr[i];
        
        NSRange range = NSMakeRange([rangeDict[@"x"] intValue], [rangeDict[@"l"] intValue]);
        
        [attributdeString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:rangeDict[@"color"], NSForegroundColorAttributeName,[UIFont systemFontOfSize:[rangeDict[@"size"] doubleValue]],NSFontAttributeName, nil] range:range];
        
    }
    
    label.attributedText = attributdeString;
    
}

#pragma mark  划线

+(UIView *)createDividerViewisTrue:(BOOL)isTrue frame:(CGRect)frame{
    
    UIView * DividerViewlabel = [[UIView alloc]initWithFrame:frame];
    
    if (!isTrue) {
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setBounds:DividerViewlabel.bounds];
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(DividerViewlabel.frame) / 2, CGRectGetHeight(DividerViewlabel.frame))];
        [shapeLayer setFillColor:[UIColor clearColor].CGColor];//  设置虚线颜色为blackColor
        [shapeLayer setStrokeColor:RGBA(243, 243, 243, 1).CGColor];//  设置虚线宽度
        [shapeLayer setLineWidth:CGRectGetHeight(DividerViewlabel.frame)];
        [shapeLayer setLineJoin:kCALineJoinRound];//  设置线宽，线间距
        [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:1], nil]];//  设置路径
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 0);
        CGPathAddLineToPoint(path, NULL, CGRectGetWidth(DividerViewlabel.frame), 0);
        [shapeLayer setPath:path];
        CGPathRelease(path);//  把绘制好的虚线添加上来
        [DividerViewlabel.layer addSublayer:shapeLayer];
        
    }else{
        DividerViewlabel.backgroundColor = RGBA(246, 246, 246, 1);
    }
    return DividerViewlabel;
}

#pragma mark  自定义提示框3s
+(void)createAlertLabWithMessage:(NSString *)message{
    
    
    UIWindow *view = [[[UIApplication sharedApplication] delegate] window];
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (id windowView in windows) {
        NSString *viewName = NSStringFromClass([windowView class]);
        if ([@"UIRemoteKeyboardWindow" isEqualToString:viewName]) {
            view = windowView;
            break;
        }
    }
    
    UILabel * lab = (UILabel *)[view viewWithTag:99];
    
    if (lab) {
        [lab removeFromSuperview];
        lab = nil;
    }
    lab = [[UILabel alloc]initWithFrame:CGRectMake(20, ScreenHeight/5*4, ScreenWidth-40, ScreenHeight*30/1280)];
    lab.textColor = [UIColor whiteColor];
    lab.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    lab.layer.cornerRadius = 5;
    lab.clipsToBounds = YES;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 0;
    lab.tag = 99;
    lab.text = message;
    [lab sizeToFit];
    
    CGRect rect = lab.frame;
    lab.frame = CGRectMake((ScreenWidth-rect.size.width)/2,ScreenHeight/5*4, ((rect.size.width+ScreenWidth*50/720)>ScreenWidth-40)?ScreenWidth-40:(rect.size.width+ScreenWidth*50/720),(rect.size.height<ScreenHeight*30/1280)?ScreenHeight*50/1280:rect.size.height+ScreenHeight*20/1280);
    
    [view addSubview:lab];
    
    [self performSelector:@selector(dimissAlert:) withObject:lab afterDelay:3.0];
    
}
+(void)dimissAlert:(UILabel *)label{
    label.hidden = YES;
}


#pragma mark  无数据加载页面

-(void)showNoDataImageViewWithSuperView:(UIView *)supView alertMsg:(NSString *)str{
    
    UIView * imageBGV = [supView viewWithTag:98];
    
    UILabel *titleLb = [imageBGV viewWithTag:100];
    
    if (!imageBGV) {
        imageBGV = [[UIView alloc]initWithFrame:supView.bounds];
        
        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, supView.frame.size.width, supView.frame.size.height/2-64)];
        
        imageV.image = [UIImage imageNamed:(str.length <= 0)?@"chongxinjiazai":@"wushujuzhanweitu"];
        imageV.contentMode = UIViewContentModeBottom;
        
        titleLb = [[UILabel alloc] initWithFrame:CGRectMake((imageBGV.frame.size.width-imageV.image.size.width)/2, CGRectGetMaxY(imageV.frame)+10, imageV.image.size.width, 20)];
        titleLb.textColor = RGBA(135, 135, 135, 1);
        titleLb.font = [UIFont systemFontOfSize:13];
        titleLb.tag = 100;
        
        
        [imageBGV addSubview:titleLb];
        
        if (str.length) {
            
            titleLb.frame = CGRectMake(10, titleLb.frame.origin.y, ScreenWidth-20, 20);
            titleLb.textAlignment = NSTextAlignmentCenter;
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(ScreenWidth/2-50, CGRectGetMaxY(titleLb.frame)+20, 100, 30);
            button.backgroundColor = RGBA(237, 237, 237, 1);
            [button setTitle:@"新建广告" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button addTarget:self action:@selector(createAdver) forControlEvents:UIControlEventTouchUpInside];
            
            [imageBGV addSubview:button];
        }
        
        
        imageBGV.tag = 98;
        [imageBGV addSubview:imageV];
        
        [supView addSubview:imageBGV];
        
    }
    titleLb.text = (str.length <= 0)?@"暂无数据":[NSString stringWithFormat:@"您暂时还没有%@的广告呦！",str];
    imageBGV.hidden = NO;
    
}
-(void)createAdver{
    
    self.createAdvertising();
    
}

+(void)hideNoDataImageViewWithSuperView:(UIView *)supView{
    
    UIView * imageBGV = [supView viewWithTag:98];
    
    imageBGV.hidden = YES;
    
}

#pragma mark    选择图片

-(void)JD_chooseImageFromLibraryWithRootViewControl:(UIViewController *)superVC sourceType:(UIImagePickerControllerSourceType)sourceType isEdit:(NSInteger)isEdit{
    
    _editType = isEdit;
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    
    [superVC presentViewController:imagePickerController animated:YES completion:nil];
    
}

#pragma mark 相机，相册

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if(_editType == 1){
        self.backImage(image);
    }else{
        [self createChooseImageViewWithImage:image];
    }
    [picker dismissViewControllerAnimated:NO completion:nil];
}

-(void)createChooseImageViewWithImage:(UIImage *)image{
    if (!_chooseImageView) {
        _chooseImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _chooseImageView.backgroundColor = [UIColor blackColor];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight-20-49)];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = image;
        imageView.tag = 100;
        
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, ScreenHeight-49, ScreenWidth/4, 49);
        [btn setImage:[UIImage imageNamed:(_editType == 2)?@"Advertising_close_bw":@"close"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(quxiaoxuanze:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(ScreenWidth/4*3, ScreenHeight-49, ScreenWidth/4, 49);
        [btn2 setImage:[UIImage imageNamed:(_editType == 2)?@"advertising_choose_bw":@"xuanzehong"] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(xuanze:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_editType == 2) {
            
            UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            leftBtn.frame = CGRectMake(ScreenWidth/4, ScreenHeight-49, ScreenWidth/4, 49);
            [leftBtn setImage:[UIImage imageNamed:@"Adver_leftRotate"] forState:UIControlStateNormal];
            [leftBtn setTitleColor:RGBA(135, 135, 135, 1) forState:UIControlStateNormal];
            leftBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            [leftBtn setTitle:@"向左" forState:UIControlStateNormal];
            [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(-leftBtn.titleLabel.intrinsicContentSize.height, 0, 0, -leftBtn.titleLabel.intrinsicContentSize.width)];
            [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -leftBtn.imageView.frame.size.width ,-leftBtn.imageView.frame.size.height, 0)];
            [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBtn.frame = CGRectMake(ScreenWidth/2, ScreenHeight-49, ScreenWidth/4, 49);
            [rightBtn setImage:[UIImage imageNamed:@"Adver_rightRotate"] forState:UIControlStateNormal];
            [rightBtn setTitleColor:RGBA(135, 135, 135, 1) forState:UIControlStateNormal];
            rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            [rightBtn setTitle:@"向右" forState:UIControlStateNormal];
            [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(-rightBtn.titleLabel.intrinsicContentSize.height, 0, 0, -rightBtn.titleLabel.intrinsicContentSize.width)];
            [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -rightBtn.imageView.frame.size.width ,-rightBtn.imageView.frame.size.height, 0)];
            [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            [_chooseImageView addSubview:leftBtn];
            [_chooseImageView addSubview:rightBtn];
            
        }else{
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
            view.backgroundColor = [UIColor whiteColor];
            [_chooseImageView addSubview:view];
            
        }
        
        
        [_chooseImageView addSubview:imageView];
        [_chooseImageView addSubview:btn];
        [_chooseImageView addSubview:btn2];
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:_chooseImageView];
        
        
    }else{
        _chooseImageView.hidden = NO;
        
        UIImageView * imageView = (UIImageView *)[_chooseImageView viewWithTag:100];
        imageView.image = image;
        
    }
    
}
#pragma mark ---------------返回--------------------
-(void)quxiaoxuanze:(UIButton *)btn{
    btn.superview.hidden = YES;
}

#pragma mark ---------------向右旋转90--------------------
-(void)rightBtnClick:(UIButton *)btn{
    
    UIImageView * imgView = (UIImageView *)[_chooseImageView viewWithTag:100];
    UIImage * image = [self image:imgView.image rotation:UIImageOrientationRight];
    imgView.image = image;
    
}
#pragma mark ---------------向左旋转90--------------------

-(void)leftBtnClick:(UIButton *)btn{
    UIImageView * imgView = (UIImageView *)[_chooseImageView viewWithTag:100];
    UIImage * image = [self image:imgView.image rotation:UIImageOrientationLeft];
    
    imgView.image = image;
    
}

#pragma mark ---------------确定--------------------
-(void)xuanze:(UIButton *)btn{
    
    UIImageView * imgView = (UIImageView *)[_chooseImageView viewWithTag:100];
    UIImage * image = imgView.image;
    self.backImage(image);
    
    btn.superview.hidden = YES;
    
}

- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRelease(context);
    
    return newPic;
}




#pragma mark  创建segmentControl
-(UISegmentedControl *)JD_createSegmentWithFrame:(CGRect)frame items:(NSArray *)items selColor:(UIColor *)selColor norColor:(UIColor *)norColor xColor:(UIColor *)xColor lineIsHave:(BOOL)lineIsHave isAutoWidth:(BOOL)isAutoWidth{
    
    UISegmentedControl *segView = [[UISegmentedControl alloc]initWithItems:items];
    segView.frame = frame;
    [segView addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    segView.selectedSegmentIndex = 0;
    [segView setTintColor:[UIColor clearColor]];
    [segView setTitleTextAttributes:@{NSForegroundColorAttributeName:norColor,NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    [segView setTitleTextAttributes:@{NSForegroundColorAttributeName:selColor,NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateSelected];
    
    
    if (lineIsHave) {
        UIView * xView = [segView viewWithTag:100];
        
        if (!xView) {
            
            _isAutoWidth = isAutoWidth;
            
            if (_isAutoWidth) {
                CGSize size = [[NSString stringWithFormat:@"%@",items[0]] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                
                xView = [JD_InstrumentObject createViewWithFrame:CGRectMake((segView.frame.size.width/[items count]-size.width)/2, segView.frame.size.height-ScreenHeight*2/640, size.width,ScreenHeight*2/640) VbcgColor:xColor VcornerRodius:0 Vtag:100 Valpha:1 VcolorAlpha:1];
                
            }else{
                xView = [JD_InstrumentObject createViewWithFrame:CGRectMake(0, segView.frame.size.height-ScreenHeight*2/640, segView.frame.size.width/[items count],ScreenHeight*2/640) VbcgColor:xColor VcornerRodius:0 Vtag:100 Valpha:1 VcolorAlpha:1];
                
            }
            
            
            [segView addSubview:xView];
        }
        
    }
    
    
    return segView;
}



-(void)segClick:(UISegmentedControl *)seg{
    
    UIView * view = [seg viewWithTag:100];
    
    if (view) {
        [UIView animateWithDuration:0.2 animations:^{
            if (_isAutoWidth) {
                CGSize size = [[seg titleForSegmentAtIndex:seg.selectedSegmentIndex] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                
                view.frame = CGRectMake(seg.frame.size.width/seg.numberOfSegments*seg.selectedSegmentIndex + (seg.frame.size.width/seg.numberOfSegments-size.width)/2, seg.frame.size.height-ScreenHeight*2/640, size.width,ScreenHeight*2/640);
                
            }else{
                view.frame = CGRectMake(seg.frame.size.width/seg.numberOfSegments*seg.selectedSegmentIndex, seg.frame.size.height-ScreenHeight*2/640, seg.frame.size.width/seg.numberOfSegments,ScreenHeight*2/640);
                
            }
            
        }];
    }
    
    self.backSelIndex(seg.selectedSegmentIndex);
}



@end
