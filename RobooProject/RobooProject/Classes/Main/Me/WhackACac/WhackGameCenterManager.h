//
//  WhackGameCenterManager.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/6/12.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXTAlertController.h"


@protocol GameCenterManagerDelegate <NSObject>

@optional
- (void)gameCenterLoggedIn:(NSError *)error;
- (void)gameCenterScoreReported:(NSError *)error;
- (void)scoreDataUpdated: (NSArray *)scores error:(NSError *)error;
@end

@interface WhackGameCenterManager : NSObject
{
    id <NSObject, GameCenterManagerDelegate> delegate;
}

@property(nonatomic, strong) id <GameCenterManagerDelegate, NSObject> delegate;

+ (WhackGameCenterManager *)sharedGameCenterManager;
- (void)authenticateLocalUser;
- (void)authenticateLocalUseriOSSix;
- (void)reportScore:(int64_t)score forCategory:(NSString*)category;

@end
