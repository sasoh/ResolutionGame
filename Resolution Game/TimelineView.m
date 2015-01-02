//
//  TimelineView.m
//  Resolution Game
//
//  Created by Alexander Popov on 1/2/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import "TimelineView.h"

@interface TimelineView () {
    //! @brief All segments
    NSMutableArray *_segmentsArray;
    
    //! @brief Segments that will be removed
    NSMutableArray *_cleanupArray;
    
    //! @brief Currently centered segment
    UIView *_currentSegment;
    
    //! @brief Current segment index in level info array
    int _currentSegmentIndex;
    
    //! @brief Rightmost point of segments, will be used to determine if a new one should be spawned
    CGFloat _rightmostPosition;
    
    //! @brief Current offset
    double _currentOffset;

    //! @brief Current segment is marked if the correct button was pressed, will be used to restrict to only 1 correct answer per segment
    BOOL _segmentMarked;

    //! @brief Level configuration
    NSDictionary *_levelInfo;
    
    //! @brief Level scroll speed, px/sec
    CGFloat _speed;
    
    //! @brief Score multiplier
    CGFloat _scoreMultiplier;
}

//! @brief Generates first segments before the game begins
- (void)createInitialSegments;

//! @brief Updates positions of segments
- (void)updateSegmentPositions:(NSTimeInterval)dt;

//! @brief Cleans segments that are outside the view
- (void)cleanUnusedSegments;

//! @brief Helper function that constructs new segments
- (void)generateSegmentWithTag:(int)tag andLength:(CGFloat)length;

//! @brief Spawns next segment from list
- (void)loadNextSegment;

//! @brief Increases multiplier to next level
- (void)increaseMultiplier;

@end

@implementation TimelineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setupForLevel:(NSDictionary *)levelInfo
{
    
    _segmentsArray = [[NSMutableArray alloc] init];
    _cleanupArray = [[NSMutableArray alloc] init];
    _rightmostPosition = [self frame].size.width / 2; // initial position is center of view
    _currentSegment = nil;
    _currentSegmentIndex = 0;
    _segmentMarked = NO;
    _levelInfo = levelInfo;
    _scoreMultiplier = 0.5f; // on success it's doubled and that gives multiplier 1 for the first segment
    _speed = [_levelInfo[@"speed"] floatValue];
    
    [self setClipsToBounds:YES];
    
    [self createInitialSegments];
    
}

- (void)update:(NSTimeInterval)dt
{
    
    [self updateSegmentPositions:dt];
    [self cleanUnusedSegments];
    
}

- (void)createInitialSegments
{
    
    const static CGFloat offset = 5.0f; // some additional pixels for the check so no edge is visible
    while (_rightmostPosition < [self frame].size.width + offset) {
        [self loadNextSegment];
    }
    
}

- (void)loadNextSegment
{
    
    NSArray *parts = _levelInfo[@"parts"];
    if (_currentSegmentIndex < [parts count]) {
        NSDictionary *segmentInfo = parts[_currentSegmentIndex];
        ++_currentSegmentIndex;
        
        [self generateSegmentWithTag:[segmentInfo[@"type"] intValue] andLength:[segmentInfo[@"length"] floatValue]];
    }

}

- (void)generateSegmentWithTag:(int)tag andLength:(CGFloat)length
{
    
    NSArray *colors = @[
                        [UIColor redColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor yellowColor]
                        ];
    
    const static CGFloat baseBorder = 2.0f;
    UIView *segmentBase = [[UIView alloc] initWithFrame:CGRectMake(_rightmostPosition, 0.0f, length, [self frame].size.height)];
    [segmentBase setBackgroundColor:[UIColor blackColor]];
    [segmentBase setTag:tag];
    [self addSubview:segmentBase];
    [_segmentsArray addObject:segmentBase];
    
    _rightmostPosition = [segmentBase frame].origin.x + [segmentBase frame].size.width;
    
    UIView *segment = [[UIView alloc] initWithFrame:CGRectMake(baseBorder / 2, baseBorder, length - baseBorder, [self frame].size.height - 2 * baseBorder)];
    [segment setBackgroundColor:colors[tag - 1]];
    [segmentBase addSubview:segment];
    
}

- (void)increaseMultiplier
{
    
    // simple progression
    _scoreMultiplier *= 2;
    
}

- (void)updateSegmentPositions:(NSTimeInterval)dt
{
    
    CGFloat distance = _speed * dt;
    
    _currentOffset += distance;
    _rightmostPosition -= distance;
    
    // check for end level
    if (_rightmostPosition <= [self frame].size.width / 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTimelineViewLevelEndNotification object:nil];
        return;
    }
    
    // infinite random generation for now
    const static CGFloat offset = 5.0f; // some additional pixels for the check so no edge is visible
    if (_rightmostPosition < [self frame].size.width + offset) {
        [self loadNextSegment];
    }

    for (UIView *sv in _segmentsArray) {
        CGRect tempRect = [sv frame];
        tempRect.origin.x -= distance;
        [sv setFrame:tempRect];
        
        CGFloat midPosition = [self frame].size.width / 2;
        if (midPosition >= tempRect.origin.x && midPosition <= tempRect.origin.x + tempRect.size.width) {
            if ( _currentSegment != sv) {
                _currentSegment = sv;
                
                if (_segmentMarked == NO) {
                    // user failed to answer in time
                    _scoreMultiplier = 0.5f;
                    NSDictionary *result = @{
                                             @"success": @(NO)
                                             };
                    
                    [_delegate timeline:self didProcessButtonWithResult:result];
                }
                
                _segmentMarked = NO;
            }
        }
    }
    
}

- (void)cleanUnusedSegments
{
    
    for (UIView *sv in _cleanupArray) {
        [sv removeFromSuperview];
    }
    
    [_segmentsArray removeObjectsInArray:_cleanupArray];
    [_cleanupArray removeAllObjects];
    
}

- (void)didPressButtonWithIndex:(int)index
{
    
    BOOL success = NO;
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    if (index == (int)[_currentSegment tag] && _segmentMarked == NO) {
        _segmentMarked = YES;
        success = YES;
        
        // score from tiles equal for now
        int tileScore = 100;
        result[@"score"] = @(tileScore);
        
        [self increaseMultiplier];
    }
    result[@"success"] = @(success);
    
    if (success == NO) {
        // reset multiplier
        _scoreMultiplier = 0.5f;
    }
    
    result[@"multiplier"] = @(_scoreMultiplier);
    [_delegate timeline:self didProcessButtonWithResult:result];
    
}

@end
