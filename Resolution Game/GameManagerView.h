//
//  GameManager.h
//  Resolution Game
//
//  Created by Alexander Popov on 1/1/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//! @brief Main game logic class
//! @details Handles level visualization & input handling
@interface GameManagerView : UIView

//! @brief Clears game view & loads level
- (void)setup;

//! @brief Begins a game session
- (void)start;

//! @brief Processes input
- (void)didPressButtonWithIndex:(int)index;

@end