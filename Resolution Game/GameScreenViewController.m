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
    IBOutlet UIView *_finishedView;
    IBOutlet UIButton *_finishedBackButton;
}

- (void)showEndLevelView;

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

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [_finishedView setHidden:YES];
    
    // update button background image to a resizeable version
    UIImage *backgroundImage = [UIImage imageNamed:@"sprite_button_background.png"];
    UIImage *resizeableImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(4.0f, 4.0f, 4.0f + 5.0f, 4.0f + 5.0f)];
    [_finishedBackButton setBackgroundImage:resizeableImage forState:UIControlStateNormal];
    
    NSArray *colors = @[
                        [UIColor redColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor yellowColor]
                        ];
    for (UIButton *button in _actionButtons) {
        [button setBackgroundColor:colors[(int)[button tag] - 1]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showEndLevelView) name:kTimelineViewLevelEndNotification object:nil];
    
    [_gameManager setLevelInfo:_levelInfo];
    [_gameManager setup];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [_gameManager start];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [_gameManager stop];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)showEndLevelView
{
    
    [_gameManager stop];
    
    [_finishedView setHidden:NO];
    
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
