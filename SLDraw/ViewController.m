//
//  ViewController.m
//  SLDraw
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 sltech. All rights reserved.
//

#import "ViewController.h"
#import "SLEditInspirationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 50);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor cyanColor];
    btn.center = self.view.center;
    [self.view addSubview:btn];
}
- (void)btnClick
{
    SLEditInspirationController *eVC = [[SLEditInspirationController alloc]init];
    [self.navigationController pushViewController:eVC animated:YES  ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

