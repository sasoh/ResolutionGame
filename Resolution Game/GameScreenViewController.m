//
//  GameScreenViewController.m
//  Resolution Game
//
//  Created by Alexander Popov on 1/1/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import "GameScreenViewController.h"

@interface GameScreenViewController () {
    IBOutletCollection(UIButton) NSArray *_actionButtons;
}

@end

@implementation GameScreenViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)viewDidAppear:(BOOL)animated
{
    
    NSArray *colors = @[
                        [UIColor redColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor yellowColor]
                        ];
    for (UIButton *button in _actionButtons) {
        [button setBackgroundColor:colors[(int)[button tag] - 1]];
    }
    
    [_gameManager setup];
    [_gameManager start];
    
}

- (IBAction)didPressButton:(id)sender
{
    
    [_gameManager didPressButtonWithIndex:(int)[sender tag]];
    
}

- (IBAction)didPressBackButton:(id)sender
{
    
    [[self navigationController] popViewControllerAnimated:YES];
    
}

@end
