//
//  RBRequestBaseViewController.h
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBTextViewController.h"
#import <Reachability.h>

@class RBRequestBaseViewController;
@protocol RBRequestBaseViewControllerDelegate <NSObject>

@optional
#pragma mark - 网络监听
/*
 NotReachable = 0,
 ReachableViaWiFi = 2,
 ReachableViaWWAN = 1,
 ReachableVia2G = 3,
 ReachableVia3G = 4,
 ReachableVia4G = 5,
 */
- (void)networkStatus:(NetworkStatus)networkStatus inViewController:(RBRequestBaseViewController *)inViewController;

@end

@interface RBRequestBaseViewController : RBTextViewController<RBRequestBaseViewControllerDelegate>

#pragma mark - 加载框

- (void)showLoading;

- (void)dismissLoading;

@end
