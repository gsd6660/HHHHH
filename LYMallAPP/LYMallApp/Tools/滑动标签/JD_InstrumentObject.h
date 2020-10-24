//
//  JD_InstrumentObject.h
//  HaoJuDian
//
//  Created by zzjd on 2017/9/28.
//  Copyright © 2017年 zzjd. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JD_InstrumentObject : NSObject

+(JD_InstrumentObject *)shareJD_Instrument;

/*
 
 UIView
 
 frame                          位置
 bcgcolor                       背景色         默认nil
 cornerRodius                   圆角           默认为0
 tag                            tag值          默认为0
 alpha                          透明度          默认1
 colorAlpha                     背景色透明度     默认1
 
 */
+(UIView *)createViewWithFrame:(CGRect)Vframe
                     VbcgColor:(UIColor *)VbcgColor
                 VcornerRodius:(CGFloat)VcornerRodiu
                          Vtag:(NSInteger)Vtag
                        Valpha:(CGFloat)Valpha
                   VcolorAlpha:(CGFloat)VcolorAlpha;


/*
 
 UIlabel
 
 frame                          位置
 bcgcolor                       背景色         默认nil
 cornerRodius                   圆角           默认为0
 tag                            tag值          默认为0
 alpha                          透明度          默认1
 colorAlpha                     背景色透明度     默认1
 VtextColor                     字体颜色        默认nil
 Vfont                          字体大小        默认0
 VtextAliment                   对齐方式        默认0
 */
+(UILabel *)createLabelWithFrame:(CGRect)Vframe
                       VbcgColor:(UIColor *)VbcgColor
                   VcornerRodius:(CGFloat)VcornerRodiu
                            Vtag:(NSInteger)Vtag
                          Valpha:(CGFloat)Valpha
                     VcolorAlpha:(CGFloat)VcolorAlpha
                      VtextColor:(UIColor *)VtextColor
                       VtextFont:(CGFloat)Vfont
                    VtextAliment:(NSTextAlignment)VtextAliment;

/*
 
 富文本数字变色
 
 label      控件
 color      设置数字文字颜色
 size       设置文字大小不设置传0
 */
+(void)setRichNumberWithLabel:(UILabel*)label Color:(UIColor *) color FontSize:(CGFloat)size;

/*
 
 富文本部分变色
 
 rangeArr          修改范围 存dict 参数 x（location） l(length) color(颜色) size（大小）
 label             设置数字文字颜色
 headindent        行距不设置传0
 */
+(void)attRangeArray:(NSArray *)rangeArr label:(UILabel *)label headindent:(CGFloat)indent;

/*
 
 划线
 
 isTrue             0虚线 1 实线
 frame              线的frame
 */
+(UIView *)createDividerViewisTrue:(BOOL)isTrue frame:(CGRect)frame;


/*
 
 仿android 提示框（3秒）
 message            显示信息
 */
+(void)createAlertLabWithMessage:(NSString *)message;


/*
 
 请求加载没有数据
 supView : 用来加载无数据视图
 */
@property (nonatomic,copy)void (^createAdvertising)();

-(void)showNoDataImageViewWithSuperView:(UIView *)supView alertMsg:(NSString *)str;
+(void)hideNoDataImageViewWithSuperView:(UIView *)supView;


/*
 
 选择图片
 
 superVC    选择图片的父视图（用于跳转到系统相册（相机页面））
 
 sourceType 来源：（相机或者相册）
 
 isEdit 编辑页面类型
 */
@property (nonatomic,copy)void (^backImage)(UIImage *image);

-(void)JD_chooseImageFromLibraryWithRootViewControl:(UIViewController *)superVC sourceType:(UIImagePickerControllerSourceType)sourceType isEdit:(NSInteger)isEdit;



/*
 创建segmentControl
 
 frame : 位置
 items : 内容
 
 selColor:选中状态下字体颜色
 norColor:为选中状态字体颜色
 
 lineIsHave: 是否有下滑线
 xColor:下划线颜色
 isAutoWidth: 下滑线宽是否自适应内容宽度
 */
@property (nonatomic,copy)void (^backSelIndex)(NSInteger index);//返回点击位置

-(UISegmentedControl *)JD_createSegmentWithFrame:(CGRect)frame items:(NSArray *)items selColor:(UIColor *)selColor norColor:(UIColor *)norColor xColor:(UIColor *)xColor lineIsHave:(BOOL)lineIsHave isAutoWidth:(BOOL)isAutoWidth;


@end


