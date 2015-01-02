//
//  TimelineView.h
//  Resolution Game
//
//  Created by Alexander Popov on 1/2/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kTimelineViewLevelEndNotification = @"kTimelineViewLevelEndNotification";

@class TimelineView;

@protocol TimelineViewDelegate <NSObject>

@required
- (void)timeline:(TimelineView *)timeline didProcessButtonWithResult:(NSDictionary *)resultInfo;

@end

//! @brief Timeline visuals
//! @details Handles timeline animation update & checks if button is correct for current segment
@interface TimelineView : UIView

@property (nonatomic, weak) id <TimelineViewDelegate> delegate;

//! @brief Loads initial map segments
- (void)setupForLevel:(NSDictionary *)levelInfo;

//! @brief Frame update function
- (void)update:(NSTimeInterval)dt;

//! @brief Checks if pressed button corresponds to current segment
- (void)didPressButtonWithIndex:(int)index;

@end
