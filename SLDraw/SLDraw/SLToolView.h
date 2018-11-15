//
//  SLToolView.h
//  HeShi
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 sltech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SLToolViewDelegate <NSObject>

-(void)addText;

-(void)addLineWith:(BOOL)isLine;



-(void)addPike;

-(void)addImage;

@end
@interface SLToolView : UIView

@property(nonatomic,strong)id<SLToolViewDelegate> delegate;

@end

