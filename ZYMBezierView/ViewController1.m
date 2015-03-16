//
//  ViewController1.m
//  ZYMBezierView
//
//  Created by zym on 15/3/16.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import "ViewController1.h"
#import "FA_CircleView.h"
#import "UIColor+Utils.h"

@interface ViewController1 ()

@property (nonatomic, strong) FA_CircleView *fa_Circle;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorForHex:@"2dc3d5"];
    
    self.fa_Circle = [[FA_CircleView alloc] init];
    self.fa_Circle.frame = CGRectMake(0, 0, 210, 210);
    self.fa_Circle.center = self.view.center;
    [self.view addSubview:_fa_Circle];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fa_Circle setValue_FA:40];
}

@end
