//
//  GameManager.m
//  Resolution Game
//
//  Created by Alexander Popov on 1/1/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import "GameManagerView.h"

@interface GameManagerView () {
    IBOutlet UIImageView *_arrowView;
}

- (void)recursivelyAnimateFromNumber:(int)number;
- (void)animateCountIn;

@end

@implementation GameManagerView

- (void)setup
{
    
    NSLog(@"Game setup.");
    [_arrowView setHidden:YES];
    
}

- (void)start
{
    
    NSLog(@"Game start.");
    
    [self animateCountIn];
    
}

- (void)recursivelyAnimateFromNumber:(int)iteration
{
    
    if (iteration > 0) {
        CGSize labelSize = CGSizeMake(100.0f, 100.0f);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(([self frame].size.width - labelSize.width) / 2,
                                                                   ([self frame].size.height - labelSize.height) / 2,
                                                                   labelSize.width,
                                                                   labelSize.height)];
        [label setFont:[UIFont systemFontOfSize:62.0f]];
        [label setTextColor:[UIColor blackColor]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:[NSString stringWithFormat:@"%d", iteration]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label];

        [UIView animateWithDuration:1.0
                         animations:^() {
                             [label setTransform:CGAffineTransformMakeScale(0.1f, 0.1f)];
                         }
                         completion:^(BOOL finished) {
                             [label removeFromSuperview];
                             [self recursivelyAnimateFromNumber:iteration - 1];
                         }];
    } else {
        // count in finished, proceed to game
        [_arrowView setHidden:NO];
        
        // activate game loop
        
    }
    
}

- (void)animateCountIn
{
    
    [self recursivelyAnimateFromNumber:3];
    
}

- (void)didPressButtonWithIndex:(int)index
{
    
    NSLog(@"Did press button %d", index);
    
    // if pressed button corresponds to band color, increase multiplier
    // if not - reduce it to 1
    
}

@end
