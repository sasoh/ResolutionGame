//
//  StagePreparation.m
//  Resolution Game
//
//  Created by Alexander Popov on 1/4/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import "StageViewPreparation.h"

@implementation StageViewPreparation

- (IBAction)didPressButton:(id)sender
{
    
    [[self delegate] stageView:self didPressButtonWithIndex:(int)[sender tag]];
    
}

@end
