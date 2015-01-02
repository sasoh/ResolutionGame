//
//  GameManager.h
//  Resolution Game
//
//  Created by Alexander Popov on 1/1/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimelineView.h"

//! @brief Main game logic class
//! @details Handles level visualization & input handling
@interface GameManagerView : UIView <TimelineViewDelegate>

//! @brief Current level data
@property (nonatomic, strong) NSDictionary *levelInfo;

//! @brief Currently reached socre
@property (nonatomic, readonly) int currentScore;

//! @brief Clears game view & loads level
- (void)setup;

//! @brief Begins a game session
- (void)start;

//! @brief Stops game
- (void)stop;

//! @brief Processes input
- (void)didPressButtonWithIndex:(int)index;

@end
