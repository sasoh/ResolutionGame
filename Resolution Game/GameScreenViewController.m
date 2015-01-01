//
//  GameScreenViewController.m
//  Resolution Game
//
//  Created by Alexander Popov on 1/1/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import "GameScreenViewController.h"
#import "GameManager.h"

@interface GameScreenViewController () {
    GameManager *_gameManager;
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
    
    _gameManager = [[GameManager alloc] init];
    [_gameManager setView:_mapView];
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
