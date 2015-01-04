//
//  LevelSelectViewController.h
//  Resolution Game
//
//  Created by Alexander Popov on 1/2/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StageViewFactory.h"

@interface LevelSelectViewController : UIViewController <StageViewDelegate> {
    IBOutlet UIView *_loadingView;
    IBOutlet UIView *_stageContainerView;
}

@end
