//
//  RBIntroductoryPagesHelper.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/5/21.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBIntroductoryPagesHelper.h"
#import "RBIntroductoryPagesView.h"
@interface RBIntroductoryPagesHelper ()

@property (weak, nonatomic) UIWindow *curWindow;

@property (strong, nonatomic) RBIntroductoryPagesView * curIntroductoryPagesView ;

@end

@implementation RBIntroductoryPagesHelper

static RBIntroductoryPagesHelper *shareInstance_ = nil;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance_ = [[RBIntroductoryPagesHelper alloc] init];
    });

    return shareInstance_;
}

+ (void)showIntroductoryPageView:(NSArray<NSString *> *)imageArray
{
    if (![RBIntroductoryPagesHelper shareInstance].curIntroductoryPagesView) {
        [RBIntroductoryPagesHelper shareInstance].curIntroductoryPagesView = [RBIntroductoryPagesView pagesViewWithFrame:[UIScreen mainScreen].bounds images:imageArray];
    }

    [RBIntroductoryPagesHelper shareInstance].curWindow = [UIApplication sharedApplication].keyWindow;
    [[RBIntroductoryPagesHelper shareInstance].curWindow addSubview:[RBIntroductoryPagesHelper shareInstance].curIntroductoryPagesView];
}

@end
