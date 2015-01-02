//
//  ViewController.m
//  Resolution Game
//
//  Created by Alexander Popov on 1/1/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    IBOutletCollection(UIButton) NSArray *_buttons;
}

@end

@implementation ViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    
    // update button background images to a resizeable version
    UIImage *backgroundImage = [UIImage imageNamed:@"sprite_button_background.png"];
    UIImage *resizeableImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(4.0f, 4.0f, 4.0f + 5.0f, 4.0f + 5.0f)];
    for (UIButton *button in _buttons) {
        [button setBackgroundImage:resizeableImage forState:UIControlStateNormal];
    }

}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

@end
