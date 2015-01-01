//
//  GameManager.m
//  Resolution Game
//
//  Created by Alexander Popov on 1/1/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import "GameManager.h"

@implementation GameManager

- (void)setup
{
    
    NSLog(@"Game setup.");
    if (_view != nil) {
        // load map
        
        // prepare to start
        
    } else {
        NSLog(@"Game manager's view must be set before setup.");
    }
    
}

- (void)start
{
    
    NSLog(@"Game start.");
    // animate count in
    
    // after count in start moving level band
    
}

- (void)didPressButtonWithIndex:(int)index
{
    
    NSLog(@"Did press button %d", index);
    
    // if pressed button corresponds to band color, increase multiplier
    // if not - reduce it to 1
    
}

@end
