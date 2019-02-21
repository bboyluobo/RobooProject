//
//  WhackACacViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/6/12.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "WhackACacViewController.h"
#import "WhackGameCenterManager.h"
#import "WhackGameViewController.h"
@interface WhackACacViewController ()<GameCenterManagerDelegate, GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *achievementsBt;
@property (weak, nonatomic) IBOutlet UIButton *scoresBt;
@property (weak, nonatomic) IBOutlet UIButton *playBt;

@end

@implementation WhackACacViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[WhackGameCenterManager sharedGameCenterManager] setDelegate: self];
    [[WhackGameCenterManager sharedGameCenterManager] authenticateLocalUser];
    [self.playBt addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.scoresBt addTarget:self action:@selector(leaderboards:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.achievementsBt addTarget:self action:@selector(achievements:) forControlEvents:UIControlEventTouchUpInside] ;
}

- (void)play:(UIButton *)button {
    WhackGameViewController *gameVC = [[WhackGameViewController alloc] init];
    [self.navigationController pushViewController:gameVC animated:YES];
}

- (void)leaderboards:(UIButton *)button {
    GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
    if(leaderboardViewController == nil)
    {
        NSLog(@"Unable to create leaderboard view controller");
        return;
    }

    leaderboardViewController.category = @"com.dragonforged.whackacac.leaderboard";
    leaderboardViewController.timeScope = GKLeaderboardTimeScopeAllTime;
    leaderboardViewController.leaderboardDelegate = self;

    [self presentViewController:leaderboardViewController animated:YES completion:nil] ;
}

- (void)achievements:(UIButton *)button {
    GKAchievementViewController *achievementViewController = [[GKAchievementViewController alloc] init];

    if(achievementViewController == nil)
    {
        NSLog(@"Unable to create achivement view controller");
        return;
    }

    achievementViewController.achievementDelegate = self;

    [self presentViewController:achievementViewController animated:YES completion:nil] ;
}

#pragma mark -
#pragma mark GameCenterManagerDelegate

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark GKLeaderboardViewControllerDelegate

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark GKAchievementViewControllerDelegate

- (void)gameCenterLoggedIn:(NSError*)error
{
    if(error != nil)
    {
        NSLog(@"An error occurred trying to log into Game Center: %@", [error localizedDescription]);
    }

    else
    {
        NSLog(@"Successfully logged into Game Center!");
    }
}

-(void)gameCenterScroreReported:(NSError *)error;
{
    if(error != nil)
    {
        NSLog(@"An error occurred trying to report a score to Game Center: %@", [error localizedDescription]);
    }

    else
    {
        NSLog(@"Successfully submitted score");
    }
}

//支持旋转
-(BOOL)shouldAutorotate{
    return YES;
}
//
//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}

//一开始的方向  很重要
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
