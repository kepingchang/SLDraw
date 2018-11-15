//
//  SLEditText.m
//  HeShi
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 sltech. All rights reserved.
//

#import "SLEditText.h"

@implementation SLEditText

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self creatCancleBtn];
        [self creatQDBtn];
        [self creatCancleLabel];
        [self creatTxteView];
    }
    return self;
}

- (void)creatCancleBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5, 5, 60, 30);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(QXbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [self addSubview:btn];
}
- (void)creatCancleLabel
{
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, 1)];
    labe.backgroundColor = [UIColor brownColor];
    [self addSubview:labe];
}
- (void)creatQDBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.frame.size.width-65, 5, 60, 30);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(QDbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:btn];
}
- (void)creatTxteView
{
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 45,self.frame.size.width , self.frame.size.height-120)];
    textView.tag = 600;
    textView.font = [UIFont systemFontOfSize:20];
    textView.backgroundColor = [UIColor cyanColor];
    [self addSubview:textView];
}
- (void)QXbtnClick
{
    [self removeFromSuperview];
}
- (void)QDbtnClick
{
    UITextView *textView = (UITextView *)[self viewWithTag:600];
    [self.delegate ADDTextWithText:textView.text];
    [self removeFromSuperview];
}
@end

