//
//  StageView.h
//  Resolution Game
//
//  Created by Alexander Popov on 1/4/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, StageViewType) {
    StageViewTypeNone,
    StageViewTypePreparation,
    StageViewTypeSiege,
    StageViewTypeRepair
};

@class StageView;

@protocol StageViewDelegate <NSObject>

@required
- (void)stageView:(StageView *)view didPressButtonWithIndex:(int)index;

@end

@interface StageView : UIView

@property (nonatomic, weak) id <StageViewDelegate> delegate;

@property (nonatomic, assign) StageViewType type;

- (instancetype)initWithSuperView:(UIView *)superView andDelegate:(id<StageViewDelegate>)delegate;

@end
