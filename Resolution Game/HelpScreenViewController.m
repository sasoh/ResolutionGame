//
//  HelpScreenViewController.m
//  Resolution Game
//
//  Created by Alexander Popov on 1/1/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import "HelpScreenViewController.h"

@interface HelpScreenViewController ()

@end

@implementation HelpScreenViewController

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

- (IBAction)backButtonPressed:(id)sender
{	
    
    [[self navigationController] popViewControllerAnimated:YES];
    
}

@end
