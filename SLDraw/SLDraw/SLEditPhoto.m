//
//  SLEditPhoto.m
//  HeShi
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 sltech. All rights reserved.
//





#import "SLEditPhoto.h"

@implementation SLEditPhoto 

- (instancetype)initWithFrame:(CGRect)frame andWithImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self creatImageViewWith:image andFrame:frame];
    }
    return self;
}
-(void)creatImageViewWith:(UIImage *)image andFrame:(CGRect)frame
{
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:frame];
   // imgV.center = self.center;
    imgV.tag = 701;
    imgV.image = image;
    [self addSubview:imgV];
    self.image = imgV.image;
}
@end

