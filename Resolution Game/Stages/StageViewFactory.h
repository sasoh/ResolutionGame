//
//  StageViewFactory.h
//  Resolution Game
//
//  Created by Alexander Popov on 1/4/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StageView.h"

@interface StageViewFactory : NSObject

+ (StageView *)stageViewWithType:(StageViewType)type andSuperView:(UIView *)superView andDelegate:(id<StageViewDelegate>)delegate;

@end
