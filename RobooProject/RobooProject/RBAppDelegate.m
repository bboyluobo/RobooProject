//
//  AppDelegate.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/14.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBAppDelegate.h"
#import "RBTabBarController.h"
#import "YYFPSLabel.h"
#import "AdvertiseHelper.h"
#import "RBIntroductoryPagesHelper.h"
#import "RBWKWebViewController.h"
@interface RBAppDelegate ()

@end

@implementation RBAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.rootViewController = [[RBTabBarController alloc] init];
    
    NSArray *imgArray = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537187749135&di=50858f8bc6572b024c05df373793e099&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D6738273553fbb2fb342b581a7f4b2043%2F37d85266d016092495ce8d73d20735fae7cd3497.jpg"];

    // 欢迎视图
    [RBIntroductoryPagesHelper showIntroductoryPageView:@[@"rbImage1.jpg", @"rbImage2.jpg", @"rbImage3.jpg", @"rbImage4.jpg"]];
    // 刷新率
    [self.window addSubview:[[YYFPSLabel alloc] initWithFrame:CGRectMake(20, 70, 0, 0)]];
    //广告页
    [AdvertiseHelper showAdvertiserView:imgArray] ;
    [self setupShortcutItem];
    return YES;
}


/**
 自定义快捷图标 3DTouch
 */
- (void)setupShortcutItem{
    UIApplicationShortcutIcon *searchShortcutIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove];
    UIApplicationShortcutItem *searchShortcutItem = [[UIApplicationShortcutItem alloc] initWithType:@"search" localizedTitle:@"预演" localizedSubtitle:@"常用功能" icon:searchShortcutIcon userInfo:nil];

    // 自定义图标
    UIApplicationShortcutIcon *attentionShortcutIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"tabBar_essence_click_icon"];
    UIApplicationShortcutItem *attentionShortcutItem = [[UIApplicationShortcutItem alloc] initWithType:@"attention" localizedTitle:@"基础" localizedSubtitle:@"object-C魅力" icon:attentionShortcutIcon userInfo:nil];

    UIApplicationShortcutIcon *rooboShortcutIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove];
    UIApplicationShortcutItem *rooboShortcutItem = [[UIApplicationShortcutItem alloc] initWithType:@"roobo" localizedTitle:@"不吃兔子的萝卜" localizedSubtitle:@"个人网址" icon:rooboShortcutIcon userInfo:nil];

    // 系统低于9.0是没有这个属性的
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(shortcutItems)]) {
        [UIApplication sharedApplication].shortcutItems = @[searchShortcutItem, attentionShortcutItem, rooboShortcutItem];
    }
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    //MARK:  快捷图标点击 回调事件
    if ([shortcutItem.type isEqualToString:@"roobo"]) {
        RBWKWebViewController * wkWebVC = [[RBWKWebViewController alloc]init];
         RBTabBarController * tabBar = (RBTabBarController *)self.window.rootViewController;
        [tabBar setSelectedIndex:3];
        [tabBar.selectedViewController pushViewController:wkWebVC animated:YES];
        NSLogFunc;
    }
    DLog(@"点击了%@",shortcutItem.localizedTitle);
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.scheme isEqualToString:@"RobooProjectWidget"]) {
        
        return YES;
    } else {
        return NO;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - getter
- (UIWindow *)window
{
    if(!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor RandomColor];
        [_window makeKeyAndVisible];
    }
    return _window;
}

@end
