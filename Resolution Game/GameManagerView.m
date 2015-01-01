//
//  GameManager.m
//  Resolution Game
//
//  Created by Alexander Popov on 1/1/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import "GameManagerView.h"
#import "TimelineView.h"

@interface GameManagerView () {
    IBOutlet UIImageView *_arrowView;
    NSDate *_lastFrameDate;
    TimelineView *_timelineView;
}

- (void)recursivelyAnimateFromNumber:(int)number;
- (void)animateCountIn;
- (void)update:(CADisplayLink *)sender;

@end

@implementation GameManagerView

- (void)setup
{
    
    NSLog(@"Game setup.");
    
    // init timeline object & let it prepare first part of map
    _timelineView = [[TimelineView alloc] initWithFrame:CGRectMake(0.0f, [_arrowView frame].origin.y + [_arrowView frame].size.height, [self frame].size.width, 50.0f)];
    [_timelineView setDelegate:(id<TimelineViewDelegate>)self]; // cast to suppress warning
    [_timelineView setup];
    [_timelineView setHidden:YES];
    [self addSubview:_timelineView];
    
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
        [_timelineView setHidden:NO];
        
        // activate game loop
        _lastFrameDate = [NSDate date];
    
        NSTimer *gameTimer = [NSTimer timerWithTimeInterval:1.0f / 60.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:gameTimer forMode:NSDefaultRunLoopMode];
    }
    
}

- (void)update:(NSTimer *)timer
{
    
    NSDate *now = [NSDate date];
    
    NSTimeInterval dt = [now timeIntervalSinceDate:_lastFrameDate];
    _lastFrameDate = [NSDate date];
    
    [_timelineView update:dt];
    
}

- (void)animateCountIn
{
    
    [self recursivelyAnimateFromNumber:1];
    
}

- (void)didPressButtonWithIndex:(int)index
{
    
    [_timelineView didPressButtonWithIndex:index];
    
}

#pragma mark - Timeline view delegate method
- (void)timeline:(TimelineView *)timeline didProcessButtonWithSuccess:(BOOL)success
{
    
    if (success == YES) {
        NSLog(@"Multiplier up!");
    } else {
        NSLog(@"Multiplier reset.");
    }
    
}

@end
