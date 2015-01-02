//
//  GameScreenViewController.h
//  Resolution Game
//
//  Created by Alexander Popov on 1/1/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import "ViewController.h"
#import "GameManagerView.h"

//! @brief Game view controller
//! @details Contains UI & game view
@interface GameScreenViewController : ViewController {
    IBOutlet UIView *_mainView;
    IBOutlet GameManagerView *_gameManager;
}

@property (nonatomic, strong) NSDictionary *levelInfo;

@end
