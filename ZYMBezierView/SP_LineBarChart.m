//
//  SP_LineBarChart.m
//  lqsh_37body
//
//  Created by zym on 14/12/25.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import "SP_LineBarChart.h"
#import "SP_BarView.h"
#import "SP_DialogView.h"

#import "UIView+Utils.h"
#import "UIColor+Utils.h"

#define BARVIEWWITH 30
#define PADDING 25
#define SP_ALL 120.0f

@interface SP_LineBarChart ()

@property (nonatomic, strong) NSMutableArray *barViews;

@end

@implementation SP_LineBarChart


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.barViews = [NSMutableArray arrayWithCapacity:5];
        self.backgroundColor = [UIColor clearColor];
        //基本设置
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    //计算barView的间距
    float verPadding = (self.frame.size.width - (PADDING * 2) - (BARVIEWWITH * 5)) / 4.0f;
    
    for (int i = 0; i < 5; i ++) {
        
        SP_BarView *sp_BarView = [[SP_BarView alloc] init];
        sp_BarView.frame = CGRectMake(PADDING + (verPadding + BARVIEWWITH) * i, 0, BARVIEWWITH, self.height - 35);
        [self addSubview:sp_BarView];
        [_barViews addObject:sp_BarView];
        
        //横向时间轴
        UILabel *axisLabel = [[UILabel alloc] init];
        axisLabel.font = [UIFont systemFontOfSize:10];
        axisLabel.textColor = [UIColor whiteColor];
        axisLabel.tag = i;
        [self addSubview:axisLabel];
#warning 模拟数据
        axisLabel.text = @"2分钟";
        [axisLabel sizeToFit];
#warning 模拟数据
        axisLabel.x = sp_BarView.x - axisLabel.width / 2;
        axisLabel.y = sp_BarView.bottom + 8;
        
        //设置虚线
        if (i == 0 || i == 3) {
            sp_BarView.type = SP_BarViewTypeNonNormal;
            axisLabel.text = @"09:23";
            
            [axisLabel sizeToFit];
#warning 模拟数据
            axisLabel.x = sp_BarView.x - axisLabel.width / 2;
            axisLabel.y = sp_BarView.bottom + 8;
            
            //添加开始运动和结束运动的文字
            UILabel *flagLabel = [[UILabel alloc] init];
            flagLabel.frame = CGRectMake(axisLabel.x , axisLabel.bottom + 4, 40, 11);
            flagLabel.font = [UIFont systemFontOfSize:9];
            flagLabel.textColor = [UIColor whiteColor];
            [self addSubview:flagLabel];
            
            if (i == 0) {
                flagLabel.text = @"开始运动";
            }
            if (i == 3) {
                flagLabel.text = @"结束运动";
            }
        }
    }
}

- (void)strokePath
{
    
    CGPoint progress_lastEndPoint;
    
    for(int i = 0; i < 3; i++){
        
        UIView *sp_BarView = nil;
        switch (i) {
            case 0:
            {
                sp_BarView = [_barViews objectAtIndex:1];
            }
                break;
            case 1:
            {
                sp_BarView = [_barViews objectAtIndex:2];
            }
                break;
            case 2:
            {
                sp_BarView = [_barViews objectAtIndex:4];
            }
                break;
                
            default:
                break;
        }
        
#warning 模拟数据
        //画直线
        CGPoint lineStartPoint = CGPointMake(sp_BarView.x, sp_BarView.height);
        CGPoint lineEndPoint = CGPointMake(sp_BarView.x, sp_BarView.height - (25*i + 19) / SP_ALL * sp_BarView.height);
        
        
        UIBezierPath *line = [UIBezierPath bezierPath];
        [line moveToPoint:lineStartPoint];
        [line addLineToPoint:lineEndPoint];
        
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.path = line.CGPath;
        lineLayer.lineWidth = 2;
        lineLayer.frame = self.bounds;
        lineLayer.fillColor = [UIColor clearColor].CGColor;
        lineLayer.strokeColor = [UIColor colorForHex:@"44ecb2"].CGColor;
        [self.layer addSublayer:lineLayer];
        
        //画大圆
        CGPoint point = lineEndPoint;
        
        UIBezierPath *bigPointPath = [UIBezierPath bezierPath];
        [bigPointPath addArcWithCenter:point
                                radius:8.0f
                            startAngle:0
                              endAngle:2*M_PI
                             clockwise:NO];
        
        CAShapeLayer *bigPointLayer = [CAShapeLayer layer];
        bigPointLayer.path = bigPointPath.CGPath;
        bigPointLayer.frame = self.bounds;
        bigPointLayer.fillColor = [[UIColor colorForHex:@"40e7b5"] colorWithAlphaComponent:0.75f].CGColor;
        [self.layer addSublayer:bigPointLayer];
        
        //画小圆
        UIBezierPath *smallPointPath = [UIBezierPath bezierPath];
        [smallPointPath addArcWithCenter:point
                                  radius:4.0f
                              startAngle:0
                                endAngle:2*M_PI
                               clockwise:NO];
        
        CAShapeLayer *smallPointLayer = [CAShapeLayer layer];
        smallPointLayer.path = smallPointPath.CGPath;
        smallPointLayer.frame = self.bounds;
        smallPointLayer.fillColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:smallPointLayer];
        
        //连线
        if (i != 0) {
            
            UIBezierPath *progressLinePath = [UIBezierPath bezierPath];
            [progressLinePath moveToPoint:progress_lastEndPoint];
            [progressLinePath addLineToPoint:lineEndPoint];
            
            CAShapeLayer *progressLineLayer = [CAShapeLayer layer];
            progressLineLayer.lineCap       = kCALineCapButt;
            progressLineLayer.lineJoin      = kCALineJoinMiter;
            progressLineLayer.path = progressLinePath.CGPath;
            progressLineLayer.lineWidth = 2;
            progressLineLayer.frame = self.bounds;
            progressLineLayer.fillColor = [UIColor clearColor].CGColor;
            progressLineLayer.strokeColor = [UIColor colorForHex:@"44ecb2"].CGColor;
            [self.layer insertSublayer:progressLineLayer above:sp_BarView.layer];
            
        }
        
        progress_lastEndPoint = lineEndPoint;

        //放置对话框
        
        SP_DialogView *dialogView = [[SP_DialogView alloc] init];
        [self addSubview:dialogView];
        dialogView.x = lineEndPoint.x - dialogView.width / 2.0f;
        dialogView.y = lineEndPoint.y - dialogView.height - 10;
        
        dialogView.dialogText = @"78次/秒";
        
    }
}


-(void)drawRect:(CGRect)rect
{
    
    [super drawRect:rect];
}


@end
