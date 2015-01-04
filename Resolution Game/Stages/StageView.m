//
//  StageView.m
//  Resolution Game
//
//  Created by Alexander Popov on 1/4/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import "StageView.h"

@implementation StageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithSuperView:(UIView *)superView andDelegate:(id<StageViewDelegate>)delegate
{

    StageView *result = nil;
    
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    if ([objects count] > 0) {
        result = [objects firstObject];
        [superView addSubview:result];
        [result setDelegate:delegate];
    }
    
    return result;
    
}

@end
