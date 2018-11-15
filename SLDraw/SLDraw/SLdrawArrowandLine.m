//
//  SLdrawArrowandLine.m
//  HeShi
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 sltech. All rights reserved.
//

#import "SLdrawArrowandLine.h"
#import "SLLine.h"


@implementation SLdrawArrowandLine

//初始化
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _completeLines=[[NSMutableArray alloc] init];
        _LinesInProscess=[[NSMutableDictionary alloc]init];
        self.backgroundColor=[UIColor clearColor];
        self.lineWidth = 6.0;
        [self setMultipleTouchEnabled:YES];
        self.lineColor  = [UIColor purpleColor];
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    //获取上下文
    CGContextRef cgt=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cgt, self.lineWidth);
    CGContextSetLineCap(cgt, kCGLineCapRound);
    
    //黑色画笔（完成）
    [self.lineColor set];
    for (SLLine *line in _completeLines) {
        CGContextMoveToPoint(cgt, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(cgt, [line end].x, [line end].y );
        CGContextStrokePath(cgt);
        //30*fabs(line.begin.y-line.end.y)/r
        double r;//平方根
        if (self.isLine) {
            
        }
        else
        {
            r = sqrt((line.end.x-line.begin.x)*(line.end.x-line.begin.x)+(line.begin.y-line.end.y)*(line.begin.y-line.end.y));
            CGContextMoveToPoint(cgt,line.end.x,line.end.y);
            //P1
            CGContextAddLineToPoint(cgt,line.end.x-(10*(line.begin.y-line.end.y)/r),line.end.y-(10*(line.end.x-line.begin.x)/r));
            //P3
            CGContextAddLineToPoint(cgt,line.end.x+(20*(line.end.x-line.begin.x)/r), line.end.y-(20*(line.begin.y-line.end.y)/r));
            //P2
            CGContextAddLineToPoint(cgt,line.end.x+(10*(line.begin.y-line.end.y)/r),line.end.y+(10*(line.end.x-line.begin.x)/r));
            
            CGContextAddLineToPoint(cgt, line.end.x,line.end.y);
            CGContextDrawPath(cgt,kCGPathFillStroke);
            CGContextStrokePath(cgt);
        }
    }
    
    //红色画笔（未完成）
    [[UIColor redColor] set];
    for (NSArray *v in _LinesInProscess) {
        SLLine *line =[_LinesInProscess objectForKey:v];
        CGContextMoveToPoint(cgt, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(cgt, [line end].x, [line end].y );
        CGContextStrokePath(cgt);
    }
}


//清空画板
-(void)clearAll
{
    [_completeLines removeLastObject];
    [_LinesInProscess removeAllObjects];
    [self setNeedsDisplay];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //判断是否连按
    for (UITouch *t in touches) {
        if ([t tapCount]>1) {
            [self clearAll];
            return;
        }
        
        //NSValue 作为键使用
        NSValue *key=[NSValue valueWithNonretainedObject:t];
        
        // 根据触摸位置创建Line对象
        CGPoint loc=[t locationInView:self];
        SLLine *newLine=[[SLLine alloc]init ];
        newLine.begin=loc;
        newLine.end=loc;
        [_LinesInProscess setObject:newLine forKey:key];
        
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * t in touches) {
        NSValue *key=[NSValue valueWithNonretainedObject:t];
        // 找对象当前UITouch对象的Line对象
        SLLine *line =[_LinesInProscess objectForKey:key];
        
        CGPoint loc=[t locationInView:self];
        line.end=loc;
    }
    [self setNeedsDisplay];
}

-(void)endTouches:(NSSet *) touches
{
    for (UITouch *t in touches) {
        NSValue *key=[NSValue valueWithNonretainedObject:t];
        SLLine *line =[_LinesInProscess objectForKey:key];
        if (line) {
            [_completeLines addObject:line];
            [_LinesInProscess removeObjectForKey:key];
        }
    }
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}


@end

