//
//  ViewController2.m
//  ZYMBezierView
//
//  Created by zym on 15/3/16.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import "ViewController2.h"
#import "SP_LineBarChart.h"
#import "UIColor+Utils.h"

@interface ViewController2 ()
@property (nonatomic, strong) SP_LineBarChart *sp_LineBarView;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorForHex:@"06a0e0"];
    self.sp_LineBarView = [[SP_LineBarChart alloc] initWithFrame:CGRectMake(0, 108, [UIScreen mainScreen].bounds.size.width, 175)];
    [self.view addSubview:_sp_LineBarView];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.sp_LineBarView strokePath];
    
    
}

@end
