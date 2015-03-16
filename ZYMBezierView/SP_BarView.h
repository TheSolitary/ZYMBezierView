//
//  SP_BarView.h
//  lqsh_37body
//
//  Created by zym on 14/12/25.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SP_BarViewTypeDefault,
    SP_BarViewTypeNonNormal,
} SP_BarViewType;

@interface SP_BarView : UIView

@property (nonatomic ) SP_BarViewType type;

@end
