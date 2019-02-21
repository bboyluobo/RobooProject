//
//  RBCoreAnimationViewController.m
//  RobooProject
//
//  Created by 物联网美天科技 on 2018/9/10.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

#import "RBCoreAnimationViewController.h"
#import "RBCALayerBaseViewController.h"
#import "RBCALayerYSDHViewController.h"
#import "RBCACAClockViewController.h"
#import "RBCAKeyFrameViewController.h"
@interface RBCoreAnimationViewController ()

@end

@implementation RBCoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RBWordArrowItem *item0 = [RBWordArrowItem itemWithTitle:@"CALayer基本使用, CALayer新建图层" subTitle:nil];
    item0.destVc = [RBCALayerBaseViewController class];
    RBWordArrowItem *item1 = [RBWordArrowItem itemWithTitle:@"CALayer隐式动画, 非根Layer默认有动画" subTitle:nil];
    item1.destVc = [RBCALayerYSDHViewController class];
    RBWordArrowItem *item2 = [RBWordArrowItem itemWithTitle:@"时钟" subTitle:@"anchorPoint&position"];
    item2.destVc = [RBCACAClockViewController class];
    RBWordArrowItem *itme3 = [RBWordArrowItem itemWithTitle:@"关键帧动画CAKeyFrameA" subTitle:@"Value&path"];
    itme3.destVc = [RBCAKeyFrameViewController class];

    RBItemSection *section0 = [RBItemSection sectionWithItems:@[item0,item1,item2,itme3] andHeaderTitle:nil footerTitle:nil];
     [self.sections addObject:section0];
}

#pragma mark - RBNavUIBaseViewControllerDataSource

/** 导航条左边的按钮 */
- (UIImage *)rbNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(RBNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];

    return [UIImage imageNamed:@"NavgationBar_blue_back"];
}

#pragma mark - RBNavUIBaseViewControllerDelegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(RBNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
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
