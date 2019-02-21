//
//  WhackGameViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/6/12.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "WhackGameViewController.h"
#import "WhackGameCenterManager.h"

#define kLifeImageTag 100

#define kGameOverAlert 1
#define kPauseAlert 2

@interface WhackGameViewController ()<GameCenterManagerDelegate>
{
    float score ;
    int life ;
    BOOL gameOver ;
    BOOL paused ;

}
@end

@implementation WhackGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES ;
    self.navigationController.navigationBar.hidden = YES ;
    [self  initGame] ;
    [WhackGameCenterManager sharedGameCenterManager].delegate = self ;
    [self updateLife] ;
    [self performSelector: @selector(spawnCactus)];
    [self performSelector:@selector(spawnCactus) withObject:nil afterDelay:1.0];
}

- (void)initGame {
    gameOver = NO ;
    paused = NO ;
    score = 0 ;
    life = 5 ;
    [self.pausePlay addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside] ;
}

-(void)updateLife
{
    UIImage *lifeImage = [UIImage imageNamed:@"heart.png"];

    for(UIView *view in [self.view subviews])
    {
        if(view.tag == kLifeImageTag)
        {
            [view removeFromSuperview];
        }
    }


    for (int x = 0; x < life; x++)
    {
        UIImageView *lifeImageView = [[UIImageView alloc] initWithImage: lifeImage];
        lifeImageView.tag = kLifeImageTag;

        CGRect frame = lifeImageView.frame;
        frame.origin.x = kScreenWidth - (x * 30);
        frame.origin.y = 20;
        lifeImageView.frame = frame;

        [self.view addSubview: lifeImageView];
    }

    if(life == 0)
    {
        //report score
        [[WhackGameCenterManager sharedGameCenterManager] reportScore: (int64_t)score forCategory:@"com.dragonforged.whackacac.leaderboard"];

        gameOver = YES;
        [UIAlertController rb_showDelayAlertWithTitle:@"Game Over!" message:[NSString stringWithFormat:@"You scored %0.0f points!",score] appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 4;
            [alertMaker setAlertDidShown:^{
            }];
            alertMaker.alertDidDismiss = ^{
            };
        } actionsBlock:NULL] ;
    }
}

- (void)spawnCactus
{
    if(gameOver)
    {
        return;
    }

    if(paused)
    {
        [self performSelector:@selector(spawnCactus) withObject:nil afterDelay:1];
        return;
    }

    int rowToSpawnIn = arc4random()%3;
    int width = SCREEN_WIDTH ;
    int horizontalLocation = (arc4random()%width);

    int cactusSize = arc4random()%3;
    UIImage *cactusImage = nil;

    switch (cactusSize)
    {
        case 0:
            cactusImage = [UIImage imageNamed: @"CactusLarge.png"];
            break;
        case 1:
            cactusImage = [UIImage imageNamed: @"CactusMed.png"];
            break;
        case 2:
            cactusImage = [UIImage imageNamed: @"CactusSmall.png"];
            break;
        default:
            break;
    }

    if(horizontalLocation > SCREEN_WIDTH - cactusImage.size.width)
        horizontalLocation = SCREEN_WIDTH - cactusImage.size.width;

    UIImageView *duneToSpawnBehind = nil;

    switch (rowToSpawnIn)
    {
        case 0:
            duneToSpawnBehind = _duneOne;
            break;
        case 1:
            duneToSpawnBehind = _duneTwo;
            break;
        case 2:
            duneToSpawnBehind = _duneThree;
            break;
        default:
            break;
    }

    float cactusHeight = cactusImage.size.height;
    float cactusWidth = cactusImage.size.width;

    UIButton *cactus = [[UIButton alloc] initWithFrame:CGRectMake(horizontalLocation, (duneToSpawnBehind.frame.origin.y), cactusWidth, cactusHeight)];
    [cactus setImage:cactusImage forState: UIControlStateNormal];
    [cactus addTarget:self action:@selector(cactusHit:) forControlEvents:UIControlEventTouchDown];
    [self.view insertSubview:cactus belowSubview:duneToSpawnBehind];

    [UIView beginAnimations: @"slideInCactus" context:nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.25];
    cactus.frame = CGRectMake(horizontalLocation, (duneToSpawnBehind.frame.origin.y)-cactusHeight/2, cactusWidth, cactusHeight);
    [UIView commitAnimations];

    [self performSelector:@selector(cactusMissed:) withObject:cactus afterDelay:2.0];

}

- (void)cactusMissed:(UIButton *) sender {
    if([sender superview] == nil)
    {
        return;
    }

    if(paused)
    {
        return;
    }


    CGRect frame = sender.frame;
    frame.origin.y += sender.frame.size.height;


    [UIView animateWithDuration:0.1
                          delay:0.0
                        options: UIViewAnimationCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                     animations:^
     {
         sender.frame = frame;
     }
                     completion:^(BOOL finished)
     {
         [sender removeFromSuperview];
         [self performSelector:@selector(spawnCactus) withObject:nil afterDelay:(arc4random()%3) + .5];
         life--;
         [self updateLife];
     }];
}
- (void)cactusHit:(UIButton *) sender
{
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options: UIViewAnimationCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                     animations:^
     {
         [sender setAlpha: 0];
     }
                     completion:^(BOOL finished)
     {
         [sender removeFromSuperview];
     }];

    score++;
    [self displayNewScore: score];

    [self performSelector:@selector(spawnCactus) withObject:nil afterDelay:(arc4random()%3) + .5];

}

- (void)displayNewScore:(float)updatedScore;
{
    int scoreInt = score;

    if(scoreInt % 10 == 0 && score <= 50)
    {
        [self spawnCactus];
    }

    self.scoreLabel.text = [NSString stringWithFormat: @"%06.0f", updatedScore];
}

- (void)pause
{
    paused = YES;

    [UIAlertController rb_showDelayAlertWithTitle:@"" message:@"Game Paused!" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.toastStyleDuration = 3;
        [alertMaker setAlertDidShown:^{
        }];
        alertMaker.alertDidDismiss = ^{
        };
    } actionsBlock:NULL] ;
}

-(void)gameCenterScoreReported:(NSError *)error;
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
