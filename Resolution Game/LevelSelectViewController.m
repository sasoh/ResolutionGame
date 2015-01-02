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
    int _selectedIndex;
}

- (void)loadLevelInfo;

@end

@implementation LevelSelectViewController

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
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
 
    [_loadingView setHidden:NO];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [self loadLevelInfo];
    
}

- (void)loadLevelInfo
{
    
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
            [_tableView reloadData];
            [_loadingView setHidden:YES];
        });
    });
    
}

- (IBAction)didPressBackButton:(id)sender
{
    
    [[self navigationController] popViewControllerAnimated:YES];
    
}

#pragma mark - Table view methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_levelsArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"levelSelectCellIdentifier"];
    
    NSDictionary *levelInfo = _levelsArray[[indexPath row]];
    [[cell textLabel] setText:levelInfo[@"title"]];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _selectedIndex = (int)[indexPath row];
    
    // segue from here to preserve correct order of operations
    [self performSegueWithIdentifier:@"gameSegue" sender:nil];
    
}

@end
