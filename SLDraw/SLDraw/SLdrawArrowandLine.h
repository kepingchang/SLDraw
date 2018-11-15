//
//  SLdrawArrowandLine.h
//  HeShi
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 sltech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLdrawArrowandLine : UIView
@property(nonatomic,strong) NSMutableArray * completeLines;
@property(nonatomic,strong) NSMutableDictionary* LinesInProscess;
@property(nonatomic,strong) UIColor *lineColor;//线条颜色
@property (nonatomic)float lineWidth;//线条的粗细
@property(nonatomic,assign)BOOL isLine;


-(void)clearAll;

-(void)endTouches:(NSSet *) touches;
@end

