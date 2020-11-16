//
//  RBTabBarController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBTabBarController.h"
#import "RBNavigationController.h"
#import "RBRehearseViewController.h"
#import "RBHomeViewController.h"
#import "RBMessageViewController.h"
#import "RBMeViewController.h"
#import "RBCasesViewController.h"

@interface RBTabBarController ()<UITabBarControllerDelegate>

@end

@implementation RBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor redColor];
//    [self setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, -3)] forKeyPath:RBKeyPath(self, titlePositionAdjustment)];
    [self addTabarItems] ;
    [self addChildViewControllers];
    self.delegate = self;
}

- (void)addChildViewControllers
{
    RBNavigationController *rehearseNavi = [[RBNavigationController alloc] initWithRootViewController:[[RBRehearseViewController alloc] init]];

    RBNavigationController *homeNavi = [[RBNavigationController alloc] initWithRootViewController:[[RBHomeViewController alloc] init]];

    RBNavigationController *messageNavi = [[RBNavigationController alloc] initWithRootViewController:[[RBMessageViewController alloc] init]];

    RBNavigationController *meNavi = [[RBNavigationController alloc] initWithRootViewController:[[RBMeViewController alloc] init]];

    RBNavigationController *casesNavi = [[RBNavigationController alloc] initWithRootViewController:[[RBCasesViewController alloc] init]];

    self.viewControllers = @[rehearseNavi, homeNavi, messageNavi, casesNavi, meNavi];

}

- (void)addTabarItems
{

    NSDictionary *homeTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"基础",
                                                 CYLTabBarItemImage : @"tabBar_essence_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_essence_click_icon",
                                                 };

    NSDictionary *rehearseTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"预演",
                                                  CYLTabBarItemImage : @"tabBar_friendTrends_icon",
                                                  CYLTabBarItemSelectedImage : @"tabBar_friendTrends_click_icon",
                                                  };
    NSDictionary *messageTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"实例",
                                                 CYLTabBarItemImage : @"tabBar_new_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_new_click_icon",
                                                 };
    NSDictionary *meTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"分享",
                                                  CYLTabBarItemImage : @"tabBar_me_icon",
                                                  CYLTabBarItemSelectedImage : @"tabBar_me_click_icon"
                                                  };
    NSDictionary *casesTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"更多",
                                                 CYLTabBarItemImage : @"tabbar_discover",
                                                 CYLTabBarItemSelectedImage : @"tabbar_discover_highlighted"
                                                 };
    self.tabBarItemsAttributes = @[    rehearseTabBarItemsAttributes,
                                       homeTabBarItemsAttributes,
                                       messageTabBarItemsAttributes,
                                       casesTabBarItemsAttributes,
                                       meTabBarItemsAttributes
                                       ];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
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
