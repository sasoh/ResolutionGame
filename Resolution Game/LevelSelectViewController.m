//
//  LevelSelectViewController.m
//  Resolution Game
//
//  Created by Alexander Popov on 1/2/15.
//  Copyright (c) 2015 -. All rights reserved.
//

#import "LevelSelectViewController.h"
#import "GameScreenViewController.h"

@interface LevelSelectViewController () {
    NSArray *_levelsArray;
    StageView *_stageView;
    int _selectedIndex;
}

- (void)loadLevelInfo;
- (void)loadStage:(StageViewType)type;

@end

@implementation LevelSelectViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // initial value should be stage 1
    [self loadStage:StageViewTypePreparation];

}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    UIViewController *vc = [segue destinationViewController];
    if ([vc isMemberOfClass:[GameScreenViewController class]] == YES) {
        if (_selectedIndex >= 0 && _selectedIndex < [_levelsArray count]) {
            [(GameScreenViewController *)vc setLevelInfo:_levelsArray[_selectedIndex]];
        } else {
            NSLog(@"Trying to access an array element out of bounds.");
        }
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    _selectedIndex = -1;
    
}

- (void)loadLevelInfo
{
    
    [_loadingView setHidden:NO];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Level Load Queue",NULL);
    dispatch_async(myQueue, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *bundleURL = [[NSBundle mainBundle] bundleURL];
        NSString *levelDirectory = [NSString stringWithFormat:@"%@/Levels", [bundleURL absoluteString]];
        NSArray *contents = [fileManager contentsOfDirectoryAtURL:[NSURL URLWithString:levelDirectory]
                                       includingPropertiesForKeys:@[]
                                                          options:NSDirectoryEnumerationSkipsHiddenFiles
                                                            error:nil];
        
        NSMutableArray *fileList = [[NSMutableArray alloc] init];
        for (NSURL *fileUrl in contents) {
            NSDictionary *loadedFile = [NSDictionary dictionaryWithContentsOfURL:fileUrl];
            [fileList addObject:loadedFile];
        }
        _levelsArray = [[NSArray alloc] initWithArray:fileList];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_loadingView setHidden:YES];
        });
    });
    
}

- (IBAction)didPressBackButton:(id)sender
{
    
    [[self navigationController] popViewControllerAnimated:YES];
    
}

- (IBAction)didPressStageButton:(id)sender
{
    
    int tag = (int)[sender tag];
    
    StageViewType targetStage = StageViewTypeNone;
    
    if (tag == 1) {
        targetStage = StageViewTypePreparation;
    } else if (tag == 2) {
        targetStage = StageViewTypeSiege;
    } else if (tag == 3) {
        targetStage = StageViewTypeRepair;
    }
    
    [self loadStage:targetStage];
    
}

- (void)loadStage:(StageViewType)type
{
    
    // remove any existing stage views
    while ([[_stageContainerView subviews] count] > 0) {
        [[[_stageContainerView subviews] lastObject] removeFromSuperview];
    }
    
    // create new stage
    if (type > StageViewTypeNone && type <= StageViewTypeRepair) {
        _stageView = [StageViewFactory stageViewWithType:type andSuperView:_stageContainerView andDelegate:self];
    } else {
        NSLog(@"Stage view type out of bounds.");
    }
    
    [self loadLevelInfo];
    
}

#pragma mark - Stage view delegate

- (void)stageView:(StageView *)view didPressButtonWithIndex:(int)index
{

    _selectedIndex = index;
    
    // segue from here to preserve correct order of operations
    [self performSegueWithIdentifier:@"gameSegue" sender:nil];
    
    
}

@end
