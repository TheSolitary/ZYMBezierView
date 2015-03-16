//
//  SP_DialogView.m
//  lqsh_37body
//
//  Created by zym on 14/12/25.
//  Copyright (c) 2014年 zym. All rights reserved.
//

#import "SP_DialogView.h"
#import "UIView+Utils.h"
#import "UIColor+Utils.h"

@interface SP_DialogView ()

@property (nonatomic, strong) UILabel *dialogLabel;

@end

@implementation SP_DialogView


-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.frame = CGRectMake(0, 0, 47, 25);
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *dialogBG = [[UIImageView alloc] init];
        dialogBG.frame = self.bounds;
        dialogBG.image = [UIImage imageNamed:@"SP_chartBG"];
        [self addSubview:dialogBG];
        
        self.dialogLabel = [[UILabel alloc] init];
        _dialogLabel.frame = CGRectMake(0, 0, self.width, 20);
        _dialogLabel.font = [UIFont systemFontOfSize:10];
        _dialogLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dialogLabel];
        
    }
    
    return self;
}

-(void)setDialogText:(NSString *)dialogText
{
    _dialogText = dialogText;
    self.dialogLabel.text = _dialogText;
}

@end
