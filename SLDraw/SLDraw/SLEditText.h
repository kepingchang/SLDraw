//
//  SLEditText.h
//  HeShi
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 sltech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLEditTextDelegate <NSObject>

-(void)ADDTextWithText:(NSString *)TEXT;



@end


@interface SLEditText : UIView

@property(nonatomic,strong)id<SLEditTextDelegate>delegate;

@end

