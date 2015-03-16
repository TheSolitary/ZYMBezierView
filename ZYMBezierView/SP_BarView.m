//
//  SP_BarView.m
//  lqsh_37body
//
//  Created by zym on 14/12/25.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import "SP_BarView.h"
#import "UIColor+Utils.h"

@implementation SP_BarView



-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorForHex:@"069cda"];
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (_type == SP_BarViewTypeDefault) {
//        //左线
//        CGContextSetRGBStrokeColor(context, 5 / 255.0f, 149 / 255.0f, 209 / 255.0f, 1.0f);
//        CGContextMoveToPoint(context, 0, rect.size.height);
//        CGContextAddLineToPoint(context, 0, 0);
//        CGContextStrokePath(context);
    }
    
    if (_type == SP_BarViewTypeNonNormal) {
        
        CGFloat lengths[] = {5,5};
        //虚线
        CGContextSetRGBStrokeColor(context, 1655 / 255.0f, 211 / 255.0f, 240 / 255.0f, 1.0f);
        CGContextSetLineDash(context, 0, lengths, 1);  //画虚线
        CGContextMoveToPoint(context, 0, rect.size.height);
        CGContextAddLineToPoint(context, 0, 0);
        CGContextStrokePath(context);
        CGContextSetLineDash(context, 0, lengths, 0);//关闭画虚线
    }
    

    //右线
    CGContextSetRGBStrokeColor(context, 5 / 255.0f, 149 / 255.0f, 209 / 255.0f, 1.0f);
    CGContextMoveToPoint(context, rect.size.width, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, 0);
    CGContextStrokePath(context);
    
    [super drawRect:rect];
}

@end
