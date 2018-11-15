//
//  SLdrawLine.h
//  HeShi
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 sltech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLDrawPaletteLineInfo;

@interface SLdrawLine : UIView
//所有的线条信息，包含了颜色，坐标和粗细信息 @see DrawPaletteLineInfo
@property(nonatomic,strong) NSMutableArray  *allMyDrawPaletteLineInfos;
//@set  从外部传递的 笔刷长度和宽度，在包含画板的VC中 要是颜色、粗细有所改变 都应该将对应的值传进来
@property (nonatomic,strong)UIColor *currentPaintBrushColor;

@property (nonatomic)float currentPaintBrushWidth;

//外部调用的清空画板和撤销上一步
- (void)cleanAllDrawBySelf;//清空画板
- (void)cleanFinallyDraw;//撤销上一条线条
@end

@interface SLDrawPaletteLineInfo : NSObject//一条线条所对应的线条的信息
//线条所包含的所有点
@property (nonatomic,strong)NSMutableArray <__kindof NSValue *>*linePoints;
@property (nonatomic,strong)UIColor *lineColor;//线条的颜色
@property (nonatomic)float lineWidth;//线条的粗细

@end
