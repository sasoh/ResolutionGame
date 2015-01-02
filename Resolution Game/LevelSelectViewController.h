//
//  LevelSelectViewController.h
//  Resolution Game
//
//  Created by Alexander Popov on 1/2/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelSelectViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UIView *_loadingView;
    IBOutlet UITableView *_tableView;
}

@end
