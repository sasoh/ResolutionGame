//
//  StageViewFactory.m
//  Resolution Game
//
//  Created by Alexander Popov on 1/4/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import "StageViewFactory.h"
#import "StageViewPreparation.h"
#import "StageViewSiege.h"
#import "StageViewRepair.h"

@implementation StageViewFactory

+ (StageView *)stageViewWithType:(StageViewType)type andSuperView:(UIView *)superView andDelegate:(id<StageViewDelegate>)delegate
{
    
    StageView *result = nil;
    
    NSDictionary *classes = @{
                              @(StageViewTypePreparation): [StageViewPreparation class],
                              @(StageViewTypeSiege): [StageViewSiege class],
                              @(StageViewTypeRepair): [StageViewRepair class]
                              };
    
    Class targetClass = classes[@(type)];
    
    result = [[targetClass alloc] initWithSuperView:superView andDelegate:delegate];
    
    return result;
    
}

@end
