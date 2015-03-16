//
//  FA_CircleView.m
//  lqsh_37body
//
//  Created by zym on 14/12/23.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import "FA_CircleView.h"
#import "UIColor+Utils.h"

#define SCALENUM 200
#define SCALERADIUS 88
#define SCALELONG 18

@interface FA_CircleView ()

@property (nonatomic )NSInteger once;

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation FA_CircleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        
    }
    return self;
}


- (void)setValue_FA:(NSInteger)value
{
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    
    CGFloat angelDic = 360.0f / SCALENUM;
    CGFloat currentAngle;
    
    NSMutableArray *line_layers = [NSMutableArray array];
    
    //画出表盘的刻度
    for (int i = 0; i < value * 2; i ++) {
        
        currentAngle = - i * angelDic + 180;
        
        CGFloat center_x = self.frame.size.width / 2.0f;
        CGFloat center_y = self.frame.size.height / 2.0f;
        
        CGPoint startPoint = CGPointMake(center_x + [self parseToX:SCALERADIUS - SCALELONG angle:currentAngle], center_y + [self parseToY:SCALERADIUS - SCALELONG angle:currentAngle]);
        CGPoint endPoint = CGPointMake(center_x + [self parseToX:SCALERADIUS angle:currentAngle], center_y + [self parseToY:SCALERADIUS angle:currentAngle]);
        
        UIBezierPath *line_Path = [UIBezierPath bezierPath];
        [line_Path moveToPoint:startPoint];
        [line_Path addLineToPoint:endPoint];
        
        CAShapeLayer *line_layer = [CAShapeLayer layer];
        line_layer.fillColor = [UIColor clearColor].CGColor;
        line_layer.strokeColor = [UIColor whiteColor].CGColor;
        line_layer.path = line_Path.CGPath;
        line_layer.lineWidth = 1;
        [self.layer addSublayer:line_layer];
        
    }
    
    __block int index = 0;
    
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(_timer, ^{
        
        NSLog(@"%d",index);
        if (index < [line_layers count]) {
            
        }else
        {
            //关闭计时器
            dispatch_suspend(_timer);
        }
        
        index ++;
         
    });
    dispatch_resume(_timer);
    
}


-(void)drawRect:(CGRect)rect
{
    [[UIColor colorForHex:@"7fdbe5"] setStroke];
    
    //画出外接圆
    UIBezierPath *out_Path = [UIBezierPath bezierPath];
    
    [out_Path addArcWithCenter:CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height/2.0f)
                        radius:self.frame.size.width / 2.0f - 1
                    startAngle:0
                      endAngle:2*M_PI
                     clockwise:YES];
    out_Path.lineWidth = 1.0f;
    [out_Path stroke];
    
    
    
    
    //画出内接圆
    UIBezierPath *in_Path = [UIBezierPath bezierPath];
    [in_Path addArcWithCenter:CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height/2.0f)
                       radius:60
                   startAngle:0
                     endAngle:2*M_PI
                    clockwise:YES];
    in_Path.lineWidth = 1.0f;
    
    [in_Path stroke];
    
    CGFloat angelDic = 360.0f / SCALENUM;
    CGFloat currentAngle;
    //画出表盘的刻度
    for (int i = 0; i < SCALENUM; i ++) {
        
        currentAngle = i * angelDic + 180;
        
        CGFloat center_x = self.frame.size.width / 2.0f;
        CGFloat center_y = self.frame.size.height / 2.0f;
        
        CGPoint startPoint = CGPointMake(center_x + [self parseToX:SCALERADIUS - SCALELONG angle:currentAngle], center_y + [self parseToY:SCALERADIUS - SCALELONG angle:currentAngle]);
        CGPoint endPoint = CGPointMake(center_x + [self parseToX:SCALERADIUS angle:currentAngle], center_y + [self parseToY:SCALERADIUS angle:currentAngle]);
        
        UIBezierPath *line_Path = [UIBezierPath bezierPath];
        [line_Path moveToPoint:startPoint];
        [line_Path addLineToPoint:endPoint];
        [line_Path stroke];
        
    }
    
    [super drawRect:rect];
}

-(CGFloat)parseToX:(CGFloat)radius angle:(CGFloat)angle
{
    return radius*sin(angle*M_PI/180);
}

-(CGFloat)parseToY:(CGFloat)radius angle:(CGFloat)angle
{
    return radius*cos(angle*M_PI/180);
}


@end
