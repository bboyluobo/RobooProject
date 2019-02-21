//
//  WhackGameCenterManager.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/6/12.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "WhackGameCenterManager.h"


@implementation WhackGameCenterManager

@synthesize delegate;

static WhackGameCenterManager* _instance = nil ;

+ (instancetype)sharedGameCenterManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {

        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
            return _instance; // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (void)callDelegateOnMainThread:(SEL)selector withArg:(id)arg error:(NSError*)error
{
    dispatch_async(dispatch_get_main_queue(), ^(void)
                   {
                       [self callDelegate: selector withArg: arg error: error];
                   });
}

- (void)callDelegate: (SEL)selector withArg: (id)arg error:(NSError*)error
{
    assert([NSThread isMainThread]);

    if(delegate == nil)
    {
        NSLog(@"Game Center Manager Delegate has not been set");
        return;
    }

    if([delegate respondsToSelector: selector])
    {
        if(arg != NULL)
        {

            //Since this is an unknown selector the state of its memory retention can't be determined
            //For this single performSelector line the possible leak warning is ignored this can be done
            //because any methods passed into it are part of the protocol and memory issues can be addressed
            //at the source. The clang diagnostic code is specifically left out of the chapter for clarity sake.

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector: selector withObject: arg withObject: error];
#pragma clang diagnostic pop

        }

        else
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector: selector withObject: error];
#pragma clang diagnostic pop
        }
    }

    else
    {
        NSLog(@"Unable to find delegate method '%s' in class %@", sel_getName(selector), [delegate class]);
    }
}


#pragma mark -
#pragma mark Authentication

- (void) authenticateLocalUser
{
    if([GKLocalPlayer localPlayer].authenticated == NO)
    {
        [[GKLocalPlayer localPlayer] setAuthenticateHandler:^(UIViewController * _Nullable viewController, NSError * _Nullable error) {
            if(error != nil)
            {
                if([error code] == GKErrorNotSupported)
                {
                    [UIAlertController rb_showDelayAlertWithTitle:@"Error" message:@"This device does not support Game Center" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                        alertMaker.toastStyleDuration = 2;
                        [alertMaker setAlertDidShown:^{
                        }];
                        alertMaker.alertDidDismiss = ^{
                        };
                    } actionsBlock:NULL] ;
                
                }

                else if([error code] == GKErrorCancelled)
                {
                    [UIAlertController rb_showDelayAlertWithTitle:@"Error" message:@"This device has failed login too many times from the app, you will need to login from the Game Center.app" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                        alertMaker.toastStyleDuration = 2;
                        [alertMaker setAlertDidShown:^{
                        }];
                        alertMaker.alertDidDismiss = ^{
                        };
                    } actionsBlock:NULL] ;
                }

                else
                {
                    [UIAlertController rb_showDelayAlertWithTitle:@"Error" message:[error localizedDescription] appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                        alertMaker.toastStyleDuration = 2;
                        [alertMaker setAlertDidShown:^{
                        }];
                        alertMaker.alertDidDismiss = ^{
                        };
                    } actionsBlock:NULL] ;
                }
                return;
            }
            [self callDelegateOnMainThread: @selector(gameCenterLoggedIn:) withArg: NULL error: error];
            [self submitAllSavedScores];

        }] ;
    }
}

-(void)authenticateLocalUseriOSSix
{
    if([GKLocalPlayer localPlayer].authenticateHandler == nil)
    {
        [[GKLocalPlayer localPlayer] setAuthenticateHandler:^(UIViewController *viewController, NSError *error)
         {
             if(error != nil)
             {
                 if([error code] == GKErrorNotSupported)
                 {
                     [UIAlertController rb_showDelayAlertWithTitle:@"Error" message:@"This device does not support Game Center" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                         alertMaker.toastStyleDuration = 2;
                         [alertMaker setAlertDidShown:^{
                         }];
                         alertMaker.alertDidDismiss = ^{
                         };
                     } actionsBlock:NULL] ;

                 }

                 else if([error code] == GKErrorCancelled)
                 {
                     [UIAlertController rb_showDelayAlertWithTitle:@"Error" message:@"This device has failed login too many times from the app, you will need to login from the Game Center.app" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                         alertMaker.toastStyleDuration = 2;
                         [alertMaker setAlertDidShown:^{
                         }];
                         alertMaker.alertDidDismiss = ^{
                         };
                     } actionsBlock:NULL] ;

                 }

                 else
                 {
                     [UIAlertController rb_showDelayAlertWithTitle:@"Error" message:[error localizedDescription] appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                         alertMaker.toastStyleDuration = 2;
                         [alertMaker setAlertDidShown:^{
                         }];
                         alertMaker.alertDidDismiss = ^{
                         };
                     } actionsBlock:NULL] ;

                 }
             }

             else
             {
                 if(viewController != nil)
                 {
//                     [(UIViewController *)delegate presentModalViewController:viewController animated:YES];
                     [(UIViewController *)delegate presentViewController:viewController animated:YES completion:nil] ;
                 }

                 [self submitAllSavedScores];
             }
         }];
    }

}

#pragma mark -
#pragma mark Scores

- (void)reportScore:(int64_t)score forCategory:(NSString*)category
{
    GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:category];
    scoreReporter.value = score;
    [GKScore reportScores:@[scoreReporter] withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil)
        {
            NSData* savedScoreData = [NSKeyedArchiver archivedDataWithRootObject:scoreReporter];
            [self storeScoreForLater: savedScoreData];
        }

        [self callDelegateOnMainThread:@selector(gameCenterScoreReported:) withArg:NULL error:error];
    }] ;

}

- (void)storeScoreForLater:(NSData *)scoreData;
{
    NSMutableArray *savedScoresArray = [[NSMutableArray alloc] initWithArray: [[NSUserDefaults standardUserDefaults] objectForKey:@"savedScores"]];
    [savedScoresArray addObject: scoreData];
    [[NSUserDefaults standardUserDefaults] setObject:savedScoresArray forKey:@"savedScores"];
}

-(void)submitAllSavedScores
{
    NSMutableArray *savedScoreArray = [[NSMutableArray alloc] initWithArray: [[NSUserDefaults standardUserDefaults] objectForKey:@"savedScores"]];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: @"savedScores"];

    for(NSData *scoreData in savedScoreArray)
    {
        GKScore *scoreReporter = [NSKeyedUnarchiver unarchiveObjectWithData: scoreData];
        [GKScore reportScores:@[scoreReporter] withCompletionHandler:^(NSError * _Nullable error) {
            if (error != nil)
            {
                NSData* savedScoreData = [NSKeyedArchiver archivedDataWithRootObject:scoreReporter];
                [self storeScoreForLater: savedScoreData];
            }

            else
            {
                NSLog(@"Successfully submitted scores that were pending submission");
                [self callDelegateOnMainThread:@selector(gameCenterScoreReported:) withArg:NULL error:error];
            }
        }] ;
    }
}

@end
