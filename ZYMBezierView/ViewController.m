//
//  ViewController.m
//  ZYMBezierView
//
//  Created by zym on 15/3/16.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()



@end

@implementation ViewController


- (IBAction)pressed1:(id)sender {
    [self performSegueWithIdentifier:@"view1" sender:nil];
}
- (IBAction)pressed2:(id)sender {
    [self performSegueWithIdentifier:@"view2" sender:nil];
}



@end
